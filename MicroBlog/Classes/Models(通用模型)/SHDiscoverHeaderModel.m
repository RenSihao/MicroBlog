//
//  SHDiscoverHeaderModel.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHDiscoverHeaderModel.h"

@implementation SHDiscoverHeaderModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _leftTopTitle = [dict objectForKeyNotNull:@"leftTopTitle"];
        _rightTopTitle = [dict objectForKeyNotNull:@"rightTopTitle"];
        _leftBottomTitle = [dict objectForKeyNotNull:@"leftBottomTitle"];
        _rightBotttomTitle = [dict objectForKeyNotNull:@"rightBottomTitle"];
    }
    return self;
}

@end
