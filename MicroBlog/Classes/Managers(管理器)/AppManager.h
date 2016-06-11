//
//  AppManager.h
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

/**
 *  整个APP全局管理器 单例
 *
 *  @return 
 */
+ (instancetype)sharedInstance;
@end
