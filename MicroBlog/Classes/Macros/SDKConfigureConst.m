//
//  SDKConfigureConst.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/7.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SDKConfigureConst.h"

NSString * const Weibo_App_Key = @"2818069337";
NSString * const Weibo_App_Secret = @"9a147ef1f5aab58ecb648eac4f60d0c5";
NSString * const Weibo_Redirect_Url = @"https://api.weibo.com/oauth2/default.html";

NSString * const Weibo_HttpMethod_GET = @"GET";
NSString * const Weibo_HttpMethod_POST = @"POST";

NSString * const Weibo_RefreshToken_URL = @"https://api.weibo.com/oauth2/access_token?";
NSString * const Weibo_Public_URL = @"https://api.weibo.com/2/statuses/public_timeline.json";
NSString * const Weibo_Profile_URL = @"https://api.weibo.com/2/users/show.json";
//NSString * const Weibo_Domain_URL = @"extern NSString * const Weibo_Domain_URL;";
NSString * const Weibo_Mentions_URL = @"https://api.weibo.com/2/statuses/mentions.json";
NSString * const Weibo_Friends_Timeline_URL = @"https://api.weibo.com/2/statuses/friends_timeline/ids.json";
NSString * const Weibo_Statuses_Show_URL = @"https://api.weibo.com/2/statuses/show.json";
NSString * const Weibo_User_Timeline_URL = @"https://api.weibo.com/2/statuses/user_timeline/ids.json";
NSString * const Weibo_Post_URL = @"https://api.weibo.com/2/statuses/update.json";
NSString * const Weibo_Repost_URL = @"https://api.weibo.com/2/statuses/repost.json";
NSString * const Weibo_Comment_URL = @"https://api.weibo.com/2/comments/create.json";