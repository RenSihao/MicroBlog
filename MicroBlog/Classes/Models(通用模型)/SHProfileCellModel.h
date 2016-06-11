//
//  SHProfileCellModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHProfileCellModel : SHModel

@property (nonatomic, strong) UIImage *iconImage;      //图标
@property (nonatomic, strong) NSString *title;         //标题
@property (nonatomic, strong) NSString *detailTitle;   //详细标题
@property (nonatomic, assign) BOOL hasNewNotification; //是否有新通知（有，显示小红点；没有，显示右边箭头）

@end
