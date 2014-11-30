//
//  CenterViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterVoiceCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CenterViewController ()<UIAlertViewDelegate>
{
    NSIndexPath *cancelCollectIndexPath;  //要取消收藏的语音
}
@end

@implementation CenterViewController

- (instancetype)initWithMenu:(MenuModel *)menu
{
    self = [super init];
    if (self) {
        APP_DELEGATE.currentMenuModel = menu;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.titleLabel.text = APP_DELEGATE.currentMenuModel.name;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float w = 44;
    leftButton.frame = CGRectMake(8, 0, w, w);
    [leftButton setImage:ImageWithFile(@"center_leftButton.png") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float r_w = 44;
    rightButton.frame = CGRectMake(ScreenWidth-r_w-3, 1, r_w, r_w);
    [rightButton setImage:ImageWithFile(@"center_currentPlay.png") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightButton];
    
    self.voiceListArr = [[LYDataManager instance] selectVoiceListWithMenuID:APP_DELEGATE.currentMenuModel.ID];

    self.voiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)
                                                       style:UITableViewStylePlain];
    self.voiceTableView.separatorColor = ClearColor;
    
    [self.view addSubview:self.voiceTableView];
    
    //刷新
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.01];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //告诉系统，我们要接受远程控制事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

//刷新reloadData
- (void)reloadData
{
    self.voiceTableView.dataSource = self;
    self.voiceTableView.delegate = self;
    self.voiceListArr = [[LYDataManager instance] selectVoiceListWithMenuID:APP_DELEGATE.currentMenuModel.ID];
    [self.voiceTableView reloadData];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    
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
                [APP_DELEGATE.audioPlayer play];
                break;
            }
            case UIEventSubtypeRemoteControlPause:
            {
                CLog(@"UIEventSubtypeRemoteControlPause...");
                [APP_DELEGATE.audioPlayer pause];
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
                break;
            }
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
                CLog(@"UIEventSubtypeRemoteControlPreviousTrack...");
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - Button Events
- (void)leftButtonClick:(UIButton *)button
{
    [APP_DELEGATE showLeftSideView];
}

- (void)rightButtonClick:(UIButton *)button
{
    [APP_DELEGATE.playerView showWithModel:APP_DELEGATE.currentVoiceModel];
}

/** 添加收藏、删除收藏按钮 */
- (void)collectButtonClick:(UIButton *)button event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.voiceTableView];
    NSIndexPath *indexPath = [self.voiceTableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (!indexPath) {
        return;
    }

    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    
    if ([APP_DELEGATE.currentMenuModel.ID intValue] == 0) //收藏
    {
        cancelCollectIndexPath = indexPath;
        [UIView showAlertWithTitle:@"提示" msg:[NSString stringWithFormat:@"确定删除对 [%@] 的收藏？删除只会删掉该收藏记录，不会删掉语音！", voiceModel.name] tag:1000 delegate:self btnTitle:@"确定删除" otherBtnTitle:@"取消"];
    }
    else
    {
        voiceModel.isCollected = YES;
        [[LYDataManager instance] updateVoiceIsCollected:voiceModel.isCollected
                                                 voiceID:voiceModel.ID];
        
        [self.voiceTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [APP_DELEGATE showToastView:@"已加入收藏!"];
    }
}

/** 取消收藏语音 */
- (void)cancelCollectWithIndexPaht:(NSIndexPath *)indexPath
{
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    voiceModel.isCollected = NO;
    [[LYDataManager instance] updateVoiceIsCollected:voiceModel.isCollected
                                             voiceID:voiceModel.ID];
    
    [self.voiceListArr removeObjectAtIndex:indexPath.row];
    [self.voiceTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000)
    {
        if (buttonIndex == 0)
        {  //删除收藏
            [self cancelCollectWithIndexPaht:cancelCollectIndexPath];
        }
    }
}

#pragma mark - 播放音频
- (void)playWithModel:(VoiceModel *)model
{
    if ([model.ID isEqualToString:APP_DELEGATE.currentVoiceModel.ID] && [model.menuID isEqualToString:APP_DELEGATE.currentVoiceModel.menuID])
    {
        return;
    }
    APP_DELEGATE.currentVoiceModel = model;
    
    NSString *voiceName = [NSString stringWithFormat:@"%@_%@", model.menuID, model.ID];
    [APP_DELEGATE.audioPlayer stop];
    APP_DELEGATE.audioPlayer = nil;
    
    NSString *string = [[NSBundle mainBundle] pathForResource:voiceName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:string];
    if (url)
    {
        APP_DELEGATE.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [APP_DELEGATE.audioPlayer prepareToPlay];
        [APP_DELEGATE.audioPlayer play];
        
        //
        [self configNowPlayingInfoCenter];
    }
    else
    {
        CLog(@"音频播放错误：获取音频的URL为空！");
    }
}

//设置锁屏状态，显示的歌曲信息
-(void)configNowPlayingInfoCenter
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter"))
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:APP_DELEGATE.currentVoiceModel.name forKey:MPMediaItemPropertyTitle];
        [dict setObject:@"罗永浩" forKey:MPMediaItemPropertyArtist];
        [dict setObject:APP_DELEGATE.currentMenuModel.name forKey:MPMediaItemPropertyAlbumTitle];
        [dict setObject:[NSNumber numberWithDouble:APP_DELEGATE.audioPlayer.duration] forKey:MPMediaItemPropertyPlaybackDuration];
        
        UIImage *image = [UIImage imageNamed:@"left_luoyonghao.png"];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.voiceListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    CenterVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CenterVoiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    [cell setContentWithModel:voiceModel index:(int)indexPath.row];
    [cell.collectButton addTarget:self
                           action:@selector(collectButtonClick:event:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CenterVoiceCell *cell = (CenterVoiceCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark - UITableView dataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    
    //播放语音
//    [self playWithModel:voiceModel];
    [self performSelectorInBackground:@selector(playWithModel:) withObject:voiceModel];
    
    [APP_DELEGATE.playerView showWithModel:voiceModel];
    
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self cancelCollectWithIndexPaht:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end



