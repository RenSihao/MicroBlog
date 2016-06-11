//
//  SHTabBar.h
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHTabBar;

@protocol SHTabBarDelegate <NSObject>

- (void)tabBar:(SHTabBar *)tabBar didClickItem:(NSInteger)index;
- (void)tabBarDidClickAddButton:(SHTabBar *)tabBar;

@end

@interface SHTabBar : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<SHTabBarDelegate> delegate;

@end
