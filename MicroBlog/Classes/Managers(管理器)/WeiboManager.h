//
//  WeiboManager.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/7.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboManager : NSObject <WBHttpRequestDelegate>

+ (instancetype)shareInstance;

/**
 *  请求最新公共微博
 */
- (void)requestPublicTimeLine;
@end
