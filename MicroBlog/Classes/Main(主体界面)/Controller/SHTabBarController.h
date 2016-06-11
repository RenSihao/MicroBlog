//
//  SHTabBarController.h
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  TabBar
 */
typedef NS_OPTIONS(NSUInteger, SHTabTag) {
    /**
     *  首页
     */
    SHTabTagHome = 0,
    /**
     *  消息
     */
    SHTabTagMessage = 1,
    /**
     *  特殊的 +
     */
    SHTabTagAdd = 2,
    /**
     *  发现
     */
    SHTabTagDiscover = 3,
    /**
     *  我
     */
    SHTabTagProfile = 4,
};

@interface SHTabBarController : UITabBarController

@end
