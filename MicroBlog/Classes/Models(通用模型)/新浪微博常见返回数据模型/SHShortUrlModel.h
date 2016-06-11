//
//  SHShortUrlModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/12.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHModel.h"

/*
 返回值字段 	  字段类型 	字段说明
 url_short 	  string 	短链接
 url_long 	  string 	原始长链接
 type 	      int 	    链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
 result 	  boolean 	短链的可用状态，true：可用、false：不可用。
 */

@interface SHShortUrlModel : SHModel

@end
