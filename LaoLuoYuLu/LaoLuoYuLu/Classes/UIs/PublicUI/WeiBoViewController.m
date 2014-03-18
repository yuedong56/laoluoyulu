//
//  LogInViewController.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-4.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "WeiBoViewController.h"

@interface WeiBoViewController()
{
    UIImageView *wifiImageView;
    UILabel *label;
    UIButton *refreshButton;
}
@end

@implementation WeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = WhiteColor;
    
    if ([LYUserDefaults getAccessToken]) {
        self.titleLabel.text = @"老罗的微博";
    } else {
        self.titleLabel.text = @"登录";
            [self addLogInWebView];
    }
    
    [self.leftButton addTarget:self action:@selector(leftButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}

//登录界面网页
- (void)addLogInWebView
{
    [APP_DELEGATE showProgressHUDWithText:nil];
    //webView
    self.loginWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, IOS7AndLater?64:0, ScreenWidth, ScreenHeight-(IOS7AndLater?64:64))];
    self.loginWebView.delegate = self;
    [self.view addSubview:self.loginWebView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&display=mobile&redirect_uri=%@",AppKey,RedirectUri]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.loginWebView loadRequest:request];
}

//无网时的界面
- (void)addNetworkUnavailableViews
{
    float image_width = 200;
    float image_height = 89;
    wifiImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-image_width)/2, IOS7AndLater?100:35, image_width, image_height)];
    wifiImageView.image = ImageWithFile(@"wifi.png");
    wifiImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:wifiImageView];
    
    float label_width = 250;
    float label_height = 50;
    label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-label_width)/2, wifiImageView.frame.origin.y+image_height+20, label_width, label_height)];
    label.text = @"无法连接到网络，请重试！";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = LightGrayColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    float button_width = 100;
    float button_height = 35;
    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake((ScreenWidth-button_width)/2, label.frame.origin.y+label_height+20, button_width, button_height);
    refreshButton.layer.cornerRadius = 8;
    refreshButton.backgroundColor = LightGrayColor;
    [refreshButton setTitle:@"重  试" forState:UIControlStateNormal];
    [refreshButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [refreshButton setTitleColor:GrayColor forState:UIControlStateHighlighted];
    [refreshButton addTarget:self action:@selector(refreshButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshButton];
}

- (void)removeOtherViews
{
    [wifiImageView removeFromSuperview];
    wifiImageView = nil;
    
    [label removeFromSuperview];
    label = nil;
    
    [refreshButton removeFromSuperview];
    refreshButton = nil;
}

#pragma mark - Button Events

- (void)refreshButtonPress:(UIButton *)button
{
    if ([LYUtils checkNetworkAvailable]) {
        [self removeOtherViews];
        [self addLogInWebView];
    } else {
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"请检查您的网络设置后再重试！"
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定", nil] show];
    }
}

- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
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
                
            }
        }];
        return  NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [APP_DELEGATE hideProgressHUDWithText:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [APP_DELEGATE hideProgressHUDWithText:nil];
}

@end
