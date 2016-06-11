//
//  SHCommentModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/12.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHModel.h"

/*
 评论（comment）
 返回值字段 	     字段类型 	字段说明
 created_at 	 string 	评论创建时间
 id 	         int64 	评论的ID
 text 	         string 	评论的内容
 source 	     string 	评论的来源
 user 	         object 	评论作者的用户信息字段 详细
 mid 	         string 	评论的MID
 idstr 	         string 	字符串型的评论ID
 status 	     object 	评论的微博信息字段 详细
 reply_comment 	 object 	评论来源评论，当本评论属于对另一评论的回复时返回此字段
 */

@interface SHCommentModel : SHModel

@end
