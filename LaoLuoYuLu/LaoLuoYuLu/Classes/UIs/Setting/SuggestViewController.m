//
//  SuggestViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-12-6.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController ()

@end

@implementation SuggestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    [self setNavStyle];
}

/** 设置导航栏样式 */
- (void)setNavStyle
{
    self.title = @"吐槽提意见";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:WhiteColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    self.navigationController.navigationBar.barTintColor = GrayColor;
    self.navigationController.navigationBar.tintColor = WhiteColor; //返回按钮颜色
    
    self.navigationItem.leftBarButtonItem.tintColor = WhiteColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end


