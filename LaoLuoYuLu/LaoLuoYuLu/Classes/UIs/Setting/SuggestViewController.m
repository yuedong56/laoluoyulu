//
//  SuggestViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-12-6.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  http://m.weibo.cn/1905373741/BA3Ag5WPO

#import "SuggestViewController.h"
#import "MBProgressHUD.h"

@interface SuggestViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *weiboWebView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

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
    
    [self showProgressHUDWithText:nil];
}

/** 初始化webview */
- (void)initWebView
{
    self.weiboWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    self.weiboWebView.delegate = self;
    self.weiboWebView.backgroundColor = WhiteColor;
    [self.view addSubview:self.weiboWebView];
}

#pragma mark - UIWebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideProgressHUDWithText:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideProgressHUDWithText:nil];
}

#pragma mark - ProgressHUD
- (void)showProgressHUDWithText:(NSString *)text
{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHUD.labelText = text;
    self.progressHUD.userInteractionEnabled = NO;
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


