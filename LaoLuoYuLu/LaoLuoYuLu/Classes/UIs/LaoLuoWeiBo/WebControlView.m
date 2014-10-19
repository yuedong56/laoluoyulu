//
//  WebControlView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-19.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "WebControlView.h"

@implementation WebControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor = GrayColor;
//        self.alpha = 0.5;
        
        float button_width = ScreenWidth/4;
        UIColor *titleColor_N = WhiteColor;
        UIColor *titleColor_H = DarkGrayColor;
        
        //
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.frame = CGRectMake(0, 0, button_width, button_height);
        [self.backButton setTitle:@"后退" forState:UIControlStateNormal];
        [self.backButton setTitleColor:titleColor_N forState:UIControlStateNormal];
        [self.backButton setTitleColor:titleColor_H forState:UIControlStateHighlighted];
        [self addSubview:self.backButton];
        //
        self.forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.forwardButton.frame = CGRectMake(button_width, 0, button_width, button_height);
        [self.forwardButton setTitle:@"前进" forState:UIControlStateNormal];
        [self.forwardButton setTitleColor:titleColor_N forState:UIControlStateNormal];
        [self.forwardButton setTitleColor:titleColor_H forState:UIControlStateHighlighted];
        [self addSubview:self.forwardButton];
        //
        self.homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.homeButton.frame = CGRectMake(button_width*2, 0, button_width, button_height);
        [self.homeButton setTitle:@"主页" forState:UIControlStateNormal];
        [self.homeButton setTitleColor:titleColor_N forState:UIControlStateNormal];
        [self.homeButton setTitleColor:titleColor_H forState:UIControlStateHighlighted];
        [self addSubview:self.homeButton];
        //
        self.refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.refreshButton.frame = CGRectMake(button_width*3, 0, button_width, button_height);
        [self.refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
        [self.refreshButton setTitleColor:titleColor_N forState:UIControlStateNormal];
        [self.refreshButton setTitleColor:titleColor_H forState:UIControlStateHighlighted];
        [self addSubview:self.refreshButton];
        
        self.backButton.backgroundColor = BlackColor;
        self.forwardButton.backgroundColor = BlackColor;
        self.homeButton.backgroundColor = BlackColor;
        self.refreshButton.backgroundColor = BlackColor;

        self.backButton.alpha = 0.4;
        self.forwardButton.alpha = 0.4;
        self.homeButton.alpha = 0.4;
        self.refreshButton.alpha = 0.4;
    }
    return self;
}

@end
