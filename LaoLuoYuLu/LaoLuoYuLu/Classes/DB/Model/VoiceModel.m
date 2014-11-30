//
//  VoiceModel.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "VoiceModel.h"

@implementation VoiceModel

- (instancetype)initVoiceFromDataBaseWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.ID       = [NSString stringWithFormat:@"%@", [dic valueForKey:@"id"]];
        self.menuID   = [NSString stringWithFormat:@"%@", [dic valueForKey:@"menu_id"]];
        self.name     = [NSString stringWithFormat:@"%@", [dic valueForKey:@"name"]];
        self.duration = [NSString stringWithFormat:@"%@", [dic valueForKey:@"duration"]];
        self.size     = [NSString stringWithFormat:@"%@", [dic valueForKey:@"size"]];
        self.isCollected = [[NSString stringWithFormat:@"%@", [dic valueForKey:@"is_recommend"]] boolValue];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"_ID = %@, _menuID = %@, _name = %@, _duration = %@, _size = %@, _isCollected = %d", _ID, _menuID, _name, _duration, _size, _isCollected];
}

@end
