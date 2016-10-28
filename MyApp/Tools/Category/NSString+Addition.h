//
//  NSString+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

#pragma mark - 字符串操作

/**
 base64 加密
 
 @return 加密后字符串
 */
- (NSString *)base64EnCode;

/**
 base64 解密
 
 @return 解密后字符串
 */
- (NSString *)base64DeCode;

/**
 计算字符串的字数

 @return 字数
 */
- (NSUInteger)byteLength;

/**
 计算字符串的字数
 
 @param encoding 编码格式
 
 @return 字数
 */
- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding;

/**
 URL解码

 @return 解码后的URL
 */
- (NSString *)URLDecodedString;


/**
 URL编码

 @return 编码后的URL
 */
- (NSString *)URLEncodedString;

/**
 转为UTF8

 @return UTF8编码字符串
 */
- (NSString *)encodeStringWithUTF8;


/**
 去除字符串前后空格

 @param str 被操作字符串

 @return 操作后字符串
 */
+ (NSString *)trimmed:(NSString *)str;


/**
 去除字符串前后空格

 @return 操作后字符串
 */
- (NSString *)trimmed;


#pragma mark - 字符串验证

/**
 邮箱合法验证
 */
- (BOOL)isValidateEmail;

/**
 密码合法验证：6—16位，只能包含字符、数字和 下划线。
 */
- (BOOL)isValidatePassword;

/**
 验证是否为网络链接
 */
- (BOOL)isInternetUrl;

/**
 验证是否为电话号码
 */
- (BOOL)isPhoneNumber;

/**
 判断是否为11位的数字
 */
- (BOOL)isElevenDigitNum;

/**
 验证15或18位身份证
 */
- (BOOL)isIdentifyCardNumber;

/**
 全是数字
 */
- (BOOL)isNumber;

/**
 验证英文字母
 */
- (BOOL)isEnglishWords;

/**
 验证是否为汉字
 */
- (BOOL)isChineseWords;


@end
