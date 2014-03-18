//
//  NetWorkRequest.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-13.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest

/**
 * @brief 检查网络，若网络不可用则弹出提示
 */
+ (BOOL)checkNetWorkStateAndShowAlertView
{
    if (![LYUtils checkNetworkAvailable]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"当前网络不可用！"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        return NO;
    } else {
        return YES;
    }
}

/**
 * @brief 启动一个get请求
 */
+ (void)startGetRequestWithURL:(NSString *)urlStr
                    requestKey:(NSString *)key
                         block:(void(^)(NSDictionary *jsonDic, NSError *error))block
{
    NSURL *url = [NSURL URLWithString:urlStr];
    __unsafe_unretained __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
        if ([request error]) {
            block(nil,[request error]);
        } else {
            NSData *jsonData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            block(jsonDic,nil);
        }
    }];
    
    [request setFailedBlock:^{
        block(nil,[request error]);
    }];
    
    [request startAsynchronous];
}

#pragma mark - 登录
/**
 * @brief 获取授权过的Access Token
 * @param authorizeCode 登录页面返回的code
 */
+ (void)requestAccessTokenWithAuthorizeCode:(NSString *)authorizeCode
                                      block:(void(^)(NSDictionary *jsonDic, NSError *error))block
{
    if (![self checkNetWorkStateAndShowAlertView]) {
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",AppKey,AppSecret,authorizeCode,RedirectUri];
    NSURL *url = [NSURL URLWithString:urlStr];
    __unsafe_unretained __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    
    [request setCompletionBlock:^{
        if ([request error]) {
            block(nil,[request error]);
        } else {
            NSData *jsonData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            block(jsonDic,nil);
        }
    }];
    
    [request setFailedBlock:^{
        block(nil,[request error]);
    }];
    
    [request startAsynchronous];
}

#pragma mark - 用户
/**
 * @brief 根据用户ID获取用户信息
 */
+ (void)requestUserInfoWithUID:(NSString *)uid
                         block:(void(^)(NSDictionary *jsonDic, NSError *error))block
{
    if (![self checkNetWorkStateAndShowAlertView]) {
        return;
    }
    NSString *accessToken = [LYUserDefaults getAccessToken];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%d",accessToken,[uid intValue]];
    [self startGetRequestWithURL:urlStr
                      requestKey:nil
                           block:^(NSDictionary *jsonDic, NSError *error)
    {
        if (error) {
            block(nil, error);
        } else {
            block(jsonDic, nil);
        }
    }];
}

@end
