//
//  SHMessageDetailVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHMessageDetailVC.h"
#import "SHStatusModel.h"
#import "SHBlogViewCell.h"

@interface SHMessageDetailVC ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger type;
@end

@implementation SHMessageDetailVC

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewStyle)style type:(NSInteger)type
{
    if (self = [super initWithStyle:style])
    {
        _type = type;
        switch (_type) {
            case 0:
                self.title = @"@我的";
                break;
            case 1:
                self.title = @"评论";
                break;
            case 2:
                self.title = @"赞";
                break;
            case 3:
                self.title = @"订阅消息";
                break;
            case 4:
                self.title = @"未关注人消息";
                break;
            default:
                break;
        }
    }
    return self;
}


#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[SHBlogViewCell class] forCellReuseIdentifier:NSStringFromClass([SHBlogViewCell class])];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self fetchData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - public method

#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(didClickSetting)];
}
- (void)fetchData
{
    switch (_type) {
        case 0:
        {
            [WBHttpRequest requestWithURL:Weibo_Mentions_URL
                               httpMethod:Weibo_HttpMethod_GET
                                   params:@{@"access_token":[UserManager shareInstance].userSecurity.accessToken}
                                    queue:[NSOperationQueue mainQueue]
                    withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                        if (error)
                        {
                            
                        }
                        else
                        {
                            for (NSDictionary *dic in result[@"statuses"])
                            {
                                SHStatusModel *statusModel = [SHStatusModel mj_objectWithKeyValues:dic[@"retweeted_status"]];
                                [self.dataArray addObject:statusModel];
                                SHStatusModel *statusModel1 = statusModel.retweeted_status;
                            }
                            [self.tableView reloadData];
                        }
                    }];
        }
            break;
            
        default:
            break;
    }
}

- (void)didClickSetting
{
    
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath
                   cellContentViewWidth:SCREEN_WIDTH
                              tableView:tableView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHBlogViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SHBlogViewCell class])];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


#pragma mark - lazy load

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
