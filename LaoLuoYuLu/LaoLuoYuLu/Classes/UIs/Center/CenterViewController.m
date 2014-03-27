//
//  CenterViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterVoiceCell.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (instancetype)initWithMenu:(MenuModel *)menu
{
    self = [super init];
    if (self) {
        self.currentMenuModel = menu;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.titleLabel.text = self.currentMenuModel.name;
    
    self.voiceListArr = [[LYDataManager instance] selectVoiceListWithMenuID:self.currentMenuModel.ID];
    
    self.voiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, IOS7AndLater?64:0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.voiceTableView.dataSource = self;
    self.voiceTableView.delegate = self;
    [self.view addSubview:self.voiceTableView];
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.voiceListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    CenterVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CenterVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    VoiceModel *voiceModel = [self.voiceListArr objectAtIndex:indexPath.row];
    cell.textLabel.text = voiceModel.name;
    
    return cell;
}

@end
