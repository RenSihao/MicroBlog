//
//  SHProfileViewController.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHProfileVC.h"
#import "SHProfileHeaderView.h"
#import "SHUserModel.h"
#import "SHProfileCell.h"
#import "SHProfileCellModel.h"
#import "SHSettingVC.h"
#import "SHProfilePageVC.h"

@interface SHProfileVC () <SHProfileBlogCountViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;     //本页面所有数据
@end

@implementation SHProfileVC

#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[SHProfileHeaderView class] forCellReuseIdentifier:NSStringFromClass([SHProfileHeaderView class])];
    [self.tableView registerClass:[SHProfileBlogCountView class] forCellReuseIdentifier:NSStringFromClass([SHProfileBlogCountView class])];
    [self.tableView registerClass:[SHProfileCell class] forCellReuseIdentifier:NSStringFromClass([SHProfileCell class])];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![UserManager shareInstance].userModel)
    {
        [[UserManager shareInstance] requestUserInfo];
    }
}

#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemDidClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - lazy load

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        NSArray *array0 = [NSArray arrayWithObjects:
                           @{@"avatar":@"0.jpg", @"nickName":@"这是微博昵称哈哈", @"introducation":@"这是微博个人简介嘻嘻", @"level":@"0"},
                           @{@"weiboCount":@"92", @"focusCount":@"123", @"fansCount":@"61"}, nil];
        
        NSArray *array1 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"新的好友", @"detailTitle":@"", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"game_center", @"title":@"微博等级", @"detailTitle":@"升等级，得奖励", @"hasNewNotification":@"1"}, nil];
        NSArray *array2 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"我的相册", @"detailTitle":@"", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"game_center", @"title":@"我的点评", @"detailTitle":@"", @"hasNewNotification":@"1"},
                           @{@"iconImage":@"near", @"title":@"我的赞", @"detailTitle":@"", @"hasNewNotification":@"0"}, nil];
        NSArray *array3 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"微博会员", @"detailTitle":@"卡片背景、送流量", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"game_center", @"title":@"微博支付", @"detailTitle":@"新年好礼享不停", @"hasNewNotification":@"1"},
                           @{@"iconImage":@"near", @"title":@"微博运动", @"detailTitle":@"步数、卡路里、跑步轨迹", @"hasNewNotification":@"0"}, nil];
        NSArray *array4 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"粉丝服务", @"detailTitle":@"设置私信互动", @"hasNewNotification":@"0"}, nil];
        NSArray *array5 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"草稿箱", @"detailTitle":@"", @"hasNewNotification":@"0"}, nil];
        NSArray *array6 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"更多", @"detailTitle":@"文章、收藏", @"hasNewNotification":@"0"}, nil];
        
        _dataArray = [NSArray arrayWithObjects:array0, array1, array2, array3, array4, array5, array6, nil];
        
    }
    return _dataArray;
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头部 分别有两行特殊cell
    if (indexPath.section == 0)
    {   
        //个人形象
        if (indexPath.row == 0)
        {
            SHProfileHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHProfileHeaderView class])];
            [headerView configureProfileHeaderViewWithUserModel:[UserManager shareInstance].userModel];
            return headerView;
        }
        //微博详情
        if (indexPath.row == 1)
        {
            SHProfileBlogCountView *blogCountView = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHProfileBlogCountView class])];
            blogCountView.delegate = self;
            blogCountView.userInteractionEnabled = NO;
            [blogCountView configureProfileBlogCountViewWithUserModel:[UserManager shareInstance].userModel];
            return blogCountView;
        }
    }
    
    //其余正常cell
    NSArray *array = self.dataArray[indexPath.section];
    NSDictionary *dict = array[indexPath.row];
    SHProfileCellModel *model = [[SHProfileCellModel alloc] initWithDict:dict];
    
    SHProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHProfileCell class])];
    if (!cell)
    {
        cell = [[SHProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([SHProfileCell class])];
    }
    [cell updateWithProfileCellModel:model];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [self cellHeightForIndexPath:indexPath
                       cellContentViewWidth:SCREEN_WIDTH
                                  tableView:tableView];
    }
    return [SHProfileCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(tableView);
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        SHProfilePageVC *profilePageVC = [[SHProfilePageVC alloc] init];
        [self.navigationController pushViewController:profilePageVC animated:YES];
    }
}

#pragma mark - SHProfileBlogCountViewDelegate

- (void)profileCountView:(SHProfileBlogCountView *)view didClickItem:(NSInteger)index
{
    if (index == 0)
    {
        NSLog(@"fa");
    }
    else if (index == 1)
    {
        
    }
    else if (index == 2)
    {
        
    }
}


#pragma mark - 监听导航栏点击

- (void)rightItemDidClick
{
    NSLog(@"%s", __func__);
    
    SHSettingVC *settingVC = [[SHSettingVC alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - 通知相关

- (void)addNotificationObservers
{
    [super addNotificationObservers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFetchUserInfo) name:kNotificationDidFetchUserInfo object:nil];
}
- (void)removeNotificationObservers
{
    [super removeNotificationObservers];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didFetchUserInfo
{
    [self.tableView reloadData];
}



@end
