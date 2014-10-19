//
//  UIView+Common.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-18.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

#pragma mark - UILabel
- (UILabel *)labelWithFrame:(CGRect)frame
                       font:(UIFont *)font
                 textColor:(UIColor *)textColor
                   bgColor:(UIColor *)bgColor
                 alignment:(NSTextAlignment)alignment;

#pragma mark - UIButton
- (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title;
- (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imgName;
- (UIButton *)buttonWithFrame:(CGRect)frame
                      imgName:(NSString *)imgName
             highlightImgName:(NSString *)highlightImgName;


#pragma mark - UIImageView
- (UIImageView *)imageViewWithFrame:(CGRect)frame
                            imgName:(NSString *)imgName;

#pragma mark - UIAlertView
+ (void)showAlertWithMsg:(NSString *)msg
                btnTitle:(NSString *)btnTitle;

+ (void)showAlertWithMsg:(NSString *)msg
                delegate:(id<UIAlertViewDelegate>)delegate
                btnTitle:(NSString *)btnTitle
           otherBtnTitle:(NSString *)otherBtnTitle;

@end
