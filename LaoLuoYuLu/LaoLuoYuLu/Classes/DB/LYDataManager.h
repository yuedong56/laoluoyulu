//
//  LYDataManager.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define DataFileName @"dataList.sqlite" //数据库文件名

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface LYDataManager : NSObject

@property (nonatomic, strong) FMDatabase *lyDB;

+ (id)instance;

/**
 * @brief 获取菜单列表
 */
- (NSMutableArray *)selectMenuList;

/**
 * @brief 根据菜单ID获取语音列表
 */
- (NSMutableArray *)selectVoiceListWithMenuID:(NSInteger)menuID;

@end
