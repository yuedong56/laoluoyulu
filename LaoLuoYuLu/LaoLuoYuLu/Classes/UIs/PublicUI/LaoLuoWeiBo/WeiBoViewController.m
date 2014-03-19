//
//  LogInViewController.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-4.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "WeiBoViewController.h"

@implementation WeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = WhiteColor;
    
    self.titleLabel.text = @"老罗的微博";
    [self.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftButton addTarget:self
                        action:@selector(leftButtonPress:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self loadingLaoLuoWeiBoWebView];
    [self initControlView];
}

/** 登录界面网页 */
/*
- (void)loadingLogInWebView
{
    if (!self.weiboWebView) {
        [self initWebView];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&display=mobile&redirect_uri=%@",AppKey,RedirectUri]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.weiboWebView loadRequest:request];
    
    [self showProgressHUDWithText:nil];
}
*/

/** 加载老罗的微博页面 */
- (void)loadingLaoLuoWeiBoWebView
{
    if (!self.weiboWebView) {
        [self initWebView];
    }
    NSURL *url = [NSURL URLWithString:@"http://weibo.com/laoluoyonghao?from=feed&loc=nickname"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.weiboWebView loadRequest:request];
    
    [self showProgressHUDWithText:nil];
}

/** 初始化webview */
- (void)initWebView
{
    self.weiboWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, IOS7AndLater?64:0, ScreenWidth, ScreenHeight-(IOS7AndLater?64:64))];
    self.weiboWebView.delegate = self;
    [self.view addSubview:self.weiboWebView];
}

/** 初始化网页控制视图 */
- (void)initControlView
{
    self.webControlView = [[WebControlView alloc] initWithFrame:CGRectMake(0, ScreenHeight-button_height-(IOS7AndLater?0:64), ScreenWidth, button_height)];
    [self.view addSubview:self.webControlView];
}

#pragma mark - Button Events
/** 返回按钮 */
- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /*
    NSString *str = [[request URL] absoluteString];
    NSRange range = [str rangeOfString:@"?code="];
    if(range.location != NSNotFound)
    {
        NSString *code = [str substringFromIndex:range.location + 6];
        
        [NetWorkRequest requestAccessTokenWithAuthorizeCode:code
                                                      block:^(NSDictionary *jsonDic, NSError *error)
        {
            CLog(@"login_jsonDic ==== %@",jsonDic);
            if (jsonDic)
            {
                [LYUserDefaults saveAccessToken:[jsonDic valueForKey:@"access_token"]];
                [LYUserDefaults saveUID:[jsonDic valueForKey:@"uid"]];
                //登录成功
                [self loadingLaoLuoWeiBoWebView];
            }
        }];
        return  NO;
    }
     */
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

@end
