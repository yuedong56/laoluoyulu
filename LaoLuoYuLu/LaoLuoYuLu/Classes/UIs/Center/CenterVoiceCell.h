//
//  CenterCell.h
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-27.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceModel.h"

@interface CenterVoiceCell : UITableViewCell

@property (nonatomic, strong) UIImageView *addImageView;  //添加到个人列表

- (void)setContentWithModel:(VoiceModel *)model index:(int)index;

@end
