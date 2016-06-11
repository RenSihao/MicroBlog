//
//  SHRepostViewController.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/14.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHTableViewController.h"
@class SHStatusModel;

@interface SHRepostWeiboVC : SHTableViewController

@property (nonatomic, copy) void (^successSubmit)();

- (instancetype)initWithWeiboModel:(SHStatusModel *)model;
@end
