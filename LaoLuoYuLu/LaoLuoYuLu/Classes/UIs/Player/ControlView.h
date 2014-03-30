//
//  ControlView.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-30.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define Slider_Height 30
#define PrevAndNextButton_Width 70
#define PrevAndNextButton_Height 93
#define PlayButton_Width 85

#define ControlView_Height (Slider_Height+PrevAndNextButton_Height)

#import <UIKit/UIKit.h>

@interface ControlView : UIView


@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UIButton *preButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *nextButton;

@end
