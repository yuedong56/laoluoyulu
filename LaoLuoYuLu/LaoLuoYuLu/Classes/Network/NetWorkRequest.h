//
//  NetWorkRequest.h
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-13.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface NetWorkRequest : NSObject

#pragma mark - 登录

/**
 * @brief 检查 AccessToken 是否过期
 */
 

/**
 * @brief 获取授权过的 Access_Token、uid
 * @param authorizeCode 登录页面返回的code
 */
+ (void)requestAccessTokenWithAuthorizeCode:(NSString *)authorizeCode
                                      block:(void(^)(NSDictionary *jsonDic, NSError *error))block;

#pragma mark - 用户
/**
 * @brief 根据用户ID获取用户信息
 */
+ (void)requestUserInfoWithUID:(NSString *)uid
                         block:(void(^)(NSDictionary *jsonDic, NSError *error))block;

@end
