//
//  SHStatusModel.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/12.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHStatusModel.h"

@implementation SHStatusModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"pic_urls" : [PictureUrlModel class]
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"wbID" : @"id",
             @"wbMidID" : @"mid"};
}

@end

@implementation PictureUrlModel


@end
