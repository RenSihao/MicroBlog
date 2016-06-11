//
//  UIViewController+showHUD.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHAlertView.h"

@interface UIViewController (showHUD)

- (void)showTextHud:(NSString*)message;
- (void)showTextHudNoTab:(NSString*)message;
- (void)showTextHud:(NSString*)message delay:(int)delay;
- (void)showIndeterminateHud:(NSString *)text delay:(int)delay;
- (void)hideHud;
- (void)showAlertViewWith:(SEL)selector andMessgae:(NSString *)str;

/**
 *  Delegate方式 - 展示警示框
 *
 *  @param delegate     delegate
 *  @param str          title
 *  @param isWithCancel 是否有cancel
 */

- (void)showSHAlertViewWithDelegate:(id)delegate
                         andMessage:(NSString *)str
                 isWithCancelButton:(BOOL)isWithCancel;
/**
 *  Block异步回调方式 - 展示警示框
 *
 *  @param messageStr      title
 *  @param isWithCancel    是否有cancel
 *  @param didClickOKBlock 点击确定或者取消block
 */
- (void)showSHAlertViewWithMessage:(NSString *)messageStr
                isWithCancelButton:(BOOL)isWithCancel
                   didClickOKBlock:(DidClickOKBlock)didClickOKBlock;

/**
 *  移除警示框
 */
- (void)disMissAlertView;

@end


