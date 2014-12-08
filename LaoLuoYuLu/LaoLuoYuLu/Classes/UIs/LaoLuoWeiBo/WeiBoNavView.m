//
//  WeiBoNavView.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-19.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "WeiBoNavView.h"

@implementation WeiBoNavView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //导航栏背景
        self.navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        self.navBgView.backgroundColor = Nav_Color;
        [self addSubview:self.navBgView];
        
        //标题
        CGRect titleLabelFrame = CGRectMake(0, 20, ScreenWidth, 44);
        UIFont *titleFont = [UIFont boldSystemFontOfSize:20];
        self.titleLabel = [self labelWithFrame:titleLabelFrame
                                          font:titleFont
                                     textColor:WhiteColor
                                       bgColor:ClearColor
                                     alignment:NSTextAlignmentCenter];
        self.titleLabel.text = @"老罗的微博";
        [self.navBgView addSubview:self.titleLabel];
        
        //返回按钮
        CGRect leftBtnFrame = CGRectMake(0, 20, 50, 44);
        self.leftButton = [self buttonWithFrame:leftBtnFrame
                                          title:@"关闭"];
        self.leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.leftButton setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.leftButton setTitleColor:DarkGrayColor forState:UIControlStateHighlighted];
        [self.navBgView addSubview:self.leftButton];
    }
    return self;
}

@end


