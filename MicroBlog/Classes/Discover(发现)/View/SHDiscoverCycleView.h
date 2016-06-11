//
//  SHDiscoverCycleView.h
//  MicroBlog
//
//  Created by RenSihao on 16/3/15.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHDiscoverCycleView;

@protocol SHDiscoverCycleVeiwDelegate <NSObject>

/**
 *  当前点击轮播滚动图第几张 回调index
 *
 *  @param discoverCycleView
 *  @param index
 */
- (void)discoverCycleView:(SHDiscoverCycleView *)discoverCycleView didSelectItemAtIndex:(NSInteger)index;

@end

@interface SHDiscoverCycleView : UITableViewCell

@property (nonatomic, weak) id<SHDiscoverCycleVeiwDelegate> delegate;

@end
