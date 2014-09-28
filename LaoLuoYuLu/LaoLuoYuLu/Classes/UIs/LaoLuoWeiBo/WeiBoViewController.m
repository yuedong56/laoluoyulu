//
//  LogInViewController.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-4.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "WeiBoViewController.h"

@interface WeiBoViewController ()
{
    BOOL isControlViewHide;
}
@end

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
    self.weiboWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    self.weiboWebView.delegate = self;
    self.weiboWebView.scrollView.delegate = self;
    [self.view addSubview:self.weiboWebView];
}

/** 初始化网页控制视图 */
- (void)initControlView
{
    self.webControlView = [[WebControlView alloc] initWithFrame:CGRectMake(0, ScreenHeight-button_height, ScreenWidth, button_height)];
    [self.view addSubview:self.webControlView];
    
    [self.webControlView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.webControlView.forwardButton addTarget:self action:@selector(forwardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.webControlView.homeButton addTarget:self action:@selector(homeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.webControlView.refreshButton addTarget:self action:@selector(refreshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

/** 显示controlView */
- (void)showControlView
{
    self.webControlView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        float controlView_y = self.weiboWebView.frame.origin.y + self.weiboWebView.frame.size.height;
        self.webControlView.frame = CGRectMake(0, controlView_y-button_height, ScreenWidth, button_height);
    } completion:^(BOOL finished) {
        
    }];
}

/** 隐藏controlView */
- (void)hideControlView
{
    [UIView animateWithDuration:0.3 animations:^{
        float controlView_y = self.weiboWebView.frame.origin.y + self.weiboWebView.frame.size.height;
        self.webControlView.frame = CGRectMake(0, controlView_y, ScreenWidth, button_height);
    } completion:^(BOOL finished) {
        self.webControlView.hidden = YES;
    }];
}

#pragma mark - Button Events
/** 取消按钮 */
- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 后退按钮 */
- (void)backButtonClick:(UIButton *)button
{
    [self.weiboWebView goBack];
}

/** 前进按钮 */
- (void)forwardButtonClick:(UIButton *)button
{
    [self.weiboWebView goForward];
}

/** home按钮 */
- (void)homeButtonClick:(UIButton *)button
{
    [self loadingLaoLuoWeiBoWebView];
}

/** 刷新按钮 */
- (void)refreshButtonClick:(UIButton *)button
{
    [self showProgressHUDWithText:nil];
    [self.weiboWebView reload];
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
//    [NetWorkRequest requestUserInfoWithUID:@""
//                                     block:^(NSDictionary *jsonDic, NSError *error)
//    {
//        if (jsonDic) {
//            NSLog(@"请求成功！");
//        }
//    }];
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

#pragma mark - UIScrollView Delegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0) {
        if (!isControlViewHide) {
            isControlViewHide = YES;
            [self hideControlView];
        }
    } else {
        if (isControlViewHide) {
            isControlViewHide = NO;
            [self showControlView];
        }
    }
}

@end
