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
        
        [self.playSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.playSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self.playSlider addTarget:self action:@selector(sliderTouchUpinside:) forControlEvents:UIControlEventTouchUpInside];
        
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
        self.currentTimeLabel.text = @"--:--";
        [self.playBgView addSubview:self.currentTimeLabel];
        
        //总时间
        float totLabel_x = ScreenWidth - curLabel_x - curLabel_w;
        self.totalTimeLabel = [self labelWithFrame:CGRectMake(totLabel_x, curLabel_y, curLabel_w, curLabel_h)
                                              font:[UIFont systemFontOfSize:12]
                                         textColor:LightGrayColor
                                           bgColor:ClearColor
                                         alignment:NSTextAlignmentRight];
        self.totalTimeLabel.text = @"--:--";
        [self.playBgView addSubview:self.totalTimeLabel];
        
        //前
        float playButton_y = kPlayerView_H - PrevAndNextButton_Height - 10;
        self.preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.preButton.frame = CGRectMake((ScreenWidth-PlayButton_Width)/2-PrevAndNextButton_Width, playButton_y, PrevAndNextButton_Width, PrevAndNextButton_Height);
        [self.preButton setImage:ImageWithFile(@"player_prev.png") forState:UIControlStateNormal];
        [self.preButton setImage:ImageWithFile(@"player_prev_h.png") forState:UIControlStateHighlighted];
        [self.playBgView addSubview:self.preButton];
        [self.preButton addTarget:self action:@selector(preButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //中
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.frame = CGRectMake((ScreenWidth-PlayButton_Width)/2, playButton_y, PlayButton_Width, PrevAndNextButton_Height);
        [self.playButton setImage:ImageWithFile(@"player_play.png") forState:UIControlStateNormal];
        [self.playButton setImage:ImageWithFile(@"player_play_h.png") forState:UIControlStateHighlighted];
        [self.playBgView addSubview:self.playButton];
        [self.playButton addTarget:self action:@selector(playPauseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //后
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextButton.frame = CGRectMake(ScreenWidth/2+PlayButton_Width/2, playButton_y, PrevAndNextButton_Width, PrevAndNextButton_Height);
        [self.nextButton setImage:ImageWithFile(@"player_next.png") forState:UIControlStateNormal];
        [self.nextButton setImage:ImageWithFile(@"player_next_h.png") forState:UIControlStateHighlighted];
        [self.playBgView addSubview:self.nextButton];
        [self.nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)tap
{
    [self hide];
}

- (void)showWithModel:(VoiceModel *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@ - %@", model.menuName, model.name];
    
    NSTimeInterval duration = !self.hidden ? 0 : 0.25;
    
    self.hidden = NO;
    self.mainBgView.hidden = NO;
    self.playBgView.hidden = NO;
    
    self.mainBgView.alpha = 0;
    self.playBgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, kPlayerView_H);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.mainBgView.alpha = 0.5;
        self.playBgView.frame = CGRectMake(0, ScreenHeight-kPlayerView_H, ScreenWidth, kPlayerView_H);
    } completion:^(BOOL finished) {
        if (APP_DELEGATE.audioPlayer.isPlaying) {
            [self.playButton setImage:ImageWithFile(@"player_pause.png") forState:UIControlStateNormal];
            [self.playButton setImage:ImageWithFile(@"player_pause_h.png") forState:UIControlStateHighlighted];
        } else {
            [self.playButton setImage:ImageWithFile(@"player_play.png") forState:UIControlStateNormal];
            [self.playButton setImage:ImageWithFile(@"player_play_h.png") forState:UIControlStateHighlighted];
        }
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

#pragma mark - slider events
- (void)sliderValueChanged:(UISlider *)slider
{
    self.currentTimeLabel.text = [LYTimeUtils timeFormatted:slider.value * APP_DELEGATE.audioPlayer.duration];
}

- (void)sliderTouchDown:(UISlider *)slider
{
    CLog(@"%s", __FUNCTION__);
    [APP_DELEGATE.instanceTimer invalidate];
    APP_DELEGATE.instanceTimer = nil;
}

- (void)sliderTouchUpinside:(UISlider *)slider
{
    CLog(@"%s", __FUNCTION__);
    [APP_DELEGATE startPlayerTimer];
    APP_DELEGATE.audioPlayer.currentTime = slider.value * APP_DELEGATE.audioPlayer.duration;
}

#pragma mark - button event
- (void)playPauseButtonClick:(UIButton *)button
{
    if (APP_DELEGATE.audioPlayer.isPlaying) {
        [APP_DELEGATE.audioPlayer pause];
        
        [self.playButton setImage:ImageWithFile(@"player_play.png") forState:UIControlStateNormal];
        [self.playButton setImage:ImageWithFile(@"player_play_h.png") forState:UIControlStateHighlighted];
    } else {
        [APP_DELEGATE.audioPlayer play];
        
        [self.playButton setImage:ImageWithFile(@"player_pause.png") forState:UIControlStateNormal];
        [self.playButton setImage:ImageWithFile(@"player_pause_h.png") forState:UIControlStateHighlighted];
    }
}

- (void)preButtonClick:(UIButton *)button
{
    if (APP_DELEGATE.currentVoiceIndex == 0) {
        APP_DELEGATE.currentVoiceIndex = (int)APP_DELEGATE.currentVoiceLists.count-1;
    } else {
        APP_DELEGATE.currentVoiceIndex --;
    }
    
    VoiceModel *currentVoiceModel = [APP_DELEGATE.currentVoiceLists objectAtIndex:APP_DELEGATE.currentVoiceIndex];
    [APP_DELEGATE playWithModel:currentVoiceModel];
    
    [APP_DELEGATE.centerVC.voiceTableView reloadData];
}

- (void)nextButtonClick:(UIButton *)button
{
    if (APP_DELEGATE.currentVoiceIndex < APP_DELEGATE.currentVoiceLists.count-1) {
        APP_DELEGATE.currentVoiceIndex ++;
    } else {
        APP_DELEGATE.currentVoiceIndex = 0;
    }
    
    VoiceModel *currentVoiceModel = [APP_DELEGATE.currentVoiceLists objectAtIndex:APP_DELEGATE.currentVoiceIndex];
    [APP_DELEGATE playWithModel:currentVoiceModel];
    
    [APP_DELEGATE.centerVC.voiceTableView reloadData];
}

@end


