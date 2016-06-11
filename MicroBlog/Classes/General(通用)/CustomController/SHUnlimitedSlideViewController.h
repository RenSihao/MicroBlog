//
//  SHUnlimitedSlideViewController.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/16.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHViewController.h"

@class SHUnlimitedSlideViewController;

@protocol SHUnlimitedSlideViewControllerDelegate <NSObject>

/**
 *  必须实现的代理方法，返回一组需要轮播的图片的名字
 */
@required
- (NSMutableArray *)backDataSourceArray;

/**
 *  选择实现的代理方法，返回自定义滚动视图的尺寸
 */
@optional
- (CGSize)backScrollerViewOfSize;

@end

@interface SHUnlimitedSlideViewController : SHViewController

@property (nonatomic, weak) id<SHUnlimitedSlideViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL hasPageControl; //是否有滚动下标指示器
@property (nonatomic, assign) BOOL isAutoRoll; //是否自动滚动

/**
 *  告诉外界当前点击的图片下标数字
 *
 *  @return
 */
- (NSInteger)didClickCurrentImageIndex;

@end
