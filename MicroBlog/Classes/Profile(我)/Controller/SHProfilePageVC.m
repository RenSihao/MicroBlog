//
//  SHProfilePageVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/13.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHProfilePageVC.h"
#import "SHNavTitleLab.h"
#import "SHProfilePageHeadView.h"
#import "SHProfilePageHeadSectionView.h"
#import "SHBlogViewCell.h"
#import "SHStatusModel.h"

@interface SHProfilePageVC ()
<
SHProfilePageHeadSectionViewDelegate
>

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) SHProfilePageHeadSectionView *headSectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SHProfilePageVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //加载自定义NavBar
    [self.view addSubview:self.navBar];
    
    //设置tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height + NAV_BAR_HEIGHT);
    [self.tableView registerClass:[SHProfilePageHeadView class] forCellReuseIdentifier:NSStringFromClass([SHProfilePageHeadView class])];
    [self.tableView registerClass:[SHBlogViewCell class] forCellReuseIdentifier:NSStringFromClass([SHBlogViewCell class])];
    
    //抓取数据
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchUserTimelineData];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - private method

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
/**
 *  获取授权用户发布的所有微博
 */
- (void)fetchUserTimelineData
{
    weakSelf(self);
    [WBHttpRequest requestWithURL:Weibo_User_Timeline_URL
                       httpMethod:Weibo_HttpMethod_GET
                           params:@{@"access_token":[UserManager shareInstance].userSecurity.accessToken} queue:nil
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                
                if (error)
                {
                    
                }
                else
                {
                    //拿到所有微博的id
                    NSArray *statuses = result[@"statuses"];
                    
                    //逐个发请求 - 获取详细信息
                    for (int i=0; i<statuses.count; i++)
                    {
                        NSNumber *weiboID = statuses[i];
                        [WBHttpRequest requestWithURL:Weibo_Statuses_Show_URL
                                           httpMethod:Weibo_HttpMethod_GET
                                               params:@{@"access_token":[UserManager shareInstance].userSecurity.accessToken,
                                                        @"id":weiboID}
                                                queue:[NSOperationQueue mainQueue]
                                withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                                    if (error)
                                    {
                                        
                                    }
                                    else
                                    {
                                        SHStatusModel *statusModel = [SHStatusModel mj_objectWithKeyValues:result];
                                        [weakSelf.dataArray addObject:statusModel];
                                        
                                        //必须成功获取所有微博内容才能刷新
                                        if (i == statuses.count-1)
                                        {
                                            [weakSelf.tableView reloadData];
                                        }
                                        [weakSelf.tableView reloadData];
                                    }
                                }];
                    }
                    
                    
                }
            }];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0)
    {
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        self.navBar.backgroundColor = [UIColorFromRGB_0x(0xeFeFF4) colorWithAlphaComponent:alpha];
        
        if (offsetY > NAV_BAR_HEIGHT)
        {
            
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    else
    {
        self.navBar.backgroundColor = [UIColorFromRGB_0x(0xeFeFF4) colorWithAlphaComponent:0];
    }
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self cellHeightForIndexPath:indexPath
                        cellContentViewWidth:SCREEN_WIDTH
                                   tableView:tableView];
    return h;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.headSectionView.height;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.headSectionView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.dataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        SHProfilePageHeadView *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHProfilePageHeadView class])];
        cell.model = [UserManager shareInstance].userModel;
        return cell;
    }
    if (indexPath.section == 1)
    {
        SHBlogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHBlogViewCell class])];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
    return nil;
}

#pragma mark - SHProfilePageHeadSectionViewDelegate

- (void)profileHeadSectionView:(SHProfilePageHeadSectionView *)sectionView didClickIndex:(NSInteger)index
{
    
}


#pragma mark - lazy load

- (UINavigationBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_BAR_HEIGHT)];
        for (UIView *view in _navBar.subviews)
        {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
            {
                [view removeFromSuperview];
            }
        }
        _navBar.translucent = YES;
        
        UINavigationItem *item = [[UINavigationItem alloc] init];
        item.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
        SHNavTitleLab *titleLab = [[SHNavTitleLab alloc] initWithTitle:[UserManager shareInstance].userModel.name];
        titleLab.alpha = 0;
        item.titleView = titleLab;
        
        [_navBar pushNavigationItem:item animated:NO];
    }
    return _navBar;
}
- (SHProfilePageHeadSectionView *)headSectionView
{
    if (!_headSectionView)
    {
        _headSectionView = [[SHProfilePageHeadSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _headSectionView.delegate = self;
    }
    return _headSectionView;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
