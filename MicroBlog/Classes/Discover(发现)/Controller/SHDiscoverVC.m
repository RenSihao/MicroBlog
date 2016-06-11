//
//  SHDiscoverViewController.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHDiscoverVC.h"
#import "SHDiscoverHeaderModel.h"
#import "SHDiscoverHeaderView.h"
#import "SHDiscoverCell.h"
#import "SHDiscoverCellModel.h"
#import "SHDiscoverCycleView.h"
#import "SHBlogDetailWebVC.h"

#define kDiscoverCycleScrollViewID @"DiscoverCycleScrollView"
#define kDiscoverHeaderViewID      @"DiscoverHeaderView"
#define kDiscoverCellID            @"DiscoverCell"

@interface SHDiscoverVC ()
<
SHDiscoverCycleVeiwDelegate,
SHDiscoverHeaderViewDelegate
>

@property (nonatomic, strong) SHDiscoverCycleView *cycleView;   //广告循环轮播视图
@property (nonatomic, strong) SHDiscoverHeaderView *headerView; //四个热门话题视图
@property (nonatomic, strong) NSDictionary *cellDataDict;
@property (nonatomic, strong) NSArray *cellDataArray;
@end

@implementation SHDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加所有子控件
    [self addAllSubViews];
    
    //抓取数据
//    [self fetchData];
    
    

}

//- (void)setUpNavigationBar
//{
//    //添加搜索框在NavigationBar上
//    UITextField *searchBar = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
////    searchBar.bounds = CGRectMake(0, 0, 100, 10);
////    searchBar.frame = CGRectMake(20, 0, SCREEN_WIDTH - 20 * 2, 10); 有问题 设置无效？！
//    searchBar.placeholder = @"大家都在搜：七名官员非正常死亡";
//    searchBar.background = [UIImage imageWithStrechableName:@"searchbar_textfield_background"];
//    
//    //设置左边的放大镜
//    searchBar.leftViewMode = UITextFieldViewModeAlways;
//    searchBar.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
//    
//    
//    self.navigationItem.titleView = searchBar;
//    int i = 1;
//    for(UISearchBar *bar in self.navigationController.navigationBar.subviews)
//    {
////        if([bar isKindOfClass:<#(__unsafe_unretained Class)#>))
//        NSLog(@"i = %d", i);
//        NSLog(@"%lf %lf %lf %lf", bar.frame.origin.x, bar.frame.origin.y, bar.frame.size.width, bar.frame.size.height);
//        i++;
//    }
//    
//    
//}
//
#pragma mark - private method

- (void)addAllSubViews
{
    
}
- (void)fetchData
{
    //获取数据模型并更新
    NSDictionary *dict = @{@"leftTopTitle":@"#奶酪陷阱#",
                           @"rightTopTitle":@"#朝鲜半岛核危机#",
                           @"leftBottomTitle":@"一张有态度的照片",
                           @"rightBotttomTitle":@"热门话题"};
    SHDiscoverHeaderModel *headerModel = [[SHDiscoverHeaderModel alloc] initWithDict:dict];
    [self.headerView updateWithDiscoverHeaderModel:headerModel];
}

#pragma mark - lazy load

- (SHDiscoverCycleView *)cycleView
{
    if (!_cycleView)
    {
        _cycleView = [[SHDiscoverCycleView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDiscoverCycleScrollViewID];
    }
    return _cycleView;
}
- (SHDiscoverHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[SHDiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _headerView;
}
- (NSDictionary *)cellDataDict
{
    if (!_cellDataDict)
    {
        NSArray *array1 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"hot_status", @"title":@"热门微博", @"detailTitle":@"全站最热微博尽搜罗", @"hasNewNotification":@"1"},
                           @{@"iconImage":@"find_people", @"title":@"找人", @"detailTitle":@"", @"hasNewNotification":@"0"}, nil];
        NSArray *array2 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"video", @"title":@"视频", @"detailTitle":@"", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"game_center", @"title":@"玩游戏", @"detailTitle":@"全站最热微博尽搜罗", @"hasNewNotification":@"1"},
                           @{@"iconImage":@"near", @"title":@"周边", @"detailTitle":@"发现“漕河泾”新鲜事", @"hasNewNotification":@"0"}, nil];
        NSArray *array3 = [NSArray arrayWithObjects:
                           @{@"iconImage":@"app", @"title":@"应用", @"detailTitle":@"您有红包尚未领取，逾期将作废", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"movie", @"title":@"电影", @"detailTitle":@"", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"music", @"title":@"音乐", @"detailTitle":@"", @"hasNewNotification":@"0"},
                           @{@"iconImage":@"more", @"title":@"更多频道", @"detailTitle":@"", @"hasNewNotification":@"0"}, nil];
        _cellDataDict = @{@"array1":array1, @"array2":array2, @"array3":array3};
    }
    return _cellDataDict;
}

- (NSArray *)cellDataArray
{
    if (!_cellDataArray)
    {
        _cellDataArray = @[@[@{@"iconImage":@"hot_status", @"title":@"热门微博", @"detailTitle":@"全站最热微博尽搜罗", @"hasNewNotification":@"1"},
                             @{@"iconImage":@"find_people", @"title":@"找人", @"detailTitle":@"", @"hasNewNotification":@"0"}],
                           @[@{@"iconImage":@"video", @"title":@"视频", @"detailTitle":@"", @"hasNewNotification":@"0"},
                             @{@"iconImage":@"game_center", @"title":@"玩游戏", @"detailTitle":@"全站最热微博尽搜罗", @"hasNewNotification":@"1"},
                             @{@"iconImage":@"near", @"title":@"周边", @"detailTitle":@"发现“漕河泾”新鲜事", @"hasNewNotification":@"0"}],
                           @[@{@"iconImage":@"app", @"title":@"应用", @"detailTitle":@"您有红包尚未领取，逾期将作废", @"hasNewNotification":@"0"},
                             @{@"iconImage":@"movie", @"title":@"电影", @"detailTitle":@"", @"hasNewNotification":@"0"},
                             @{@"iconImage":@"music", @"title":@"音乐", @"detailTitle":@"", @"hasNewNotification":@"0"},
                             @{@"iconImage":@"more", @"title":@"更多频道", @"detailTitle":@"", @"hasNewNotification":@"0"}]];
    }
    return _cellDataArray;
}

#pragma mark - SHDiscoverCycleViewDelegate

- (void)discoverCycleView:(SHDiscoverCycleView *)discoverCycleView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"当前点击了%ld图片", index);
    SHBlogDetailWebVC *blogDetailWebVC = nil;
    if (index == 1 || index == 3)
    {
         blogDetailWebVC = [[SHBlogDetailWebVC alloc] initWithTitle:@"微博正文" url:@"http:\/\/ecstore.shopex123.com\/penker\/index.php\/wap\/product-94-penker.html"];
    }
    else
    {
         blogDetailWebVC = [[SHBlogDetailWebVC alloc] initWithTitle:@"微博正文" url:@"http:\/\/ecstore.shopex123.com\/penker\/index.php\/wap\/product-93-penker.html"];
    }
    [self.navigationController pushViewController:blogDetailWebVC animated:YES];
}

#pragma mark - SHDiscoverHeaderViewDelegate

- (void)discoverHeaderView:(SHDiscoverHeaderView *)discoverHeaderView didClickItemAtIndex:(NSInteger)index
{
    NSLog(@"当前点击了第%ld个热门话题", index);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellDataDict.count + 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    if (section == 1)
    {
        return 1;
    }
    if (section == 2)
    {
        NSArray *array = [self.cellDataDict objectForKeyNotNull:@"array1"];
        return array.count;
    }
    if (section == 3)
    {
        NSArray *array = [self.cellDataDict objectForKeyNotNull:@"array2"];
        return array.count;
    }
    if (section == 4)
    {
        NSArray *array = [self.cellDataDict objectForKeyNotNull:@"array3"];
        return array.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第0组 轮播滚动广告
    if (indexPath.section == 0)
    {
        SHDiscoverCycleView *cycleView = [tableView dequeueReusableCellWithIdentifier:kDiscoverCycleScrollViewID];
        if (!cycleView)
        {
            cycleView = [[SHDiscoverCycleView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDiscoverCycleScrollViewID];
        }
        cycleView.delegate = self;

        return cycleView;
    }
    //第1组 四个热点话题
    else if (indexPath.section == 1)
    {
        SHDiscoverHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:kDiscoverHeaderViewID];
        if (!headerView)
        {
            headerView = [[SHDiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        }
        headerView.delegate = self;
        SHDiscoverHeaderModel *headerModel = [SHDiscoverHeaderModel new];
        headerModel.leftTopTitle = @"热点话题一";
        headerModel.rightTopTitle = @"热点话题二";
        headerModel.leftBottomTitle = @"热点话题三";
        headerModel.rightBotttomTitle = @"热点话题四";
        
        [headerView updateWithDiscoverHeaderModel:headerModel];
        return headerView;
    }
    //其他 普通cell 共3组
    else
    {
        SHDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:kDiscoverCellID];
        if (!cell)
        {
            cell = [[SHDiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDiscoverCellID];
        }
        NSArray *array = [NSArray array];
        switch (indexPath.section) {
            case 2:
            {
                array = [self.cellDataDict objectForKeyNotNull:@"array1"];
            }
                break;
            case 3:
            {
                array = [self.cellDataDict objectForKeyNotNull:@"array2"];
            }
                break;
            case 4:
            {
                array = [self.cellDataDict objectForKeyNotNull:@"array3"];
            }
                break;
                
            default:
                break;
        }
        
        SHDiscoverCellModel *model = [[SHDiscoverCellModel alloc] initWithDict:array[indexPath.row]];
        [cell updateWithDiscoverCellModel:model];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 120.f;
    }
    if (indexPath.section == 1)
    {
        return 100.f;
    }
    return [SHDiscoverCell cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(tableView);
    
    SHDiscoverCellModel *cellModel = [[SHDiscoverCellModel alloc] initWithDict:self.cellDataArray[indexPath.section - 2][indexPath.row]];

    SHBlogDetailWebVC *detailWebVC = [[SHBlogDetailWebVC alloc] initWithTitle:cellModel.title url:@"http:\/\/ecstore.shopex123.com\/penker\/index.php\/wap\/product-92-penker.html"];
    [self.navigationController pushViewController:detailWebVC animated:YES];
}



@end
