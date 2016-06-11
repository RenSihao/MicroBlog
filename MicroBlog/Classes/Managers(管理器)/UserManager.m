//
//  UserManager.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "UserManager.h"

@interface UserManager ()

/**
 *  token
 */
@property (nonatomic, copy) NSString *wbtoken;

/**
 *  刷新token
 */
@property (nonatomic, copy) NSString *wbRefreshToken;

/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *wbCurrentUserID;

@end

@implementation UserManager

#pragma mark - init

+ (instancetype)shareInstance
{
    static UserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[UserManager alloc] init];
    });
    return userManager;
}
- (instancetype)init
{
    if (self = [super init])
    {
        NSDictionary *dictUser = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kUserModelFromLogin];
        if (dictUser)
        {
            self.userModel = [[SHUserModel alloc] initWithDict:dictUser];
        }
        self.userSecurity = [[UserSecurity alloc] init];
    }
    return self;
}

#pragma mark - AccessToken

- (void)updateAccessToken
{
//    [WBHttpRequest requestForRenewAccessTokenWithRefreshToken:[UserManager shareInstance].userSecurity.refreshToken
//                                                        queue:nil
//                                        withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//                                            
//                                            NSLog(@"%@", result);
//    }];
//    
    [WBHttpRequest requestWithURL:Weibo_RefreshToken_URL
                       httpMethod:Weibo_HttpMethod_POST
                           params:@{@"client_id":Weibo_App_Key, @"client_secret":Weibo_App_Secret, @"grant_type":@"refresh_token", @"redirect_url":Weibo_Redirect_Url, @"refresh_token":[UserManager shareInstance].userSecurity.refreshToken}
                            queue:[NSOperationQueue mainQueue]
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        if (error)
        {
            
        }
        else
        {
            NSString *accessToken = result[@"access_token"];
            NSString *refreshToken = result[@"refresh_token"];
            NSString *userID = result[@"uid"];
            [self userSecurityWriteToLocalWithUserID:userID accessToken:accessToken refreshToken:refreshToken];
        }
    }];
    
}

#pragma mark - setter

/**
 *  微博用户账号信息写入本地 并发布通知
 */
- (void)userSecurityWriteToLocalWithUserID:(NSString *)userID accessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken
{
    //写入NSUserDefault
    [UserManager shareInstance].userSecurity.userID = userID;
    [UserManager shareInstance].userSecurity.accessToken = accessToken;
    [UserManager shareInstance].userSecurity.refreshToken = refreshToken;
    //手动设置token过期时间为一天后
    [UserManager shareInstance].userSecurity.expirationDate = [NSDate afterDayDate];;
    //"expires_in" = 157679999 4年之久
//    [UserManager shareInstance].userSecurity.expirationDate = [(WBAuthorizeResponse *)response expirationDate];
    
    //发布通知 - 登录成功
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidLogin object:nil];
}
/**
 *  清空本地用户信息和账号信息 并发布通知
 */
- (void)clearUserSecurityAndUserInfoFromLocal
{
    //清空用户模型
    [UserManager shareInstance].userModel = nil;
    //清空账号信息
    [UserManager shareInstance].userSecurity = nil;
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserSecurityUserID];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserSecurityAccessToken];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserSecurityRefreshToken];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:kUserSecurityExpirationDate];
    
    //发布通知 - 需要登录
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
}

#pragma mark - getter

- (UserSecurity *)userSecurity
{
    if (!_userSecurity)
    {
        _userSecurity = [[UserSecurity alloc] init];
    }
    return _userSecurity;
}
- (BOOL)isAutoLogin
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityAccessToken] ? YES : NO;
}
- (BOOL)isTokenExpired
{    
    NSDate *now = [NSDate localeDate];
    NSDate *expirated = [UserManager shareInstance].userSecurity.expirationDate;
    
    if (now == [now earlierDate:expirated])
    {
        return NO;
    }
    else
    {
        return YES;
    } 
}

#pragma mark - Request

/**
 *  请求SSO方式授权登录
 */
- (void)requestSSOLogin
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = Weibo_Redirect_Url;
    request.scope = @"all";
    request.userInfo = @{@"action":@"login"};
    
    [WeiboSDK sendRequest:request];
}
/**
 *  请求SSO方式退出登录
 */
- (void)requestSSOLogout
{
    [WeiboSDK logOutWithToken:[UserManager shareInstance].userSecurity.accessToken
                     delegate:self
                      withTag:kRequestTagLogout];
}
/**
 *  请求获取微博用户个人信息
 */
- (void)requestUserInfo
{
    [WBHttpRequest requestForUserProfile:[UserManager shareInstance].userSecurity.userID
                         withAccessToken:[UserManager shareInstance].userSecurity.accessToken andOtherProperties:nil
                                   queue:nil
                   withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                       
                       if (error)
                       {
                           
                       }
                       else
                       {
                           SHUserModel *userModel = [SHUserModel mj_objectWithKeyValues:result];
                           [UserManager shareInstance].userModel = userModel;

                           //发布通知 - 已经获取到微博用户个人信息
                           [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidFetchUserInfo object:nil];
                       }
                   }];
}

#pragma mark - WBHttpRequestDelegate

/**
 收到一个来自微博Http请求的响应
 
 @param response 具体的响应对象
 */
//- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
//{
//    NSLog(@"%@", request);
//}

/**
 收到一个来自微博Http请求失败的响应
 
 @param error 错误信息
 */
//- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
//{
//    NSLog(@"%@", request);
//}

/**
 收到一个来自微博Http请求的网络返回
 
 @param result 请求返回结果
 */
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@"%@", request);
    
    if ([request.tag isEqualToString:kRequestTagLogout])
    {
        [self clearUserSecurityAndUserInfoFromLocal];
    }
    
}

/**
 收到一个来自微博Http请求的网络返回
 
 @param data 请求返回结果
 */
//- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
//{
//   NSLog(@"%@", request);
//}

/**
 收到快速SSO授权的重定向
 
 @param URI
 */
//- (void)request:(WBHttpRequest *)request didReciveRedirectResponseWithURI:(NSURL *)redirectUrl
//{
//    NSLog(@"%@", request);
//}

#pragma mark -  WeiboSDKDelegate
/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if ([(WBAuthorizeResponse *)response statusCode] == WeiboSDKResponseStatusCodeSuccess)
        {
            [self userSecurityWriteToLocalWithUserID:[(WBAuthorizeResponse *)response userID]
                                         accessToken:[(WBAuthorizeResponse *)response accessToken]
                                        refreshToken:[(WBAuthorizeResponse *)response refreshToken]];
        }  
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
    {
        NSString *title = NSLocalizedString(@"邀请结果", nil);
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if([response isKindOfClass:WBShareMessageToContactResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [shareMessageToContactResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
}



@end

#pragma mark - UserSecurity

@implementation UserSecurity

//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super initWithDict:dict])
//    {
//        _userID = [dict objectForKeyNotNull:kUserSecurityUserID];
//        _accessToken = [dict objectForKeyNotNull:kUserSecurityAccessToken];
//        _refreshToken = [dict objectForKeyNotNull:kUserSecurityRefreshToken];
//    }
//    return self;
//}

- (void)setUserID:(NSString *)userID
{
    [[NSUserDefaults standardUserDefaults] setValue:userID forKey:kUserSecurityUserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)userID
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityUserID];
}
- (void)setAccessToken:(NSString *)accessToken
{
    [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:kUserSecurityAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)accessToken
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityAccessToken];
}
- (void)setRefreshToken:(NSString *)refreshToken
{
    [[NSUserDefaults standardUserDefaults] setValue:refreshToken forKey:kUserSecurityRefreshToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)refreshToken
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityRefreshToken];
}
- (void)setExpirationDate:(NSDate *)expirationDate
{
    [[NSUserDefaults standardUserDefaults] setValue:expirationDate forKey:kUserSecurityExpirationDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSDate *)expirationDate
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kUserSecurityExpirationDate];
}

@end


