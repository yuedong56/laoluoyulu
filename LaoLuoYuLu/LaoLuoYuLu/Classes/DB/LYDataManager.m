//
//  LYDataManager.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LYDataManager.h"
#import "MenuModel.h"
#import "VoiceModel.h"

@implementation LYDataManager

+ (id)instance
{
    static LYDataManager *instance = nil;
    @synchronized (self)
    {
        if (instance == nil)
        {
            instance = [[LYDataManager alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *databasePath= [[paths objectAtIndex:0] stringByAppendingPathComponent:DataFileName];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:databasePath]) {
            NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DataFileName];
            [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
        }
        
        self.lyDB = [FMDatabase databaseWithPath:databasePath];
        if (![self.lyDB open]) {
            CLog(@"Could not open db.");
        }
    }
    return self;
}

/**
 * @brief 获取菜单列表
 */
- (NSMutableArray *)selectMenuList
{
    NSMutableArray *menuListArr = [NSMutableArray arrayWithCapacity:0];
    if ([self.lyDB open]) {
        FMResultSet *results = [self.lyDB executeQuery:@"select * from menu"];
        while ([results next]) {
            MenuModel *menuModel = [[MenuModel alloc] initMenuFromDataBaseWithDic:results.resultDictionary];
            [menuListArr addObject:menuModel];
        }
        [results close];
    }
    
    [self.lyDB close];
    return menuListArr;
}

/**
 * @brief 根据菜单ID获取语音列表
 */
- (NSMutableArray *)selectVoiceListWithMenuID:(NSInteger)menuID
{
    NSMutableArray *menuListArr = [NSMutableArray arrayWithCapacity:0];
    if ([self.lyDB open]) {
        FMResultSet *results = [self.lyDB executeQuery:[NSString stringWithFormat:@"select * from voice where menu_id = %d",menuID]];
        while ([results next]) {
//            VoiceModel *voiceModel = [[VoiceModel alloc] initMenuFromDataBaseWithDic:results.resultDictionary];
//            [menuListArr addObject:menuModel];
        }
        [results close];
    }
    
    [self.lyDB close];
    return menuListArr;
}

@end
