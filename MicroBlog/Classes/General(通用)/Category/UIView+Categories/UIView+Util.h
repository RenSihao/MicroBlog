//
//  UIView+Util.h
//  AdressBook
//
//  Created by XuJiajia on 16/3/26.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)
/**
 *  中cell卡片view添加
 *
 *  @return 添加的卡片view,默认间距为10
 */
- (UIView *)addShadowTanView;

/**
 *  中cell卡片view添加
 *
 *  @param insets edgeInsets
 *
 *  @return 添加的卡片view
 */
- (UIView *)addShadowTanViewWithInsets:(UIEdgeInsets)insets;

/**
 *  为头像添加阴影view
 *
 *  @param conV conV
 *
 *  @return 阴影view
 */
- (UIView *)addAvatorShadowV;

/**
 *  为view添加阴影(实际上是添加了一个相同位置的阴影view)
 *
 *  @param conV 容器view
 *  @param offset 阴影偏移
 *
 *  @return 添加的阴影view
 */
- (UIView*)addShadowvWithOffset:(CGFloat)offset;



@end
