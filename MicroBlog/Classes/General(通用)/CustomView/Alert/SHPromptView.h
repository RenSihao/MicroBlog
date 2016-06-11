//
//  SHPromtView.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

//提示框默认高度和宽度
#define SHPromptViewWidth 160.0
#define SHPromptViewHeight 80.0

#import <UIKit/UIKit.h>

/**
 *  自定义提示框
 */
@interface SHPromptView : UIView

/**信息内容
 */
@property(nonatomic,readonly) UILabel *messageLabel;

/**是否正在动画中
 */
@property(nonatomic,readonly) BOOL isAnimating;

/**是否要移除当提示框隐藏时，default is 'YES'
 */
@property(nonatomic,assign) BOOL removeFromSuperViewAfterHidden;

/**
 *  init方法
 *
 *  @param frame    提示框大小位置
 *  @param message  显示的信息
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame message:(NSString*)message;

/**
 *  显示提示框并设置多少秒后消失
 *
 *  @param delay 消失延时时间
 */
- (void)showAndHideDelay:(NSTimeInterval)delay;

@end
