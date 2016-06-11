//
//  NSDate+Category.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSDate *)localeDate
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}
+ (NSDate *)afterDayDate
{
    NSDate *date = [NSDate localeDate];
    NSTimeInterval day = 60*60*24;
    return [date dateByAddingTimeInterval:day];
}
@end
