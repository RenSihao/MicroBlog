//
//  AppManager.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (instancetype)sharedInstance
{
    static AppManager *appManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appManager = [[AppManager alloc] init];
    });
    return appManager;
}
@end
