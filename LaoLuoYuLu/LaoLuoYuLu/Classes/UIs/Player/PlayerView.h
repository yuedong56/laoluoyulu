//
//  PlayerView.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-17.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define kPlayerView_H 200

#import <UIKit/UIKit.h>
#import "VoiceModel.h"

@interface PlayerView : UIView

@property (nonatomic, strong) UIView *mainBgView;
@property (nonatomic, strong) UIView *playBgView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UIButton *preButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *nextButton;

- (void)showWithModel:(VoiceModel *)model;
- (void)hide;

- (void)preButtonClick:(UIButton *)button;
- (void)nextButtonClick:(UIButton *)button;

@end


