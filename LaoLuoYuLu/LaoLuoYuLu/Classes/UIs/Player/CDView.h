//
//  CDView.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-30.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define SmallCDImageView_Width 120.0f
#define SmallCDImageView_Height 118.0f

#define BigCDImageView_Width 300.0f
#define BigCDImageView_Height 293.0f

#import <UIKit/UIKit.h>

@class StylusView;
@interface CDView : UIView

/** 磁盘内圈 */
@property (strong, nonatomic) UIImageView *smallCDImageView;
/** 磁盘外圈 */
@property (strong, nonatomic) UIImageView *bigCDImageView;
/** 唱针 */
@property (strong, nonatomic) StylusView *stylusView;

@end


@interface StylusView : UIView

@end