//
//  FlipTableView.m
//  iOS_Control
//
//  Created by RenSihao on 16/3/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "FlipTableView.h"

@interface FlipTableView ()
<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate
>

/**
 *  容器
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  tableView数组
 */
@property (nonatomic, strong) NSArray *tableViewArray;

@end

@implementation FlipTableView

- (instancetype)initWithFrame:(CGRect)frame tableViewArray:(NSArray *)tableViewArray
{
    if (self = [super initWithFrame:frame])
    {
        _tableViewArray = tableViewArray;
        
        //添加容器视图
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UIViewController *vc = [_tableViewArray objectAtIndex:indexPath.row];
    
    //此处需要设置你的第一个tableview所属的controller 才能正常点击cell跳转
//    ContactVC* parentVC = (ContactVC*)self.delegate;
//    [parentVC addChildViewController:vc];
    
    vc.view.frame = cell.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

//但凡滑动 立即调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


#pragma mark - setter / getter

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.pagingEnabled = YES;
    }
    return _tableView;
}

@end
