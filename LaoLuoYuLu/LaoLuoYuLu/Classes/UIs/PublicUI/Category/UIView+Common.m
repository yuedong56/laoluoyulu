//
//  UIView+Common.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-18.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

#pragma mark - UILabel
- (UILabel *)labelWithFrame:(CGRect)frame
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                    bgColor:(UIColor *)bgColor
                  alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.textAlignment = alignment;
    return label;
}

#pragma mark - UIButton
- (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    return button;
}

- (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imgName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:ImageWithFile(imgName) forState:UIControlStateNormal];
    return button;
}

- (UIButton *)buttonWithFrame:(CGRect)frame
                      imgName:(NSString *)imgName
             highlightImgName:(NSString *)highlightImgName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:ImageWithFile(imgName) forState:UIControlStateNormal];
    [button setImage:ImageWithFile(highlightImgName) forState:UIControlStateHighlighted];
    return button;
}

#pragma mark - UIImageView
- (UIImageView *)imageViewWithFrame:(CGRect)frame
                            imgName:(NSString *)imgName
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    imgView.image = ImageWithFile(imgName);
    return imgView;
}

#pragma mark - UIAlertView
+ (void)showAlertWithMsg:(NSString *)msg
                btnTitle:(NSString *)btnTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:btnTitle, nil];
    [alertView show];
}

+ (void)showAlertWithMsg:(NSString *)msg
                delegate:(id<UIAlertViewDelegate>)delegate
                btnTitle:(NSString *)btnTitle
           otherBtnTitle:(NSString *)otherBtnTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:delegate cancelButtonTitle:nil otherButtonTitles:btnTitle, otherBtnTitle, nil];
    [alertView show];
}

+ (void)showAlertWithTitle:(NSString *)title
                       msg:(NSString *)msg
                       tag:(NSInteger)tag
                  delegate:(id<UIAlertViewDelegate>)delegate
                  btnTitle:(NSString *)btnTitle
             otherBtnTitle:(NSString *)otherBtnTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:nil otherButtonTitles:btnTitle, otherBtnTitle, nil];
    alertView.tag = tag;
    [alertView show];

}

@end


