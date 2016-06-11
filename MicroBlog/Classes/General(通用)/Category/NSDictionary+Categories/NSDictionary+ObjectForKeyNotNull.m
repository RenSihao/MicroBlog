//
//  NSDictionary+ObjectForKeyNotNull.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "NSDictionary+ObjectForKeyNotNull.h"

@implementation NSDictionary (ObjectForKeyNotNull)

- (id)objectForKeyNotNull:(id)aKey
{
    if ([self objectForKey:aKey])
    {
        //Null类型
        if ([[self objectForKey:aKey] isKindOfClass:[NSNull class]])
        {
            return nil;
        }
        //数字类型 0
        if ([[self objectForKey:aKey] isKindOfClass:[NSNumber class]])
        {
            return [[self objectForKey:aKey] stringValue];
        }
        //正常情况
        return [self objectForKey:aKey];
    }
    else
    {
        //没有这个字段
        return nil;
    }
}

@end
