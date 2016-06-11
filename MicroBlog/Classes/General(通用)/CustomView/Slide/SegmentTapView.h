//
//  SegmentTapView.h
//  iOS_Control
//
//  Created by RenSihao on 16/3/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentTapView;

@protocol SegmentTapViewDelegate <NSObject>

@required

/**
 *  回调选中tag
 *
 *  @param index 默认从0开始
 */
- (void)segmentTapViewDidSelectedIndex:(NSInteger)index;
@end

/***********************  可定制 SegmentView ***********************/
@interface SegmentTapView : UIView


@property (nonatomic, weak) id<SegmentTapViewDelegate> delegate;

/**
 *  标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  正常标题颜色
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 *  选中标题颜色
 */
@property (nonatomic, strong) UIColor *titleSelectColor;

/**
 *  init方法
 *
 *  @param frame      frame
 *  @param titleArray 标题数组
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

/**
 *  外界调用接口 该控件正确显示UI
 *
 *  @param index 选中按钮下标
 */
- (void)selectIndex:(NSInteger)index;

@end
