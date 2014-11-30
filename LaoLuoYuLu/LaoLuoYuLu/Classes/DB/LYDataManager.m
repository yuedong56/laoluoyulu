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

/** 获取菜单列表 */
- (NSMutableArray *)selectMenuList
{
    NSMutableArray *menuListArr = [NSMutableArray arrayWithCapacity:0];
    if ([self.lyDB open]) {
        FMResultSet *results = [self.lyDB executeQuery:[NSString stringWithFormat:@"select * from %@", kMenuTable]];
        while ([results next]) {
            MenuModel *menuModel = [[MenuModel alloc] initMenuFromDataBaseWithDic:results.resultDictionary];
            [menuListArr addObject:menuModel];
        }
        [results close];
    }
    
    [self.lyDB close];
    return menuListArr;
}

/** 根据菜单ID获取语音列表 */
- (NSMutableArray *)selectVoiceListWithMenuID:(NSString *)menuID
{
    NSMutableArray *menuListArr = [NSMutableArray arrayWithCapacity:0];
    if ([self.lyDB open]) {
        NSString *queryStr = nil;
        if ([menuID isEqualToString:@"0"]) {
            queryStr = [NSString stringWithFormat:@"select * from %@ where is_recommend = 1", kVoiceTable];
        } else {
            queryStr = [NSString stringWithFormat:@"select * from %@ where menu_id = %@", kVoiceTable, menuID];
        }
        FMResultSet *results = [self.lyDB executeQuery:queryStr];
        while ([results next]) {
            VoiceModel *voiceModel = [[VoiceModel alloc] initVoiceFromDataBaseWithDic:results.resultDictionary];
            voiceModel.menuName = [self selectMenuNameWithID:voiceModel.menuID];
            [menuListArr addObject:voiceModel];
        }
        [results close];
    }
    
    [self.lyDB close];
    return menuListArr;
}

/** 根据 menuId 选出 menuName */
- (NSString *)selectMenuNameWithID:(NSString *)menuID
{
    NSString *menuName = nil;
    NSString *queryStr = [NSString stringWithFormat:@"select name from Menu where id = '%@'", menuID];
    FMResultSet *results = [self.lyDB executeQuery:queryStr];
    while ([results next]) {
        menuName = [NSString stringWithFormat:@"%@", [results.resultDictionary valueForKey:@"name"]];
    }
    
    [results close];
    
    return menuName;
}

/** 收藏、取消收藏 */
- (void)updateVoiceIsCollected:(BOOL)isCollected voiceID:(NSString *)voiceID
{
    if ([self.lyDB open])
    {
        [self.lyDB beginTransaction];
        NSString *queryStr = [NSString stringWithFormat:@"update %@ set is_recommend = %d where id = '%@'", kVoiceTable, isCollected, voiceID];
        [self.lyDB executeUpdate:queryStr];
        [self.lyDB commit];
    }
    [self.lyDB close];
}

@end
