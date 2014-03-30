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
    
    [self initCDView];
    [self initControlView];
//    self.cdView.backgroundColor = RedColor;
//    self.controlView.backgroundColor = GrayColor;
    
//    tapeTimer = [NSTimer scheduledTimerWithTimeInterval:Tape_Speed target:self selector:@selector(tapeTimer:) userInfo:nil repeats:YES];
    
    
}

/**
 * @brief 初始化CD
 */
- (void)initCDView
{
    self.cdView = [[CDView alloc] initWithFrame:CGRectMake(0, IOS7AndLater?64:0, ScreenWidth, CDImageView_Height)];
    [self.view addSubview:self.cdView];
    
}

/**
 * @brief 初始化控制层
 */
- (void)initControlView
{
    float control_y = ScreenHeight-ControlView_Height-(IOS7AndLater?0:64);
    self.controlView = [[ControlView alloc] initWithFrame:CGRectMake(0, control_y, ScreenWidth, ControlView_Height)];
    [self.view addSubview:self.controlView];
}

//- (void)tapeTimer:(NSTimer *)timer
//{
//    self.CDImageView.transform = CGAffineTransformRotate(self.CDImageView.transform, degreesToRadinas(1));
//}

@end
