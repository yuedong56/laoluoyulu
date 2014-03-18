//
//  LYUserDefaults.h
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-12.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  用 NSUserDefaults 存储的

#import <Foundation/Foundation.h>


#define Access_Token_Key @"Access_Token"
#define UID_Key @"UID"


@interface LYUserDefaults : NSObject

#pragma mark - login（登录）
/**
 * @brief AccessToken
 */
+ (void)saveAccessToken:(NSString *)access_token;
+ (NSString *)getAccessToken;

/**
 * @brief uid
 */
+ (void)saveUID:(NSString *)uid;
+ (NSString *)getUID;

@end
