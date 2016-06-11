//
//  SHTableViewController.m
//  MicroBlog
//
//  Created by RenSihao on 15/12/24.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHTableViewController () <UITableViewDelegate,UITableViewDataSource,SHTableViewRefreshDelegate>

@property(nonatomic,assign) UITableViewStyle style;
@end

@implementation SHTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init])
    {
        _style = style;
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //修正view的正确高度
    CGRect frame = self.view.frame;
    frame.size.height -= self.navigationController.navigationBar ? NAV_BAR_HEIGHT : 0;
    self.view.frame = frame;
    
   
    [self.view addSubview:self.tableView];
    
    //初始化下拉、滚动刷新(默认不显示)
    weakSelf(self);
    [self.tableView addPullToRefreshWithActionHandler:^{
        if ([weakSelf.refreshDelegate respondsToSelector:@selector(tableViewDidTriggerHeaderRefresh)]) {
            [weakSelf.refreshDelegate tableViewDidTriggerHeaderRefresh];
        }
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if ([weakSelf.refreshDelegate respondsToSelector:@selector(tableViewDidTriggerFooterRefresh)]) {
            [weakSelf.refreshDelegate tableViewDidTriggerFooterRefresh];
        }
    }];
    self.refreshDelegate = self;
    self.enableHeaderRefresh = NO;
    self.enableFooterRefresh = NO;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
}
- (void)dealloc
{
    NSLog(@"!!! %@ %s !!!", [self class], __func__);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView)
    {
        CGRect frame = self.view.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        _tableView = [[UITableView alloc] initWithFrame:frame style:_style];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kColorBgMain;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - Refresh Setter

- (void)setEnableHeaderRefresh:(BOOL)enableHeaderRefresh
{
    _enableHeaderRefresh = enableHeaderRefresh;
    if (_enableHeaderRefresh) {
        self.tableView.showsPullToRefresh = YES;
    }
    else{
        self.tableView.showsPullToRefresh = NO;
    }
}

- (void)setEnableFooterRefresh:(BOOL)enableFooterRefresh
{
    _enableFooterRefresh = enableFooterRefresh;
    if (_enableFooterRefresh) {
        self.tableView.showsInfiniteScrolling = YES;
    }
    else{
        self.tableView.showsInfiniteScrolling = NO;
    }
}

#pragma mark - Refresh

- (void)tableViewDidFinishTriggerWithReload:(BOOL)reload
{
    weakSelf(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (reload) {
            [weakSelf.tableView reloadData];
        }
        if (weakSelf.tableView.showsPullToRefresh
            && weakSelf.tableView.pullToRefreshView.state != SVPullToRefreshStateStopped)
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        if (weakSelf.tableView.showsInfiniteScrolling
            && weakSelf.tableView.infiniteScrollingView.state != SVInfiniteScrollingStateStopped)
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}



@end
