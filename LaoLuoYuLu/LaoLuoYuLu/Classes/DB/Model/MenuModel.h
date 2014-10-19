//
//  MenuModel.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-14.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  菜单

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;

- (id)initMenuFromDataBaseWithDic:(NSDictionary *)dic;

@end
