//
//  AboutViewController.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-9.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@end



@interface AboutCell : UITableViewCell
{
    UIImageView *seperateLine;
}

/** isLast: 是否是最后一个cell */
- (void)setContentWithType:(BOOL)isLast;

@end