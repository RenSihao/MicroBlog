//
//  SHDiscoverHeaderView.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHDiscoverHeaderView;
@class SHDiscoverHeaderModel;

@protocol SHDiscoverHeaderViewDelegate <NSObject>

- (void)discoverHeaderView:(SHDiscoverHeaderView *)discoverHeaderView didClickItemAtIndex:(NSInteger)index;

@end



@interface SHDiscoverHeaderView : UITableViewCell

@property (nonatomic, weak) id<SHDiscoverHeaderViewDelegate> delegate;

- (void)updateWithDiscoverHeaderModel:(SHDiscoverHeaderModel *)model;
@end
