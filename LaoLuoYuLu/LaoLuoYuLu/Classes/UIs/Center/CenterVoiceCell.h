//
//  CenterCell.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-27.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define kCenterVoiceCell_H 44
#define kSelectView_W 8

#import <UIKit/UIKit.h>
#import "VoiceModel.h"

@interface CenterVoiceCell : UITableViewCell
{
    UIView *selectView;  //标识正在播放的view
}

@property (nonatomic, strong) UIButton *collectButton;  //收藏到个人列表

- (void)setContentWithModel:(VoiceModel *)model index:(int)index;

@end
