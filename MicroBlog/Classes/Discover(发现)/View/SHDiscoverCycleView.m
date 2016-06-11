//
//  SHDiscoverCycleView.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/15.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHDiscoverCycleView.h"

@interface SHDiscoverCycleView ()
<
SDCycleScrollViewDelegate
>

@property (nonatomic, strong) SDCycleScrollView *cycelScrollView;
@end

@implementation SHDiscoverCycleView

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.cycelScrollView];
    }
    return self;
}

#pragma mark - private method

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.cycelScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(discoverCycleView:didSelectItemAtIndex:)])
    {
        [self.delegate discoverCycleView:self didSelectItemAtIndex:index];
    }
}


#pragma mark - lazy load

- (SDCycleScrollView *)cycelScrollView
{
    if (!_cycelScrollView)
    {
        _cycelScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width  , self.height) imageNamesGroup:@[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"]];
        _cycelScrollView.delegate = self;
        _cycelScrollView.currentPageDotColor = [UIColor orangeColor];
        _cycelScrollView.pageDotColor = [UIColor whiteColor];
    }
    return _cycelScrollView;
}

@end
