//
//  SHProfilePageHeadSectionView.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/13.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHProfilePageHeadSectionView.h"
#import "SegmentTapView.h"

@interface SHProfilePageHeadSectionView () <SegmentTapViewDelegate>

@property (nonatomic, strong) SegmentTapView *segmentTapView;
@end

@implementation SHProfilePageHeadSectionView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.segmentTapView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
}
- (void)addAllSubViews
{
    [super addAllSubViews];
    
    [self.contentView addSubview:self.segmentTapView];
}
- (void)segmentTapViewDidSelectedIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(profileHeadSectionView:didClickIndex:)])
    {
        [self.delegate profileHeadSectionView:self didClickIndex:index];
    }
}
- (SegmentTapView *)segmentTapView
{
    if (!_segmentTapView)
    {
        _segmentTapView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) titleArray:@[@"主页", @"微博", @"相册"]];
        _segmentTapView.delegate = self;
        _segmentTapView.titleNormalColor = [UIColor grayColor];
        _segmentTapView.titleSelectColor = [UIColor blackColor];
    }
    return _segmentTapView;
}



@end


