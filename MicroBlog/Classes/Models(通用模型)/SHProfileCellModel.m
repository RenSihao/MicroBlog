//
//  SHProfileCellModel.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHProfileCellModel.h"

@implementation SHProfileCellModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _iconImage = [UIImage imageNamed:[dict objectForKeyNotNull:@"iconImage"]];
        _title = [dict objectForKeyNotNull:@"title"];
        _detailTitle = [dict objectForKeyNotNull:@"detailTitle"];
        _hasNewNotification = [[dict objectForKeyNotNull:@"hasNewNotification"] boolValue];
    }
    return self;
}
@end
