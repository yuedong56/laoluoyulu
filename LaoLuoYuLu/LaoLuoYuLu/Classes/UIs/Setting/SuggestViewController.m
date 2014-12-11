//
//  SuggestViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-12-6.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  http://m.weibo.cn/1905373741/BA3Ag5WPO

#import "SuggestViewController.h"

@interface SuggestViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *weiboWebView;
@end

@implementation SuggestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    [self setNavStyle];
    [self loadingLaoLuoWeiBoWebView];
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

/** 加载老罗的微博页面 */
- (void)loadingLaoLuoWeiBoWebView
{
    if (!self.weiboWebView) {
        [self initWebView];
    }
    NSURL *url = [NSURL URLWithString:@"http://m.weibo.cn/1905373741/BA3Ag5WPO"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.weiboWebView loadRequest:request];
}

/** 初始化webview */
- (void)initWebView
{
    self.weiboWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    self.weiboWebView.delegate = self;
    self.weiboWebView.backgroundColor = WhiteColor;
    [self.view addSubview:self.weiboWebView];
}


@end


