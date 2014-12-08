//
//  AboutViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-9.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    [self setNavStyle];
}

/** 设置导航栏样式 */
- (void)setNavStyle
{
    self.title = @"关于作者";
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


