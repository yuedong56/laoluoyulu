//
//  CenterViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterVoiceCell.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (instancetype)initWithMenu:(MenuModel *)menu
{
    self = [super init];
    if (self) {
        self.currentMenuModel = menu;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.titleLabel.text = self.currentMenuModel.name;
    
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
    
    self.voiceListArr = [[LYDataManager instance] selectVoiceListWithMenuID:self.currentMenuModel.ID];

    self.voiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)
                                                       style:UITableViewStylePlain];
    self.voiceTableView.dataSource = self;
    self.voiceTableView.delegate = self;
    [self.view addSubview:self.voiceTableView];
}

#pragma mark - Button Events
- (void)leftButtonClick:(UIButton *)button
{
    [APP_DELEGATE showLeftSideView];
}

- (void)rightButtonClick:(UIButton *)button
{
//    self presentViewController:<#(UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
}

- (void)collectButtonClick:(UIButton *)button event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.voiceTableView];
    NSIndexPath *indexPath = [self.voiceTableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath)
    {
        VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
        voiceModel.isCollected = !voiceModel.isCollected;
        [[LYDataManager instance] updateVoiceIsCollected:voiceModel.isCollected
                                                 voiceID:voiceModel.ID];
        
        [self.voiceTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    if (url) {
        APP_DELEGATE.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [APP_DELEGATE.audioPlayer prepareToPlay];
        [APP_DELEGATE.audioPlayer play];
    } else {
        CLog(@"音频播放错误：获取音频的URL为空！");
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
        cell = [[CenterVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    [cell setContentWithModel:voiceModel index:(int)indexPath.row];
    [cell.collectButton addTarget:self
                           action:@selector(collectButtonClick:event:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UITableView dataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    
    [APP_DELEGATE.playerView showWithModel:voiceModel];
    
    //播放语音
    [self playWithModel:voiceModel];
}


@end


