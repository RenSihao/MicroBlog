//
//  SHMessageViewController.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHMessageVC.h"
#import "SHMessageDetailVC.h"
#import "SHSearchView.h"
#import "SHFindFriendsVC.h"
#import "SHStartChatVC.h"

@interface SHMessageVC ()
<
SHSearchViewDelegate
>

@property (nonatomic, strong) SHSearchView *searchView; //头部搜索框
@end

@implementation SHMessageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.enableHeaderRefresh = YES;
    self.enableFooterRefresh = YES;
    
    self.tableView.tableHeaderView = self.searchView;
}

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    // right
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStylePlain target:self action:@selector(didClickFindFriends)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // left
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"发现群" style:UIBarButtonItemStylePlain target:self action:@selector(didClickStartChat)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // titleView
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"MessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    switch (indexPath.row) {
        case MessageCenterAt:
        {
            cell.textLabel.text = @"@我的";
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_at"];
        }
            break;
        case MessageCenterComments:
        {
            cell.textLabel.text = @"评论";
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_comments"];
        }
            break;
        case MessageCenterGood:
        {
            cell.textLabel.text = @"赞";
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_good"];
        }
            break;
        case MessageCenterSubScription:
        {
            cell.textLabel.text = @"订阅消息";
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_subscription"];
        }
            break;
        case MessageCenterMessageBox:
        {
            cell.textLabel.text = @"未关注人消息";
            cell.imageView.image = [UIImage imageNamed:@"messagescenter_messagebox"];
        }
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(tableView);
    SHMessageDetailVC *messageDetailVC = [[SHMessageDetailVC alloc] initWithStyle:UITableViewStylePlain type:indexPath.row];
    [self.navigationController pushViewController:messageDetailVC animated:YES];
}

#pragma mark - SHTableViewRefreshDelegate

- (void)tableViewDidTriggerHeaderRefresh
{
    weakSelf(self);
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [weakSelf tableViewDidFinishTriggerWithReload:YES];
    });
}
- (void)tableViewDidTriggerFooterRefresh
{
    weakSelf(self);
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [weakSelf tableViewDidFinishTriggerWithReload:YES];
    });
}

#pragma mark - SHSearchViewDelegate

- (void)didClickSearchView:(SHSearchView *)searchView
{
    NSLog(@"点击了搜索框");
}

#pragma mark - 监听导航栏点击

- (void)didClickFindFriends
{
    SHFindFriendsVC *findFriensVC = [[SHFindFriendsVC alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:findFriensVC animated:YES];
}
- (void)didClickStartChat
{
    SHStartChatVC *startChatVC = [[SHStartChatVC alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:startChatVC animated:YES];
}

#pragma mark - lazy laod

- (SHSearchView *)searchView
{
    if (!_searchView)
    {
        _searchView = [[SHSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.f)];
        _searchView.delegate = self;
    }
    return _searchView;
}


@end
