//
//  LogInViewController.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-4.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "WeiBoViewController.h"
#import "WeiBoNavView.h"
#import "MBProgressHUD.h"

@interface WeiBoViewController ()
{
    BOOL isControlViewHide;
    WeiBoNavView *navView;
}

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation WeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = WhiteColor;
    self.navigationController.navigationBarHidden = YES;
    
    [self initNavBar];
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

/** 设置导航栏 */
- (void)initNavBar
{
    //导航栏
    navView = [[WeiBoNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navView];
    
    //返回按钮添加事件
    [navView.leftButton addTarget:self
                           action:@selector(leftButtonPress:)
                 forControlEvents:UIControlEventTouchUpInside];
}

/** 加载老罗的微博页面 */
- (void)loadingLaoLuoWeiBoWebView
{
    if (!self.weiboWebView) {
        [self initWebView];
    }
    NSURL *url = [NSURL URLWithString:@"http://m.weibo.cn/u/1640571365"];
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
- (void)showNavAndControlView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //导航栏
        navView.frame = CGRectMake(0, 0, ScreenWidth, 64);
        //webView
        self.weiboWebView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        //底部控制栏
        float controlView_y = self.weiboWebView.frame.origin.y + self.weiboWebView.frame.size.height;
        self.webControlView.frame = CGRectMake(0, controlView_y-button_height, ScreenWidth, button_height);
    } completion:^(BOOL finished) {
        
    }];
}

/** 隐藏controlView */
- (void)hideNavAndControlView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //导航栏
        navView.frame = CGRectMake(0, -64, ScreenWidth, 64);
        //webView
        self.weiboWebView.frame = CGRectMake(0, 20, ScreenWidth, ScreenHeight-20);
        //底部控制栏
        float controlView_y = self.weiboWebView.frame.origin.y + self.weiboWebView.frame.size.height;
        self.webControlView.frame = CGRectMake(0, controlView_y, ScreenWidth, button_height);
    } completion:^(BOOL finished) {
        
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
            [self hideNavAndControlView];
        }
    } else {
        if (isControlViewHide) {
            isControlViewHide = NO;
            [self showNavAndControlView];
        }
    }
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
