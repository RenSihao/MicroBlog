//
//  UserManager.h
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kUserModelFromLogin  = @"kUserModelFromLogin";
static NSString * const kUserSecurityUserID = @"kUserSecurityUserID";
static NSString * const kUserSecurityAccessToken = @"kUserSecurityAccessToken";
static NSString * const kUserSecurityRefreshToken = @"kUserSecurityRefreshToken";
static NSString * const kUserSecurityExpirationDate = @"kUserSecurityExpirationDate";

@class UserSecurity;

typedef void WBHttpRequestCompleteBlock (WBHttpRequest *httpRequest, id result, NSError *error);
#pragma mark - UserManager

@interface UserManager : NSObject
<
WBHttpRequestDelegate,
WeiboSDKDelegate
>

/**
 *  用户模型
 */
@property (nonatomic, strong) SHUserModel *userModel;
/**
 *  用户登录信息
 */
@property (nonatomic, strong) UserSecurity *userSecurity;
/**
 *  是否自动登录
 */
@property (nonatomic, assign, getter=isAutoLogin) BOOL autoLogin;

/**
 *  本地存储的token是否过期
 */
@property (nonatomic, assign, getter=isTokenExpired) BOOL tokenExpired;

/**
 *  全局用户单例
 *
 */
+ (instancetype)shareInstance;

/**
 *  更新过期的token
 */
- (void)updateAccessToken;

/**
 *  请求SSO方式授权登录
 */
- (void)requestSSOLogin;

/**
 *  请求SSO方式退出登录
 */
- (void)requestSSOLogout;

/**
 *  获取微博用户最新个人信息
 */
- (void)requestUserInfo;
@end


#pragma mark - UserSecurity

/**
 *  微博SSO登录返回授权信息
 */
@interface UserSecurity : SHModel

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, strong) NSDate *expirationDate;
@end

