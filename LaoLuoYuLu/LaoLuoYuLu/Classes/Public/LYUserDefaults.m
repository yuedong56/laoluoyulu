//
//  LYUserDefaults.m
//  LaoYueWeiBo
//
//  Created by 老岳 on 14-1-12.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LYUserDefaults.h"

@implementation LYUserDefaults

/**
 * @brief public method
 */
+ (void)saveValue:(NSString *)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - login（登录）
/**
 * @brief AccessToken
 */
+ (void)saveAccessToken:(NSString *)access_token
{
    [self saveValue:access_token forKey:Access_Token_Key];
}

+ (NSString *)getAccessToken
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:Access_Token_Key];
}

/**
 * @brief uid
 */
+ (void)saveUID:(NSString *)uid
{
    [self saveValue:uid forKey:UID_Key];
}

+ (NSString *)getUID
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:UID_Key];
}

@end
