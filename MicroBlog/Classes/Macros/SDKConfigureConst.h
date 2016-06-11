//
//  SDKConfigureConst.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/7.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  新浪微博SDK
 */
extern NSString * const Weibo_App_Key;
extern NSString * const Weibo_App_Secret;
extern NSString * const Weibo_Redirect_Url;

extern NSString * const Weibo_HttpMethod_GET;
extern NSString * const Weibo_HttpMethod_POST;

/**
 *  接口URL
 */
/**
 *  更新token
 */
extern NSString * const Weibo_RefreshToken_URL;
/**
 *  获取最新公共微博
 */
extern NSString * const Weibo_Public_URL;
/**
 *  获取用户信息
 */
extern NSString * const Weibo_Profile_URL;
/**
 *  获取用户信息包括最新一条微博
 */
extern NSString * const Weibo_Domain_URL;
/**
 *  @我的微博
 */
extern NSString * const Weibo_Mentions_URL;

/**
 *  获取当前登录用户及其所关注用户的最新微博的ID
 */
extern NSString * const Weibo_Friends_Timeline_URL;


/**
 *  根据微博ID获取单条微博内容
 */
extern NSString * const Weibo_Statuses_Show_URL;

/**
 *  获取用户发布的微博的ID
 */
extern NSString * const Weibo_User_Timeline_URL;


/**
 *  发布新微博
 */
extern NSString * const Weibo_Post_URL;

/**
 *  转发新微博
 */
extern NSString * const Weibo_Repost_URL;


/**
 *  评论微博
 */
extern NSString * const Weibo_Comment_URL;
