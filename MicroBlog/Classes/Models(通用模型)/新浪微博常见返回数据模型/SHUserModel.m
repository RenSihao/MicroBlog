//
//  SHUserModel.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHUserModel.h"

@implementation SHUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userID" : @"id"};
}

@end
