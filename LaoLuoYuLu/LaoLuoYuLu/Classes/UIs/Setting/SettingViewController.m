//
//  SettingViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-10-8.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define kHeaderColor COLOR_F(0.9)
#define kHeaderHeight 26

#import "SettingViewController.h"
#import "SettingCell.h"

@interface SettingViewController ()
{
    UITableView *table;
    NSMutableArray *lists;
}

@end

@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initLists];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.titleLabel.text = @"系统设置";
    [self.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftButton addTarget:self
                        action:@selector(leftButtonPress:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self initTableView];
}

/** 初始化数组 */
- (void)initLists
{
    lists = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableArray *sections0 = [NSMutableArray arrayWithCapacity:0];
    [sections0 addObject:@"吐槽提意见"];
    [lists addObject:sections0];
    
    NSMutableArray *sections1 = [NSMutableArray arrayWithCapacity:0];
    [sections1 addObject:@"检查更新"];
    [sections1 addObject:@"我要打分"];
    [lists addObject:sections1];
    
    NSMutableArray *sections2 = [NSMutableArray arrayWithCapacity:0];
    [sections2 addObject:@"关于作者"];
    [lists addObject:sections2];
}

/** 初始化列表 */
- (void)initTableView
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = kHeaderColor;
    table.bounces = NO;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

#pragma mark - Button Events
/** 取消按钮 */
- (void)leftButtonPress:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return lists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *sectionArr = [lists objectAtIndex:section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"cellIndetifier";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    
    if (!cell)
    {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIndetifier];
    }
    
    if (indexPath.section==1 && indexPath.row==0)  //分割线
    {
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 1)];
        line.image = kSeperateLineImage;
        [cell addSubview:line];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSMutableArray *secArr = [lists objectAtIndex:indexPath.section];
    NSString *title = [secArr objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeaderHeight)];
    headerView.backgroundColor = kHeaderColor;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


