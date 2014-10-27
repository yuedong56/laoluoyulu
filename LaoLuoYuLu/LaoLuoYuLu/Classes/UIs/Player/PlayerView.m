//
//  PlayerView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-17.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define Title_Height 40
#define Slider_Height 30
#define PrevAndNextButton_Width 70
#define PrevAndNextButton_Height 93
#define PlayButton_Width 85

#import "PlayerView.h"
#import "UIView+Common.h"

@implementation PlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //主背景色（黑色半透明）
        self.mainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        self.mainBgView.backgroundColor = BlackColor;
        self.mainBgView.hidden = YES;
        [self addSubview:self.mainBgView];
        
        //播放控制背景色（白色）
        self.playBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-kPlayerView_H, ScreenWidth, kPlayerView_H)];
        self.playBgView.backgroundColor = WhiteColor;
        self.playBgView.hidden = YES;
        [self addSubview:self.playBgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.mainBgView addGestureRecognizer:tap];
        
        //标题
        CGRect titleFrame = CGRectMake(0, 0, ScreenWidth, Title_Height);
        self.titleLabel = [self labelWithFrame:titleFrame
                                          font:[UIFont systemFontOfSize:17]
                                     textColor:BlackColor
                                       bgColor:COLOR_F(0.95)
                                     alignment:NSTextAlignmentCenter];
        [self.playBgView addSubview:self.titleLabel];
        
        //进度条
        float slider_y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 15;
        self.playSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, slider_y, ScreenWidth-20, Slider_Height)];
        self.playSlider.minimumTrackTintColor = COLOR_F(0.2);
        self.playSlider.maximumTrackTintColor = LightGrayColor;
        [self.playBgView addSubview:self.playSlider];
        
        //当前时间
        float curLabel_x = self.playSlider.frame.origin.x + 5;
        float curLabel_y = slider_y + Slider_Height;
        float curLabel_w = 60;
        float curLabel_h = 20;
        self.currentTimeLabel = [self labelWithFrame:CGRectMake(curLabel_x, curLabel_y, curLabel_w, curLabel_h)
                                                font:[UIFont systemFontOfSize:12]
                                           textColor:LightGrayColor
                                             bgColor:ClearColor
                                           alignment:NSTextAlignmentLeft];
        [self.playBgView addSubview:self.currentTimeLabel];
        
        //总时间
        float totLabel_x = ScreenWidth - curLabel_x - curLabel_w;
        self.totalTimeLabel = [self labelWithFrame:CGRectMake(totLabel_x, curLabel_y, curLabel_w, curLabel_h)
                                              font:[UIFont systemFontOfSize:12]
                                         textColor:LightGrayColor
                                           bgColor:ClearColor
                                         alignment:NSTextAlignmentRight];
        [self.playBgView addSubview:self.totalTimeLabel];
        
        //前
        float playButton_y = kPlayerView_H - PrevAndNextButton_Height - 10;
        self.preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.preButton.frame = CGRectMake((ScreenWidth-PlayButton_Width)/2-PrevAndNextButton_Width, playButton_y, PrevAndNextButton_Width, PrevAndNextButton_Height);
        [self.preButton setImage:ImageWithFile(@"player_prev.png") forState:UIControlStateNormal];
        [self.preButton setImage:ImageWithFile(@"player_prev_h.png") forState:UIControlStateHighlighted];
        [self.playBgView addSubview:self.preButton];
        
        //中
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.frame = CGRectMake((ScreenWidth-PlayButton_Width)/2, playButton_y, PlayButton_Width, PrevAndNextButton_Height);
        [self.playButton setImage:ImageWithFile(@"player_play.png") forState:UIControlStateNormal];
        [self.playButton setImage:ImageWithFile(@"player_play_h.png") forState:UIControlStateHighlighted];
        [self.playBgView addSubview:self.playButton];
        
        //后
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextButton.frame = CGRectMake(ScreenWidth/2+PlayButton_Width/2, playButton_y, PrevAndNextButton_Width, PrevAndNextButton_Height);
        [self.nextButton setImage:ImageWithFile(@"player_next.png") forState:UIControlStateNormal];
        [self.nextButton setImage:ImageWithFile(@"player_next_h.png") forState:UIControlStateHighlighted];
        [self.playBgView addSubview:self.nextButton];
    }
    return self;
}

- (void)tap
{
    [self hide];
}

- (void)showWithModel:(VoiceModel *)model
{
    self.titleLabel.text = model.name;
    
    self.hidden = NO;
    self.mainBgView.hidden = NO;
    self.playBgView.hidden = NO;
    
    self.mainBgView.alpha = 0;
    self.playBgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, kPlayerView_H);
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.mainBgView.alpha = 0.5;
        self.playBgView.frame = CGRectMake(0, ScreenHeight-kPlayerView_H, ScreenWidth, kPlayerView_H);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.mainBgView.alpha = 0;
        self.playBgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, kPlayerView_H);
    } completion:^(BOOL finished) {
        self.mainBgView.hidden = YES;
        self.playBgView.hidden = YES;
        self.hidden = YES;
    }];
}

@end


