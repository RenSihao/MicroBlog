//
//  SHPrivacyModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/12.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHModel.h"

/*
 隐私设置（privacy）
 返回值字段   	字段类型 	字段说明
 comment 	    int 	是否可以评论我的微博，0：所有人、1：关注的人、2：可信用户
 geo 	        int 	是否开启地理信息，0：不开启、1：开启
 message 	    int 	是否可以给我发私信，0：所有人、1：我关注的人、2：可信用户
 realname 	    int 	是否可以通过真名搜索到我，0：不可以、1：可以
 badge 	        int 	勋章是否可见，0：不可见、1：可见
 mobile 	    int 	是否可以通过手机号码搜索到我，0：不可以、1：可以
 webim 	        int 	是否开启webim， 0：不开启、1：开启

 */

@interface SHPrivacyModel : SHModel

@end
