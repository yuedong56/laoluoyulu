//
//  MMDrawerController+Rotate.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-17.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "MMDrawerController+Rotate.h"

@implementation MMDrawerController (Rotate)

//ios5.X
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

//ios6.X and later
- (BOOL)shouldAutorotate
{
    return NO;
}

//ios6.X and later
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
