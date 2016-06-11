//
//  SHMessageViewController.h
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MessageCenterType){
    MessageCenterAt = 0,        //@我的
    MessageCenterComments,      //评论
    MessageCenterGood,          //赞
    MessageCenterSubScription,  //订阅消息
    MessageCenterMessageBox     //未关注人消息
    
};


@interface SHMessageVC : SHTableViewController

@end
