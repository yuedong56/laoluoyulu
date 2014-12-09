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
    
    [self setNavStyle];
    
    //demo label
    UILabel *label = [self.view labelWithFrame:CGRectMake(0, 170, ScreenWidth, 100) font:[UIFont boldSystemFontOfSize:22] textColor:LightGrayColor bgColor:ClearColor alignment:NSTextAlignmentCenter];
    label.text = @"暂时没有应用推荐";
    [self.view addSubview:label];
}


/** 设置导航栏样式 */
- (void)setNavStyle
{
    self.title = @"应用推荐";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:WhiteColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    self.navigationController.navigationBar.barTintColor = GrayColor;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(leftButtonPress:)];
    item.tintColor = WhiteColor;
    self.navigationItem.leftBarButtonItem = item;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - Button Events
/** 关闭按钮 */
- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


