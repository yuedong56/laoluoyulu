//
//  LeftMenuViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define TableHeader_Height 100
#define Header_Height 25

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"
#import "MenuModel.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = DarkGrayColor;
    self.navigationController.navigationBarHidden = YES;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.menuListArr = [[LYDataManager instance] selectMenuList];
    
    [self initTableHeadView];
}


/**
 * @brief 初始化 TableHeadView
 */
- (void)initTableHeadView
{
    self.tableHeadView = [[TableHeadView alloc] initWithFrame:CGRectMake(0, 0, LeftMenuWidth, TableHeader_Height)];
    self.tableHeadView.backgroundColor = DarkGrayColor;
    self.tableView.tableHeaderView = self.tableHeadView;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.menuListArr.count;
    } else if (section == 1) {
        return 3;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        MenuModel *model = [self.menuListArr objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.name;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"系统设置";
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"关于";
        } else {
            cell.titleLabel.text = @"应用推荐";
        }
    }
    
    cell.leftImageView.image = ImageNamed(@"demoLeftImage.png");
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Row_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Header_Height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LeftMenuWidth, Header_Height)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerView.frame];
    titleLabel.backgroundColor = GrayColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = WhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
    if (section == 0) {
        titleLabel.text = @"老罗语录";
    } else {
        titleLabel.text = @"设置";
    }
    
    return headerView;
}

@end


