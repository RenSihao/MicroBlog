//
//  SHHomePopViewController.m
//  MicroBlog
//
//  Created by RenSihao on 16/1/4.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHHomePopVC.h"

@interface SHHomePopVC ()

@property (nonatomic, strong) NSDictionary *groupInfoDict;
@property (nonatomic, strong) NSDictionary *radarInfoDict;

@property (nonatomic, strong) NSArray *groupInfoArray;
@property (nonatomic, strong) NSArray *radarInfoArray;
@end

@implementation SHHomePopVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseID"];
    
    //数据
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - public method

- (instancetype)initWithPopViewType:(PopViewType)type
{
    if (self = [super init])
    {
        _type = type;
        switch (_type) {
            case PopViewTypeGroup:
            {
                [self groupInfoArray];
                [self.tableView reloadData];
            }
                break;
            case PopViewTypeRadar:
            {
                [self radarInfoDict];
                [self.tableView reloadData];
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

- (void)setType:(PopViewType)type
{
    _type = type;
    switch (_type) {
        case PopViewTypeGroup:
        {
            [self groupInfoDict];
            [self.tableView reloadData];
        }
            break;
        case PopViewTypeRadar:
        {
            [self radarInfoDict];
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _type == PopViewTypeGroup ? self.groupInfoArray.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _type == PopViewTypeGroup ? [self.groupInfoArray[section] count] : self.radarInfoArray.count;
    }
    else if (section == 1)
    {
        return [self.groupInfoArray[section] count];
    }
    else if (section == 2)
    {
        return [self.groupInfoArray[section] count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseID"];
    }
    cell.textLabel.font = [UIFont fontWithName:kDefaultBoldFontFamilyName size:17.f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = (_type == PopViewTypeGroup ? self.groupInfoArray[indexPath.section][indexPath.row] : self.radarInfoArray[indexPath.row]);
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(tableView);
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectGroup:)])
    {
        [self.delegate didSelectGroup: _type == PopViewTypeGroup ? self.groupInfoArray[indexPath.section][indexPath.row] : self.radarInfoArray[indexPath.row]];
    }
}

#pragma mark - lazy load

- (NSArray *)groupInfoArray
{
    if (!_groupInfoArray)
    {
        _groupInfoArray = @[@[@"首页", @"好友圈", @"群微博"],
                            @[@"同学", @"老师", @"家人", @"明星"],
                            @[@"周围微博"]];
    }
    return _groupInfoArray;
}
- (NSDictionary *)groupInfoDict
{
    if (!_groupInfoDict)
    {
        _groupInfoDict = @{@"SystemGroup":@[@"首页", @"好友圈", @"群微博"],
                           @"PersonalGroup":@[@"同学", @"老师", @"家人", @"明星"],
                           @"OtherGroup":@[@"周围微博"]};
    }
    return _groupInfoDict;
}
- (NSDictionary *)radarInfoDict
{
    if (!_radarInfoDict)
    {
        _radarInfoDict = @{@"radar":@"雷达",
                           @"sweep":@"扫一扫"};
    }
    return _radarInfoDict;
}
- (NSArray *)radarInfoArray
{
    if (!_radarInfoArray)
    {
        _radarInfoArray = @[@"雷达", @"扫一扫", ];
    }
    return _radarInfoArray;
}


@end
