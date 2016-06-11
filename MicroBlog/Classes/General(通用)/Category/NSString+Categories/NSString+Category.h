//
//  NSString+Category.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/**
 *  md5加密
 *
 *  @param string 需要加密的NSString
 *
 *  @return 使用md5加密过的NSString
 */
+ (NSString *)md5:(NSString *)string;

/**
 *  获取字符串所占位置大小
 *
 *  @param font  字符串要显示的字体
 *  @param width 每行最大宽度
 *
 *  @return 字符串大小
 */
- (CGSize)stringSizeWithFont:(UIFont*)font contraintWith:(CGFloat)width;
@end
