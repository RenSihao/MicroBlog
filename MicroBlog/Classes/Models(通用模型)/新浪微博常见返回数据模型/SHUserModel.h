//
//  SHUserModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 微博个人信息接口返回result
 {
 WeiboUser:
 userID=3203191611,
 userClass=1,
 screenName=10CreateChangeDestory,
 name=10CreateChangeDestory,
 province=14,
 city=8,
 location=山西 运城,
 userDescription=有梦想的人不睡觉。,
 url=,
 profileImageUrl=http://tp4.sinaimg.cn/3203191611/50/5741599763/1,
 coverImageUrl=(null) ,coverImageForPhoneUrl=http://ww4.sinaimg.cn/crop.0.0.640.640.640/6ce2240djw1e8iktk4ohij20hs0hsmz6.jpg,
 profileUrl=u/3203191611,
 userDomain=,
 weihao=,
 gender=m,
 followersCount=61,
 friendsCount=128,
 pageFriendsCount=1,
 statusesCount=92,
 favouritesCount=10,
 createdTime=Wed Dec 12 07:52:00 +0800 2012,
 verifiedType=-1,
 remark=,
 statusID=(null),
 ptype=0,
 avatarLargeUrl=http://tp4.sinaimg.cn/3203191611/180/5741599763/1,
 avatarHDUrl=http://tva3.sinaimg.cn/crop.0.0.640.640.1024/beecd33bjw8exp447jv3bj20hs0hst9s.jpg,
 verifiedReason=,
 verifiedTrade=,
 verifiedReasonUrl=,
 verifiedSource=,
 verifiedSourceUrl=,
 verifiedState=(null),
 verifiedLevel=(null),
 onlineStatus=0,
 biFollowersCount=33,
 language=zh-cn,
 mbtype=0,
 mbrank=0,
 block[_word=0,
 block_app=0,
 credit_score=80,
 isFollowingMe=0,
 isFollowingByMe=0,
 isAllowAllActMsg=0,
 isAllowAllComment=1,
 isGeoEnabled=1,
 isVerified=0
 */

/* 获取公共微博列表内容 里边返回的user
 user =     {
 "allow_all_act_msg" = 0;
 "allow_all_comment" = 1;
 "avatar_hd" = "http://tva2.sinaimg.cn/crop.0.0.750.750.1024/9cf7abc5jw8f1tz366djoj20ku0kuwff.jpg";
 "avatar_large" = "http://tp2.sinaimg.cn/2633477061/180/5752724673/0";
 "bi_followers_count" = 1;
 "block_app" = 0;
 "block_word" = 0;
 city = 43;
 class = 1;
 "cover_image_phone" = "http://ww2.sinaimg.cn/crop.0.0.640.640.640/a1d3feabjw1ecassls6b2j20hs0hsq50.jpg";
 "created_at" = "Mon Feb 27 07:33:52 +0800 2012";
 "credit_score" = 80;
 description = "";
 domain = "";
 "favourites_count" = 19;
 "follow_me" = 0;
 "followers_count" = 43;
 following = 0;
 "friends_count" = 59;
 gender = f;
 "geo_enabled" = 1;
 id = 2633477061;
 idstr = 2633477061;
 lang = "zh-cn";
 location = "\U6d77\U5916 \U58a8\U897f\U54e5";
 mbrank = 0;
 mbtype = 0;
 name = "Dannie\U4e3f";
 "online_status" = 0;
 "pagefriends_count" = 0;
 "profile_image_url" = "http://tp2.sinaimg.cn/2633477061/50/5752724673/0";
 "profile_url" = "u/2633477061";
 province = 400;
 ptype = 0;
 remark = "";
 "screen_name" = "Dannie\U4e3f";
 star = 0;
 "statuses_count" = 128;
 urank = 14;
 url = "";
 "user_ability" = 0;
 verified = 0;
 "verified_reason" = "";
 "verified_reason_url" = "";
 "verified_source" = "";
 "verified_source_url" = "";
 "verified_trade" = "";
 "verified_type" = "-1";
 weihao = "";
 };
 */


/*
 用户（user）
 返回值字段          	 字段类型 	字段说明
 id 	             int64 	    用户UID
 idstr 	             string 	字符串型的用户UID
 screen_name 	     string 	用户昵称
 name 	             string 	友好显示名称
 province 	         int     	用户所在省级ID
 city 	             int 	    用户所在城市ID
 location 	         string 	用户所在地
 description 	     string 	用户个人描述
 url 	             string 	用户博客地址
 profile_image_url 	 string 	用户头像地址（中图），50×50像素
 profile_url 	     string 	用户的微博统一URL地址
 domain 	         string 	用户的个性化域名
 weihao 	         string 	用户的微号
 gender 	         string 	性别，m：男、f：女、n：未知
 followers_count 	 int 	    粉丝数
 friends_count 	     int    	关注数
 statuses_count      int 	    微博数
 favourites_count 	 int 	    收藏数
 created_at          string 	用户创建（注册）时间
 following 	         boolean 	暂未支持
 allow_all_act_msg 	 boolean 	是否允许所有人给我发私信，true：是，false：否
 geo_enabled 	     boolean 	是否允许标识用户的地理位置，true：是，false：否
 verified 	         boolean 	是否是微博认证用户，即加V用户，true：是，false：否
 verified_type 	     int 	    暂未支持
 remark 	         string 	用户备注信息，只有在查询用户关系时才返回此字段
 status 	         object 	用户的最近一条微博信息字段 详细
 allow_all_comment 	 boolean 	是否允许所有人对我的微博进行评论，true：是，false：否
 avatar_large 	     string 	用户头像地址（大图），180×180像素
 avatar_hd 	         string 	用户头像地址（高清），高清头像原图
 verified_reason 	 string 	认证原因
 follow_me 	         boolean 	该用户是否关注当前登录用户，true：是，false：否
 online_status 	     int 	    用户的在线状态，0：不在线、1：在线
 bi_followers_count  int 	    用户的互粉数
 lang 	             string 	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */

@interface SHUserModel : SHModel

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *screenName; //
@property (nonatomic, assign) NSInteger credit_score;
@property (nonatomic, copy) NSString *userDescription;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_hd;
@property (nonatomic, copy) NSString *avatarLargeUrl;
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *avatarHDUrl;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *coverImageUrl;
@property (nonatomic, copy) NSString *coverImageForPhoneUrl;
@property (nonatomic, copy) NSString *weihao;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger followers_count;
@property (nonatomic, assign) NSInteger followersCount;
@property (nonatomic, assign) NSInteger statuses_count;
@property (nonatomic, assign) NSInteger statusesCount;
@property (nonatomic, assign) NSInteger friends_count;
@property (nonatomic, assign) NSInteger friendsCount;
@property (nonatomic, assign) NSInteger favourites_count;
@property (nonatomic, copy) NSString *createdTime;
@property (nonatomic, assign, getter=isGeo_enabled) BOOL geo_enabled;
@property (nonatomic, assign, getter=isFollowing) BOOL following;
@property (nonatomic, assign, getter=isAllow_all_act_msg) BOOL allow_all_act_msg;
@property (nonatomic, assign, getter=isGeo_enabled) BOOL isGeoEnabled;
@property (nonatomic, assign, getter=isVerified) BOOL isVerified;

@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) id statues;
@property (nonatomic, assign, getter=isAllow_all_comment) BOOL allow_all_comment;
@property (nonatomic, copy) NSString *verifiedReason;
@property (nonatomic, assign, getter=isFollow_me) BOOL follow_me;
//@property (nonatomic, assign, getter=<#method#>) BOOL isFollowingMe;
//@property (nonatomic, assign, getter=<#method#>) BOOL isFollowingByMe;
//@property (nonatomic, assign, getter=<#method#>) BOOL isAllowAllActMsg;
//@property (nonatomic, assign, getter=<#method#>) BOOL isAllowAllComment;
//@property (nonatomic, assign, getter=<#method#>) BOOL isGeoEnabled;
//@property (nonatomic, assign, getter=<#method#>) BOOL isVerified;
@property (nonatomic, assign, getter=isOnline_status) BOOL online_status;
@property (nonatomic, assign, getter=isVerified) BOOL verified;
@property (nonatomic, assign) NSInteger pagefriends_count;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *profileurl;
@property (nonatomic, copy) NSString *profileUrl;
@property (nonatomic, assign) NSInteger onlineStatus;
@property (nonatomic, assign) NSInteger bi_followers_count;
@property (nonatomic, assign) NSInteger biFollowersCount;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *language;


//以下属性尚未明确含义
@property (nonatomic, copy) NSString *cover_image_phone;



@end
