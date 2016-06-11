//
//  WeiboManager.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/7.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "WeiboManager.h"

@implementation WeiboManager 

+ (instancetype)shareInstance
{
    static WeiboManager *weiboManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weiboManager = [[WeiboManager alloc] init];
    });
    return weiboManager;
}
- (void)requestPublicTimeLine
{
    WBHttpRequest *request = [WBHttpRequest requestWithAccessToken:[UserManager shareInstance].userSecurity.accessToken url:Weibo_Public_URL httpMethod:Weibo_HttpMethod_GET params:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
    }];
}
/**
 收到一个来自微博Http请求的响应
 
 @param response 具体的响应对象
 */

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

/**
 收到一个来自微博Http请求失败的响应
 
 @param error 错误信息
 */
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    
}

/**
 收到一个来自微博Http请求的网络返回
 
 @param result 请求返回结果
 */
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    
}

/**
 收到一个来自微博Http请求的网络返回
 
 @param data 请求返回结果
 */
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    
}

/**
 收到快速SSO授权的重定向
 
 @param URI
 */
- (void)request:(WBHttpRequest *)request didReciveRedirectResponseWithURI:(NSURL *)redirectUrl
{
    
}

@end
