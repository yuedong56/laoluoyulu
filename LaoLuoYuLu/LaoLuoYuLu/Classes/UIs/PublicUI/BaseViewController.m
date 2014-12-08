//
//  BaseViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-15.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationController+Rotate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNavBarView];
}

//导航栏
- (void)addNavBarView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //导航栏
    self.navBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, 64)];
    self.navBackgroundView.backgroundColor = Nav_Color;
    [self.navigationController.navigationBar addSubview:self.navBackgroundView];
    
    //导航栏标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    self.titleLabel.backgroundColor = ClearColor;
    self.titleLabel.textColor = WhiteColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
    
    //
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(10, 0, 44, 44);
    [self.leftButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.leftButton setTitleColor:DarkGrayColor forState:UIControlStateHighlighted];
    [self.navigationController.navigationBar addSubview:self.leftButton];
    
    //
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:DarkGrayColor forState:UIControlStateHighlighted];
    self.rightButton.frame = CGRectMake(ScreenWidth-44, 0, 44, 44);
    [self.navigationController.navigationBar addSubview:self.rightButton];
}

#pragma mark - ProgressHUD

- (void)showProgressHUDWithText:(NSString *)text
{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHUD.labelText = text;
    [self.view addSubview:self.progressHUD];
    [self.progressHUD show:YES];
}

- (void)hideProgressHUDWithText:(NSString *)text
{
    [self.progressHUD hide:YES];
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}

@end
