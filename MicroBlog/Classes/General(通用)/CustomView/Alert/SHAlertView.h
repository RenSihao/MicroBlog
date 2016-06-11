//
//  SHAlertView.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHAlertView;

/**
 *  delegate方式回调
 */
@protocol SHAlertViewDelegate <NSObject>

@optional

- (void)alertView:(SHAlertView*)alertView didClickAtIndex:(NSInteger)buttonIndex;
@end

/**
 *  block方式回调
 *
 *  @param isClickOk
 */
typedef void(^DidClickOKBlock)(BOOL isClickOk);


/**
 *  自定义弹出警示框
 */
@interface SHAlertView : UIView

/**
 *  delegate
 */
@property (nonatomic, weak) id<SHAlertViewDelegate> delegate;

/**
 *  点击确定按钮的block
 */
@property (nonatomic, copy) DidClickOKBlock didClickOKBlock;

/**
 *  标题颜色
 */
@property(nonatomic,strong) UIColor *titleColor;

/**
 *  红色按钮下标 default is 'NSNotFound' ，表示没有红色按钮
 */
@property(nonatomic,assign) NSInteger destructiveButtonIndex;

/**
 *  按钮个数
 */
@property (nonatomic, assign) NSInteger buttonCount;

/**
 *  设置按钮颜色
 *
 *  @param color 按钮颜色
 *  @param index 按钮下标
 */
- (void)setButtonTitleColor:(UIColor*) color forIndex:(NSInteger) index;


/**
 *  设置按钮字体
 *
 *  @param font  按钮字体
 *  @param index 按钮下标
 */
-(void)setbuttontitleFont:(UIFont*)font forIndex:(NSInteger)index;

/**
 *  init方法
 *
 *  @param title             标题
 *  @param otherButtonTitles 按钮标题 数组元素是NSString
 *
 *  @return
 */
- (id)initWithTitle:(NSString*) title otherButtonTitles:(NSArray*) otherButtonTitles;

/**
 *  显示
 */
- (void)show;

/**
 *  消失
 */
- (void)dismiss;
@end
