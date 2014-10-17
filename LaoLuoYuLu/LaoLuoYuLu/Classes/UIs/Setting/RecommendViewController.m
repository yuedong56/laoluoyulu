//
//  RecommendViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-9.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    self.titleLabel.text = @"应用推荐";
    [self.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftButton addTarget:self
                        action:@selector(leftButtonPress:)
              forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Events
/** 取消按钮 */
- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


