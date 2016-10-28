//
//  NSString+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

#pragma mark - 字符串操作

/**
 base64 加密

 @return 加密后字符串
 */
- (NSString *)base64EnCode{
    
    if (self && ![self isEqualToString:@""]) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        return [self base64EncodedStringFrom:data];
    }else {
        return @"";
    }
    return nil;
}

/**
 base64 解密

 @return 解密后字符串
 */
- (NSString *)base64DeCode{
    if (self && ![self isEqualToString:@""]) {
        NSData *data = [self dataWithBase64EncodedString:self];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return @"";
    }
}

/**
 文本数据转换为base64格式字符串
 
 @param data 文本数据
 
 @return base64格式字符串
 */
- (NSString *)base64EncodedStringFrom:(NSData *)data{
    
    if ([data length] == 0) return @"";
    const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)  return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length]){
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length]) buffer[bufferLength++] = ((char *)[data bytes])[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1){
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        }else{
            characters[length++] = '=';
        }
        if (bufferLength > 2){
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        }else{
            characters[length++] = '=';
        }
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

/**
 base64格式字符串转换为文本数据
 
 @param string base64格式字符串
 
 @return 文本数据
 */
- (NSData *)dataWithBase64EncodedString:(NSString *)string{
    
    if (string == nil) [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0) return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL){
        decodingTable = malloc(256);
        if (decodingTable == NULL) return nil;
        memset(decodingTable, CHAR_MAX, 256);
        const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        NSUInteger i;
        for (i = 0; i < 64; i++) decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL) return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL) return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0')  break;
            if (isspace(characters[i]) || characters[i] == '=')  continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX){
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)  break;
        if (bufferLength == 1){
            free(bytes);
            return nil;
        }
        
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2) bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3) bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/**
 计算字符串的字数
 
 @return 字数
 */
- (NSUInteger)byteLength{
    int i,n = (int)[self length], l = 0, a = 0, b = 0;
    unichar c;
    for(i = 0;i < n; i++) {
        c = [self characterAtIndex:i];
        if(isblank(c))
        {
            b++;
        }else if(isascii(c))
        {
            a++;
        }else{
            l++;
        }
    }
    if(a == 0 && l == 0) return 0;
    return l + (int)ceilf((float)(a + b) / 2.0);
}

/**
 计算字符串的字数
 
 @param encoding 编码格式
 
 @return 字数
 */
- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding{
    if (!self) { return 0; }
    const char *byte = [self cStringUsingEncoding:encoding];
    return strlen(byte);
}


/**
 URL解码
 
 @return 解码后的URL
 */
- (NSString *)URLDecodedString{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}


/**
 URL编码
 
 @return 编码后的URL
 */
- (NSString *)URLEncodedString{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

/**
 转为UTF8
 
 @return UTF8编码字符串
 */
- (NSString *)encodeStringWithUTF8{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    const char *c =  [self cStringUsingEncoding:encoding];
    NSString *str = [NSString stringWithCString:c encoding:NSUTF8StringEncoding];
    
    return str;
}


/**
 去除字符串前后空格
 
 @param str 被操作字符串
 
 @return 操作后字符串
 */
+ (NSString *)trimmed:(NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


/**
 去除字符串前后空格
 
 @return 操作后字符串
 */
- (NSString *)trimmed{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 字符串验证

/**
 邮箱合法验证
 */
- (BOOL)isValidateEmail{
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 密码合法验证：6—16位，只能包含字符、数字和 下划线。
 */
- (BOOL)isValidatePassword{
    NSString *regex = @"^[\\w\\d_]{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 验证是否为网络链接
 */
- (BOOL)isInternetUrl{
    NSString *regex = @"^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 验证是否为电话号码
 */
- (BOOL)isPhoneNumber{
    return [self isElevenDigitNum];
}

/**
 判断是否为11位的数字
 */
- (BOOL)isElevenDigitNum{
    
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [predicate evaluateWithObject:self];
    
    if (result && self.length == 11) {return YES;}
    return NO;
}

/**
 验证15或18位身份证
 */
- (BOOL)isIdentifyCardNumber{
    NSString *regex = @"^\\d{15}|\\d{}18$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 全是数字
 */
- (BOOL)isNumber{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 验证英文字母
 */
- (BOOL)isEnglishWords{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 验证是否为汉字
 */
- (BOOL)isChineseWords{
    NSString *regex = @"^[\u4e00-\u9fa5],{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end
