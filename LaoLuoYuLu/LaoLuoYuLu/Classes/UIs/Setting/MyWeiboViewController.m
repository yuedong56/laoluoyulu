//
//  MyWeiboViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-12-8.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "MyWeiboViewController.h"
#import "WebControlView.h"

@interface MyWeiboViewController ()<UIWebViewDelegate, UIScrollViewDelegate>
{
    BOOL isControlViewHide;
}
@property (nonatomic, strong) UIWebView *weiboWebView;
@property (nonatomic, strong) WebControlView *webControlView;

@end



@implementation MyWeiboViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavStyle];
    [self loadingLaoLuoWeiBoWebView];
    [self initControlView];
}

/** 设置导航栏样式 */
- (void)setNavStyle
{
    self.title = @"关注作者微博";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:WhiteColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    self.navigationController.navigationBar.barTintColor = GrayColor;
    self.navigationController.navigationBar.tintColor = WhiteColor; //返回按钮颜色
    
    self.navigationItem.leftBarButtonItem.tintColor = WhiteColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/** 初始化 webView */
- (void)loadingLaoLuoWeiBoWebView
{
    if (!self.weiboWebView) {
        [self initWebView];
    }
    NSURL *url = [NSURL URLWithString:@"http://m.weibo.cn/u/1905373741"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.weiboWebView loadRequest:request];
}

/** 初始化webview */
- (void)initWebView
{
    self.weiboWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    self.weiboWebView.delegate = self;
    self.weiboWebView.scrollView.delegate = self;
    self.weiboWebView.backgroundColor = WhiteColor;
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

/** 显示controlView */
- (void)showNavAndControlView
{
    CLog(@"显示！");
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //底部控制栏
        float controlView_y = self.weiboWebView.frame.origin.y + self.weiboWebView.frame.size.height;
        self.webControlView.frame = CGRectMake(0, controlView_y-button_height, ScreenWidth, button_height);
    } completion:^(BOOL finished) {
        
    }];
}

/** 隐藏controlView */
- (void)hideNavAndControlView
{
    CLog(@"隐藏！");
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //底部控制栏
        float controlView_y = self.weiboWebView.frame.origin.y + self.weiboWebView.frame.size.height;
        self.webControlView.frame = CGRectMake(0, controlView_y, ScreenWidth, button_height);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - button events
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
    [self.weiboWebView reload];
}

@end


