//
//  SHHomeViewController.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHHomeVC.h"
#import "SHTitleButton.h"
#import "SHPopMenuView.h"
#import "SHHomePopVC.h"
#import "SHLeftItemVC.h"
#import "SHBlogViewCell.h"
#import "SHBlogDetailModel.h"
#import "SHBlogDetailWebVC.h"
#import "SHStatusModel.h"
#import "SHRepostWeiboVC.h"
#import "SHCommentVC.h"

@interface SHHomeVC ()
<
SHBlogViewCellDelegate,
SHHomePopViewDelegate,
SHTableViewRefreshDelegate
>

@property (nonatomic, strong) SHTitleButton *selectedBtn;  //当前被选中按钮
@property (nonatomic, strong) SHHomePopVC *popVC;          //当前弹出popVC

@property (nonatomic, copy) NSMutableArray *dataArray;
@end

@implementation SHHomeVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[SHBlogViewCell class] forCellReuseIdentifier:NSStringFromClass([SHBlogViewCell class])];
    
    //默认 - 获取最新公众微博
//    [self fetchPublicWeiboData];
    
    //可以上拉下拉
    self.enableHeaderRefresh = YES;
    self.enableFooterRefresh = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![UserManager shareInstance].userSecurity.accessToken)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark  - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    //left
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendattention"] highImage:[UIImage imageNamed:@"navigationbar_friendattention_highlighted"] target:self action:@selector(leftItemDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    //right
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_icon_radar"] highImage:[UIImage imageNamed:@"navigationbar_icon_radar_highlighted"] target:self action:@selector(rightItemDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    //titleView
    SHTitleButton *titleButton = [SHTitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleButton.adjustsImageWhenHighlighted = NO;
    [titleButton addTarget:self action:@selector(titleViewDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}
/**
 *  获取最新公共微博
 */
- (void)fetchPublicWeiboData
{
    weakSelf(self);
    [WBHttpRequest requestWithURL:Weibo_Public_URL
                       httpMethod:Weibo_HttpMethod_GET
                           params:@{@"access_token":[UserManager shareInstance].userSecurity.accessToken} queue:nil
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
                if (error)
                {
                    
                }
                else
                {
                    NSArray *statuses = result[@"statuses"];
                    for (NSDictionary *weibo in statuses)
                    {
                        SHStatusModel *statusModel = [SHStatusModel mj_objectWithKeyValues:weibo];
                        
                        [weakSelf.dataArray addObject:statusModel];
                    }
                    [weakSelf tableViewDidFinishTriggerWithReload:YES];
                }
    }];
}
/**
 *  获取自己和所有关注用户的最新微博 (暂时废弃 微博不给返回未授权用户)
 */
- (void)fetchFriendsTimelineData
{
    weakSelf(self);
    [WBHttpRequest requestWithURL:Weibo_Friends_Timeline_URL
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
                                        [weakSelf tableViewDidFinishTriggerWithReload:YES];
                                    }
                                }];
                    }
                    
                    
                }
            }];
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
                                        [weakSelf tableViewDidFinishTriggerWithReload:YES];
                                    }
                                }];
                    }
                }
            }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  [self cellHeightForIndexPath:indexPath
                        cellContentViewWidth:SCREEN_WIDTH
                                   tableView:tableView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(tableView);
    
    SHBlogDetailWebVC *detailWebVC = [[SHBlogDetailWebVC alloc] initWithTitle:@"微博正文" url:@"http:\/\/ecstore.shopex123.com\/penker\/index.php\/wap\/product-95-penker.html"];
    [self.navigationController pushViewController:detailWebVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHBlogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHBlogViewCell class])];
    SHStatusModel *model = self.dataArray[indexPath.row];
    cell.delegate = self;
    cell.model = model;
    return cell;
}

#pragma mark - SHBlogViewCellDelegate

- (void)didClickFunctionBtn:(UIButton *)functionBtn info:(SHStatusModel *)model
{
    switch (functionBtn.tag) {
        case 1:
        {
            //转发
            SHRepostWeiboVC *repostVC = [[SHRepostWeiboVC alloc] initWithWeiboModel:model];
            [repostVC setSuccessSubmit:^{
                functionBtn.selected = YES;
            }];
            [self presentViewController:repostVC animated:YES completion:nil];
        }
            break;
        case 2:
        {
            //评论
            SHCommentVC *commentVC = [[SHCommentVC alloc] initWithWeiboModel:model];
            [commentVC setSuccessSubmit:^{
                functionBtn.selected = YES;
            }];
            [self presentViewController:commentVC animated:YES completion:nil];
        }
            break;
        case 3:
        {
            //点赞
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - SHHomePopViewDelegate

- (void)didSelectGroup:(NSString *)group
{
    SHTitleButton *titleBtn = (SHTitleButton *)self.navigationItem.titleView;
    [titleBtn setTitle:group forState:UIControlStateNormal];
    
    [self.dataArray removeAllObjects];
//    [self fetchFriendsTimelineData];
    [self fetchUserTimelineData];
}

#pragma mark - SHTableViewRefreshDelegate

- (void)tableViewDidTriggerHeaderRefresh
{
    [self.dataArray removeAllObjects];
    [self fetchPublicWeiboData];
}
- (void)tableViewDidTriggerFooterRefresh
{
    [self fetchPublicWeiboData];
}

#pragma mark - 监听导航栏点击
//导航条中间视图被点击
- (void)titleViewDidClick
{
    //弹出菜单视图
    CGFloat popX = (self.view.width - SCREEN_WIDTH * 0.5) * 0.5;
    CGFloat popY = 64 - 9;
    CGFloat popW = SCREEN_WIDTH * 0.5;
    CGFloat popH = SCREEN_HEIGHT * 0.5;
    
    SHPopMenuView *popMenuView = [SHPopMenuView popMenuViewWithContentView:self.popVC.tableView];
    self.popVC.type = PopViewTypeGroup;
    [popMenuView showInRect:CGRectMake(popX, popY, popW, popH)];
    [popMenuView setArrowPosition:SHPopMenuArrowPositionCenter];
    
}
//导航条左边item被点击
- (void)leftItemDidClick
{
    NSLog(@"%s", __func__);
    SHLeftItemVC *leftVC = [[SHLeftItemVC alloc] init];
    [self.navigationController pushViewController:leftVC animated:YES];
}
//导航条右边item被点击
- (void)rightItemDidClick
{
    NSLog(@"%s", __func__);
    
    //弹出菜单视图
    CGFloat popX = self.view.bounds.size.width * 0.7;
    CGFloat popY = 64 - 9;
    CGFloat popW = SCREEN_WIDTH * 0.25;
    CGFloat popH = SCREEN_HEIGHT * 0.17;
    
    SHPopMenuView *popMenuView = [SHPopMenuView popMenuViewWithContentView:self.popVC.tableView];
    self.popVC.type = PopViewTypeRadar;
    [popMenuView showInRect:CGRectMake(popX, popY, popW, popH)];
    [popMenuView setArrowPosition:SHPopMenuArrowPositionRight];
}


#pragma mark - lazy load

- (SHHomePopVC *)popVC
{
    if (!_popVC)
    {
        _popVC = [[SHHomePopVC alloc] init];
        _popVC.delegate = self;
    }
    return _popVC;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
//        _dataArray = [NSMutableArray arrayWithObjects:
//                      @{@"avatar":@"0.jpg", @"name":@"老王", @"vip":@"1", @"time":@"2分钟前", @"source":@"iPhone 50s", @"text":@"发放的舒服撒拉夫斯基的福建师大附近大房间的书法家阿斯顿飞拉萨的房间安静是福建啊谁家", @"pictureArray":@[@"0.jpg"],  @"commentCount":@"43", @"praiseCount":@"96"},
//                      @{@"avatar":@"0.jpg", @"name":@"王大妈", @"time":@"3分钟前", @"source":@"iPhone 100s", @"text":@"和动手术是飞洒发发动机及垃圾垃圾及科技局级法师打发电视剧啊发就发回家是打发发生的房间按时发放啦经济法加拉斯加罚加咖啡及第三方健康感觉舒服撒即可分解就发生就考虑对方即可垃圾发神经房间萨芬几哈圣诞节会封号的建设大街回复函数返回家师大环境法撒旦很快就回家很快就恢复萨多好看", @"pictureArray":@[@"0.jpg"], @"relayCount":@"10", @"praiseCount":@"96"},
//                      @{@"avatar":@"0.jpg", @"name":@"王小明", @"vip":@"2", @"time":@"10分钟前", @"source":@"iPhone 99s", @"pictureArray":@[@"1.jpg"], @"relayCount":@"10", @"commentCount":@"43", @"praiseCount":@"96"},
//                      @{@"avatar":@"0.jpg", @"name":@"张小红有一张图", @"vip":@"3", @"time":@"19分钟前", @"source":@"iPhone 78s", @"pictureArray":@[@"0.jpg"], @"relayCount":@"10", @"commentCount":@"43"},
//                      @{@"avatar":@"0.jpg", @"name":@"张小红有两张图",@"vip":@"4", @"time":@"19分钟前", @"source":@"iPhone 78s", @"pictureArray":@[@"1.jpg", @"2.jpg"], @"relayCount":@"10", @"commentCount":@"43", @"praiseCount":@"96"},
//                      @{@"avatar":@"0.jpg", @"name":@"张小红有三张图", @"time":@"19分钟前", @"source":@"iPhone 78s", @"pictureArray":@[@"1.jpg", @"2.jpg", @"3.jpg"], @"relayCount":@"10", @"commentCount":@"43", @"praiseCount":@"96"},
//                      @{@"avatar":@"0.jpg", @"name":@"张小红有四张图", @"time":@"19分钟前", @"source":@"iPhone 78s", @"pictureArray":@[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"], @"relayCount":@"10", @"commentCount":@"43", @"praiseCount":@"96"},
//                      @{@"avatar":@"0.jpg", @"name":@"张小红有九张图", @"time":@"19分钟前", @"source":@"iPhone 78s", @"text":@"法萨芬的身份就很舒服的环境恢复啥地方还是开了房后发生地方好好的是否回家啊收到回复回复哈咖啡的还是十几块放极爱是范德萨发生的解放军的萨芬就撒旦了发的说法是范德萨房顶上放极爱是家乐福的身份来房间啊是发生大法师就分解落实到分类发顺丰就看电视来缴费记录的萨菲隆",@"pictureArray":@[@"1.jpg", @"2.jpg", @"3.jpg", @"1.jpg", @"2.jpg", @"3.jpg", @"1.jpg", @"2.jpg", @"3.jpg"], @"relayCount":@"10", @"commentCount":@"43", @"praiseCount":@"96"},
//                      nil];
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - 通知相关

- (void)addNotificationObservers
{
    [super addNotificationObservers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationLogin:) name:kNotificationDidLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReciveNotificationNeedLogin:) name:kNotificationNeedLogin object:nil];
}
- (void)removeNotificationObservers
{
    [super removeNotificationObservers];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveNotificationLogin:(NSNotification *)notification
{
    [self fetchPublicWeiboData];
}
- (void)didReciveNotificationNeedLogin:(NSNotification *)notification
{
    [[UserManager shareInstance] requestSSOLogin];
}


@end
