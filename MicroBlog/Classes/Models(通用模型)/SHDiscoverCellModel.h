//
//  SHDiscoverCellModel.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHDiscoverCellModel : SHModel


@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, assign) BOOL hasNewNotification;

@end
