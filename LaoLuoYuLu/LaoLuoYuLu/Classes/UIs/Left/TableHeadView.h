//
//  TableHeadView.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-13.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define TableHeader_Height 80
#define HeadImage_Width 60

#import <UIKit/UIKit.h>

@interface TableHeadView : UIView

@property (nonatomic, strong) UIImageView *headImageView;//头像
@property (nonatomic, strong) UILabel *titleLabel;

@end
