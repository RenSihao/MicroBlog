//
//  NSString+Category.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)

/**
 *  md5加密
 *
 *  @param string 需要加密的NSString
 *
 *  @return 使用md5加密过的NSString
 */
+ (NSString *)md5:(NSString *)string
{
    if (string == nil || [string length] == 0)
    {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}


/**
 *  获取字符串所占位置大小
 *
 *  @param font  字符串要显示的字体
 *  @param width 每行最大宽度
 *
 *  @return 字符串大小
 */
- (CGSize)stringSizeWithFont:(UIFont*)font contraintWith:(CGFloat)width
{
    CGSize size;
    CGSize contraintSize = CGSizeMake(width, CGFLOAT_MAX);
    if(IOS_7_OR_LATER)
    {
#ifdef __IPHONE_7_0
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        
        size = [self boundingRectWithSize:contraintSize  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
#endif
    }
    else
    {
#ifdef __IPHONE_7_0
#else
        size = [self sizeWithFont:font constrainedToSize:contraintSize lineBreakMode:NSLineBreakByCharWrapping];
#endif
    }
    
    return size;
}

@end
