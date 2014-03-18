//
//  BaseViewController.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-15.
//  Copyright (c) 2014年 LYue. All rights reserved.
//
//  基类

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLabel;   //导航栏标题
@property (nonatomic, strong) UIButton *leftButton;  //左按钮
@property (nonatomic, strong) UIButton *rightButton; //右按钮

@end
