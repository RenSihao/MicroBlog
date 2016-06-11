//
//  SHBlogDetailModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 返回值字段 	字段类型 	字段说明
 created_at 	string 	微博创建时间
 id 	int64 	微博ID
 mid 	int64 	微博MID
 idstr 	string 	字符串型的微博ID
 text 	string 	微博信息内容
 source 	string 	微博来源
 favorited 	boolean 	是否已收藏，true：是，false：否
 truncated 	boolean 	是否被截断，true：是，false：否
 in_reply_to_status_id 	string 	（暂未支持）回复ID
 in_reply_to_user_id 	string 	（暂未支持）回复人UID
 in_reply_to_screen_name 	string 	（暂未支持）回复人昵称
 thumbnail_pic 	string 	缩略图片地址，没有时不返回此字段
 bmiddle_pic 	string 	中等尺寸图片地址，没有时不返回此字段
 original_pic 	string 	原始图片地址，没有时不返回此字段
 geo 	object 	地理信息字段 详细
 user 	object 	微博作者的用户信息字段 详细
 retweeted_status 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count 	int 	转发数
 comments_count 	int 	评论数
 attitudes_count 	int 	表态数
 mlevel 	int 	暂未支持
 visible 	object 	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 pic_ids 	object 	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 ad 	object array 	微博流内的推广微博ID
 */

/*
 {
 annotations =     (
 {
 "client_mblogid" = "iPhone-A9FEAF61-99E0-4AC7-BB5E-C4A0D7FBF788";
 place =             {
 lat = "19.431374";
 lon = "-99.141998";
 poiid = 8005200000000000046;
 title = "\U58a8\U897f\U54e5\U57ce";
 type = checkin;
 };
 },
 {
 "mapi_request" = 1;
 }
 );
 "attitudes_count" = 0;
 "biz_feature" = 4294967300;
 "biz_ids" =     (
 100101
 );
 "bmiddle_pic" = "http://ww4.sinaimg.cn/bmiddle/9cf7abc5jw1f2skretmvdj20qo0zlthh.jpg";
 "comments_count" = 0;
 "created_at" = "Mon Apr 11 10:57:43 +0800 2016";
 "darwin_tags" =     (
 );
 favorited = 0;
 geo =     {
 coordinates =         (
 "19.431374",
 "-99.141998"
 );
 type = Point;
 };
 "hot_weibo_tags" =     (
 );
 id = 3963030083453778;
 idstr = 3963030083453778;
 "in_reply_to_screen_name" = "";
 "in_reply_to_status_id" = "";
 "in_reply_to_user_id" = "";
 isLongText = 0;
 mid = 3963030083453778;
 mlevel = 0;
 "original_pic" = "http://ww4.sinaimg.cn/large/9cf7abc5jw1f2skretmvdj20qo0zlthh.jpg";
 "pic_urls" =     (
 {
 "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/9cf7abc5jw1f2skretmvdj20qo0zlthh.jpg";
 },
 {
 "thumbnail_pic" = "http://ww1.sinaimg.cn/thumbnail/9cf7abc5jw1f2skrljzcpj20qo0zldn6.jpg";
 },
 {
 "thumbnail_pic" = "http://ww3.sinaimg.cn/thumbnail/9cf7abc5jw1f2skr18jqej20qo0zln3w.jpg";
 },
 {
 "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/9cf7abc5jw1f2skrq5i94j20qo0zlah9.jpg";
 },
 {
 "thumbnail_pic" = "http://ww2.sinaimg.cn/thumbnail/9cf7abc5jw1f2skrsvyhbj20os0t977x.jpg";
 },
 {
 "thumbnail_pic" = "http://ww1.sinaimg.cn/thumbnail/9cf7abc5jw1f2skryiqftj20qo0zl45x.jpg";
 }
 );
 "reposts_count" = 0;
 source = "<a href=\"http://app.weibo.com/t/feed/3jskmg\" rel=\"nofollow\">iPhone 6s</a>";
 "source_allowclick" = 0;
 "source_type" = 1;
 text = "\U840c\U840c\U54d2\U82b7\U598d\U598d\Uff01\Uff01\Uff01[\U601d\U8003][\U601d\U8003][\U601d\U8003] http://t.cn/RU1i6Wh";
 textLength = 56;
 "text_tag_tips" =     (
 );
 "thumbnail_pic" = "http://ww4.sinaimg.cn/thumbnail/9cf7abc5jw1f2skretmvdj20qo0zlthh.jpg";
 truncated = 0;
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
 userType = 0;
 visible =     {
 "list_id" = 0;
 type = 0;
 };
 }
 */
@class SHUserModel;
@class AnnotationsModel;
@class GeoModel;

@interface SHBlogDetailModel : SHModel

@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) NSInteger weiboID;
@property (nonatomic, assign) NSInteger weiboMid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign, getter=isFavorited) BOOL favorited;
@property (nonatomic, assign, getter=isTruncated) BOOL truncated;

@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, strong) GeoModel *geo;
@property (nonatomic, strong) SHUserModel *user;
@property (nonatomic, strong) id retweeted_status;
@property (nonatomic, assign) NSInteger comments_count;
@property (nonatomic, assign) NSInteger reposts_count;
@property (nonatomic, assign) NSInteger attitudes_count;

@property (nonatomic, strong) id visible;
@property (nonatomic, strong) id pic_ids;
@property (nonatomic, strong) NSArray *ad;

//以下属性尚未明确含义
@property (nonatomic, assign) NSInteger biz_feature;
@property (nonatomic, strong) NSArray *biz_ids;
@property (nonatomic, strong) NSArray *darwin_tags;
@property (nonatomic, strong) NSArray *hot_weibo_tags;
@property (nonatomic, assign) BOOL isLongText;
@property (nonatomic, assign) NSInteger textLength;
@property (nonatomic, strong) NSArray *text_tag_tips;

//@property (nonatomic, strong) NSString *avatar;
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, assign) NSInteger vip;
//@property (nonatomic, strong) NSString *time;
//@property (nonatomic, strong) NSString *source;
//@property (nonatomic, strong) NSString *text;
//@property (nonatomic, strong) NSArray *pictureArray;
//@property (nonatomic, assign) NSInteger relayCount;
//@property (nonatomic, assign) NSInteger commentCount;
//@property (nonatomic, assign) NSInteger praiseCount;

@end

/**
 *  微博注解 包括经纬度
 */
@interface AnnotationsModel : SHModel

@property (nonatomic, copy) NSString *client_mblogid;
@property (nonatomic, strong) NSDictionary *place;

@end



