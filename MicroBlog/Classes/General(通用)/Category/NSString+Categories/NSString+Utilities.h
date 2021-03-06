//
//  NSString+Utilities.h
//  Penkr
//
//  Created by 王汗青 on 16/1/28.
//  Copyright © 2016年 ShopEX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)
/**判断字符串是否为空，如果字符串为空格也会判断为空
 */
+ (BOOL)isEmpty:(NSString*) str;

/**判断字符串是否为空,字符串可以为空格
 */
+ (BOOL)isNull:(NSString*) str;

/**中文编码
 */
+ (NSString*)encodeStr:(NSString *)str;

/*
 对指定的参数进行url编码
 入参sourceString 是希望进行编码的字符串
 返回值是编码后的字符串,此方法对!*'();:@&=+$,/?%#[]都做了编码
 */
+ (NSString*)URLencode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding;
+ (NSString *)encodeUrlStr:(NSString *)sourceString;

/**判断是不是纯数字
 */
- (BOOL)isNumText;

/**第一个字符
 */
- (char)firstCharacter;

/**最后一个字符
 */
- (char)lastCharacter;

/**百度搜索链接
 */
+ (NSString*)baiduURLForKey:(NSString*) key;

/**判断是否是整数
 */
- (BOOL)isPureInt;

/**忽略空的字符串 nil，防止使用 stringByAppendingString 时，参数为nil时崩溃
 *@return 字符串
 */
- (NSString*)stringByAppendingStringIgnoreNil:(NSString *)aString;

/**获取字符串所占位置大小
 *@param font 字符串要显示的字体
 *@param width 每行最大宽度
 *@return 字符串大小
 */
- (CGSize)stringSizeWithFont:(UIFont*) font contraintWith:(CGFloat) width;

/**把中文字符成两个字符的字符串长度
 */
- (NSUInteger)lengthWithChineseAsTwoChar;

#pragma mark- md5

- (NSString *) md5;

#pragma mark- 验证合法性

/**判断是否是是手机号码
 */
- (BOOL)isMobileNumber;

/**特殊字符验证
 */
- (BOOL)isIncludeSpecialCharacter;

/**邮政编码验证
 */
- (BOOL)isZipCode;

/**验证固定电话
 */
- (BOOL)isTelPhoneNumber;

/**验证邮箱
 */
- (BOOL)isEmail;

/**是否是身份证号码
 */
- (BOOL)isCardId;

/**是否是网址
 */
- (BOOL)isURL;

/**是否是中文
 */
- (BOOL)isChinese;

- (BOOL)ispassWord;

/**将字符串转换成 ¥ xxx,xxx,xxx.00格式 */
- (NSString *)formatNumberDecimalBy:(NSString *)str;

@end

@interface NSMutableString (Utilities)

/**移除最后一个字符
 */
- (void)removeLastCharacter;

/**通过给定字符串，移除最后一个字符串
 */
- (void)removeLastStringWithString:(NSString*) str;

@end