//
//  SHSettingVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHSettingVC.h"
#import "SHSettingLogoutCell.h"
#import "SHLoginVC.h"

@interface SHSettingVC ()

@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation SHSettingVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
}

#pragma mark - private method


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(tableView);
    
    if (indexPath.section == 3)
    {
        [self showSHAlertViewWithMessage:@"确定退出登录吗？" isWithCancelButton:YES didClickOKBlock:^(BOOL isClickOk) {
            
            if (isClickOk)
            {
                [[UserManager shareInstance] requestSSOLogout];
            }
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //特殊cell - 退出当前账号
    if (indexPath.section == 3)
    {
        SHSettingLogoutCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"logout"];
        if (!cell)
        {
            cell = [[SHSettingLogoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logout"];
        }
        return cell;
    }
    //普通cell
    else
    {
        static NSString *reuseID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        }
        
        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
#pragma mark - lazy load

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[@[@"账号管理", @"账号安全"],
                       @[@"通知", @"隐私", @"通用设置"],
                       @[@"清理缓存", @"意见反馈", @"关于微博"],
                       @[@"退出当前账号"]];
    }
    return _dataArray;
}



@end
