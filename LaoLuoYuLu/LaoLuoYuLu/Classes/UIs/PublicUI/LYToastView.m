//
//  ETTToastView.m
//  四中网校-ios
//
//  Created by 老岳 on 14-7-30.
//  Copyright (c) 2014年 老岳. All rights reserved.
//

#import "LYToastView.h"

@implementation LYToastView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgView.backgroundColor = BlackColor;
        bgView.layer.cornerRadius = 10;
        bgView.alpha = 0.8;
        [self addSubview:bgView];
        
        //文字
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.textColor = WhiteColor;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.backgroundColor = ClearColor;
        [self addSubview:self.textLabel];
    }
    return self;
}

@end
