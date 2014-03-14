//
//  LeftMenuViewController.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"
#import "MenuModel.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = LightGrayColor;
    self.navigationController.navigationBarHidden = YES;
    
    self.menuListArr = [[LYDataManager instance] selectMenuList];
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
        cell.textLabel.text = model.name;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end


