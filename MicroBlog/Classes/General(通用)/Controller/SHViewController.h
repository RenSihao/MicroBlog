//
//  SHViewController.h
//  MicroBlog
//
//  Created by RenSihao on 15/12/24.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHViewController : UIViewController


#pragma mark - Request


#pragma mark - 导航

/**
 *  设置导航栏
 */
-(void) setupNaviBarItems;

#pragma mark - Notifications

/**
 *  添加通知
 */
-(void) addNotificationObservers;

/**
 *  移除通知
 */
-(void) removeNotificationObservers;

#pragma mark - Click

/**
 *  点击返回
 *
 *  @param sender
 */
-(void) didClickBack:(id) sender;



@end
