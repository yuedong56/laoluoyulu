//
//  LYAppDelegate.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LYAppDelegate.h"
#import "LeftMenuViewController.h"
#import "CenterViewController.h"
#import "PlayerViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation LYAppDelegate

/** 初始化抽屉结构 */
- (void)initDrawerViewController
{
    self.leftNavCol = [[UINavigationController alloc] initWithRootViewController:[LeftMenuViewController new]];
    MenuModel *menuMol = [[[LYDataManager instance] selectMenuList] objectAtIndex:0];
    self.centerVC = [[CenterViewController alloc] initWithMenu:menuMol];
    self.centerNavCol = [[UINavigationController alloc] initWithRootViewController:self.centerVC];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.centerNavCol
                                                            leftDrawerViewController:self.leftNavCol];
    [self.drawerController setMaximumLeftDrawerWidth:LeftMenuWidth];
    [self.drawerController setMaximumRightDrawerWidth:RightMenuWidth];
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible)
    {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.drawerController.showsShadow = NO;
    //抽屉特殊效果
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    self.window.rootViewController = self.drawerController;
}

- (void)showLeftSideView
{
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)showRightSideView
{
    [self.drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

/** 初始化播放器界面 */
- (void)initPlayerView
{
    if (!self.playerView) {
        self.playerView = [[PlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.playerView.hidden = YES;
        [self.window addSubview:self.playerView];
    }
}

/** 初始化播放定时器 */
- (void)startPlayerTimer
{
    if ([self.instanceTimer isValid]) {
        [self.instanceTimer invalidate];
        self.instanceTimer = nil;
    }
    self.instanceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handlePlayerTimerEvent:) userInfo:nil repeats:YES];
}

#pragma mark - 播放定时器事件
- (void)handlePlayerTimerEvent:(NSTimer *)timer
{
    if (self.audioPlayer.isPlaying)  //正在播放
    {
        self.playerView.currentTimeLabel.text = [LYTimeUtils timeFormatted:self.audioPlayer.currentTime];
        self.playerView.totalTimeLabel.text = [LYTimeUtils timeFormatted:self.audioPlayer.duration];
        self.playerView.playSlider.value = self.audioPlayer.currentTime/self.audioPlayer.duration*1.0;
    }
    else  //未播放
    {
        
    }
}

#pragma mark - toastView
- (void)showToastView:(NSString *)text
{
//    if (!toastView)
//    {
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17]
                       constrainedToSize:CGSizeMake(200, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
        LYToastView *toastView = [[LYToastView alloc] initWithFrame:CGRectMake((ScreenWidth-size.width)/2, ScreenHeight-100, size.width+26, size.height+16)];
//    }
    toastView.textLabel.text = text;
    toastView.hidden = NO;
    [self.window addSubview:toastView];
    
    //1秒后消失
    [self hideToastViewAfter:1 toastView:toastView];
}

- (void)hideToastViewAfter:(NSTimeInterval)duration toastView:(LYToastView *)view
{
    __block LYToastView *toastView = view;
    [UIView animateWithDuration:0.6
                          delay:duration
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         toastView.alpha = 0;
     } completion:^(BOOL finished)
     {
         toastView.hidden = YES;
         [toastView removeFromSuperview];
         toastView = nil;
     }];
}

#pragma mark - AVAudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

/** 配置播放器，允许后台播放语音 */
- (void)configAudio
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    //告诉系统，我们要接受远程控制事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
            {
                CLog(@"UIEventSubtypeRemoteControlTogglePlayPause...");
                //                [self pauseOrPlay];
                break;
            }
            case UIEventSubtypeRemoteControlPlay:
            {
                CLog(@"UIEventSubtypeRemoteControlPlay...");
                [self.audioPlayer play];
                break;
            }
            case UIEventSubtypeRemoteControlPause:
            {
                CLog(@"UIEventSubtypeRemoteControlPause...");
                [self.audioPlayer pause];
                break;
            }
            case UIEventSubtypeRemoteControlStop:
            {
                CLog(@"UIEventSubtypeRemoteControlStop...");
                break;
            }
            case UIEventSubtypeRemoteControlNextTrack:
            {
                CLog(@"UIEventSubtypeRemoteControlNextTrack...");
                [self.playerView nextButtonClick:nil];
                break;
            }
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
                CLog(@"UIEventSubtypeRemoteControlPreviousTrack...");
                [self.playerView preButtonClick:nil];
                break;
            }
            default:
                break;
        }
    }
}

//设置锁屏状态，显示的歌曲信息
-(void)configNowPlayingInfoCenter
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter"))
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.currentVoiceModel.name forKey:MPMediaItemPropertyTitle];
        [dict setObject:@"罗永浩" forKey:MPMediaItemPropertyArtist];
        [dict setObject:self.currentMenuModel.name forKey:MPMediaItemPropertyAlbumTitle];
        [dict setObject:[NSNumber numberWithDouble:self.audioPlayer.duration] forKey:MPMediaItemPropertyPlaybackDuration];
        
        UIImage *image = [UIImage imageNamed:@"left_luoyonghao.png"];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

/** 检查更新 */
- (void)checkVersion
{
    [NetWorkRequest requestUpdateWithAppID:AppStoreID
                                     block:^(id data, NSError *error)
    {
        if (data)
        {
            //AppStore版本号
            NSString *version_appstore = [data valueForKey:@"version"];
            
            //本地版本
            NSString *version_local = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            CLog(@"version_local = %@, version_appstore = %@",version_local, version_appstore);
            if (![version_appstore isEqualToString:version_local])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本 V%@", version_appstore] message:@"是否立即升级到最新版本？" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
                alert.tag = 1000;
                [alert show];
            }
        }
    }];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1000: //版本更新
        {
            if (buttonIndex == 1) { //立即更新
                [LYUtils goToAppstore];
            }
        } break;
            
        default:
            break;
    }
}

#pragma mark - 播放音频
- (void)playWithModel:(VoiceModel *)model
{
    [APP_DELEGATE.playerView showWithModel:model];

    if ([model.ID isEqualToString:self.currentVoiceModel.ID] && [model.menuID isEqualToString:self.currentVoiceModel.menuID])
    {
        return;
    }
    
    APP_DELEGATE.currentVoiceModel = model;
    [self.audioPlayer stop];
    self.audioPlayer = nil;

    NSString *voiceName = [NSString stringWithFormat:@"%@_%@", model.menuID, model.ID];
    [self.audioPlayer stop];
    self.audioPlayer = nil;
    
    NSString *string = [[NSBundle mainBundle] pathForResource:voiceName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:string];
    if (url)
    {
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        
        //
        [self configNowPlayingInfoCenter];
    }
    else
    {
        CLog(@"音频播放错误：获取音频的URL为空！");
    }
}

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initDrawerViewController];
    
    [self initPlayerView];
    
    [self startPlayerTimer];
    
    [self configAudio];
    
    [self checkVersion];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (!self.playerView.hidden) {
        [self.playerView resetPlayPauseState];
    }
}

@end


