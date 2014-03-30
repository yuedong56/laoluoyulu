//
//  ControlView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-30.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "ControlView.h"

@implementation ControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //进度条
        self.playSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, Slider_Height)];
        self.playSlider.minimumTrackTintColor = COLOR_F(0.2);
        self.playSlider.maximumTrackTintColor = LightGrayColor;
        [self addSubview:self.playSlider];
        
        float playButton_y = Slider_Height;
        //前
        self.preButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.preButton.frame = CGRectMake((ScreenWidth-PlayButton_Width)/2-PrevAndNextButton_Width, playButton_y, PrevAndNextButton_Width, PrevAndNextButton_Height);
        [self.preButton setImage:ImageWithFile(@"player_prev.png") forState:UIControlStateNormal];
        [self.preButton setImage:ImageWithFile(@"player_prev_h.png") forState:UIControlStateHighlighted];
        [self addSubview:self.preButton];
        //中
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.frame = CGRectMake((ScreenWidth-PlayButton_Width)/2, playButton_y, PlayButton_Width, PrevAndNextButton_Height);
        [self.playButton setImage:ImageWithFile(@"player_play.png") forState:UIControlStateNormal];
        [self.playButton setImage:ImageWithFile(@"player_play_h.png") forState:UIControlStateHighlighted];
        [self addSubview:self.playButton];
        
        //中
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextButton.frame = CGRectMake(ScreenWidth/2+PlayButton_Width/2, playButton_y, PrevAndNextButton_Width, PrevAndNextButton_Height);
        [self.nextButton setImage:ImageWithFile(@"player_next.png") forState:UIControlStateNormal];
        [self.nextButton setImage:ImageWithFile(@"player_next_h.png") forState:UIControlStateHighlighted];
        [self addSubview:self.nextButton];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
