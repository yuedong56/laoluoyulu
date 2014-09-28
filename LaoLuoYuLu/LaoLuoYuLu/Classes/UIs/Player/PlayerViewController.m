//
//  PlayerViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-28.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define Tape_Speed 0.03

#import "PlayerViewController.h"

@interface PlayerViewController ()
{
    NSTimer *tapeTimer;
}
@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_N(242);
    self.titleLabel.text = self.currentVoiceModel.name;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backGesture:)];
    [cancelItem setTintColor:WhiteColor];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    [self initCDView];
    [self initControlView];
    
    //下滑返回手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backGesture:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}

/**
 * @brief 初始化CD
 */
- (void)initCDView
{
    self.cdView = [[CDView alloc] initWithFrame:CGRectMake(0, IPhone5?84:64, ScreenWidth, BigCDImageView_Height)];
    [self.view addSubview:self.cdView];
}

/**
 * @brief 初始化控制层
 */
- (void)initControlView
{
    float control_y = ScreenHeight-ControlView_Height-(IPhone5?20:5);
    self.controlView = [[ControlView alloc] initWithFrame:CGRectMake(0, control_y, ScreenWidth, ControlView_Height)];
    [self.view addSubview:self.controlView];
}

#pragma mark - 下滑返回手势
- (void)backGesture:(UISwipeGestureRecognizer *)swipe
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 定时器
- (void)tapeTimer:(NSTimer *)timer
{
    self.cdView.smallCDImageView.transform = CGAffineTransformRotate(self.cdView.smallCDImageView.transform, degreesToRadinas(1));
    self.cdView.bigCDImageView.transform = CGAffineTransformRotate(self.cdView.bigCDImageView.transform, degreesToRadinas(-1));
}

#pragma mark - 播放相关
/**
 * @biref 开始播放
 */
- (void)play
{
    if (!tapeTimer) {
        tapeTimer = [NSTimer scheduledTimerWithTimeInterval:Tape_Speed target:self selector:@selector(tapeTimer:) userInfo:nil repeats:YES];
    }
}

/**
 * @brief 暂停播放
 */
- (void)pause
{
    [tapeTimer invalidate];
    tapeTimer = nil;
}

/**
 * @brief 停止播放
 */
- (void)stop
{
    [tapeTimer invalidate];
    tapeTimer = nil;
}

@end


