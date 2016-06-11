//
//  SHSearchView.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHSearchView.h"

@interface SHSearchView ()
<
UISearchBarDelegate
>

@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation SHSearchView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.searchBar];
        
        //自身添加单击手势
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tapGest.numberOfTapsRequired = 1;
        tapGest.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapGest];
    }
    return self;
}

#pragma mark - lazy load

- (UISearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] initWithFrame:self.frame];
//        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索联系人和群";
        _searchBar.userInteractionEnabled = NO;
    }
    return _searchBar;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return NO;
}

#pragma mark - private method

- (void)tapAction:(UITapGestureRecognizer *)tapGest
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickSearchView:)])
    {
        [self.delegate didClickSearchView:self];
    }
}

@end
