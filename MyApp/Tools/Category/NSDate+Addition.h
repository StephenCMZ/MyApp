//
//  NSDate+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

// ================================================================= 基本信息

#pragma mark - 获取日，月，年，小时，分钟，秒

- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;

#pragma mark - 获取一年中的总天数

- (NSUInteger)daysInYear;
+ (NSUInteger)daysInYear:(NSDate *)date;

#pragma mark - 获取一月中的周数(可能为4,5,6)

- (NSUInteger)weeksOfMonth;
+ (NSUInteger)weeksOfMonth:(NSDate *)date;

#pragma mark - 获取指定月份的天数

- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;

#pragma mark - 获取当前日期月份的天数

- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;

#pragma mark - 获取该日期是该年的第几周

- (NSUInteger)weekOfYear;
+ (NSUInteger)weekOfYear:(NSDate *)date;

#pragma mark - 距离该日期前几天

- (NSUInteger)daysAgo;
+ (NSUInteger)daysAgo:(NSDate *)date;

#pragma mark - 获取星期几 [1 - Sunday] [7 - Saturday]

- (NSInteger)weekday;
+ (NSInteger)weekday:(NSDate *)date;

#pragma mark - 获取星期几(名称) [1 - Sunday] [7 - Saturday]

- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;

// ================================================================= 获取date

#pragma mark - 获取string格式为format的日期

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

#pragma mark - 根据字符串返回日期,字符串格式"yyyy-MM-dd HH:mm:ss zzz"

+ (NSDate *)dateFromString:(NSString *)dateString;

#pragma mark - 获取该月的第一天的日期

- (NSDate *)begindayOfMonth;
+ (NSDate *)begindayOfMonth:(NSDate *)date;

#pragma mark - 获取该月的最后一天的日期

- (NSDate *)lastdayOfMonth;
+ (NSDate *)lastdayOfMonth:(NSDate *)date;

#pragma mark - 返回day天后的日期(若day为负数,则为|day|天前的日期)

- (NSDate *)dateAfterDay:(NSUInteger)day;
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day;

#pragma mark - 返回month后的日期(若month为负数,则为|month|前的日期)

- (NSDate *)dateAfterMonth:(NSUInteger)month;
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month;

#pragma mark - 返回numYears年后的日期

- (NSDate *)offsetYears:(int)numYears;
+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

#pragma mark - 返回numMonths月后的日期

- (NSDate *)offsetMonths:(int)numMonths;
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

#pragma mark - 返回numDays天后的日期

- (NSDate *)offsetDays:(int)numDays;
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

#pragma mark - 返回numHours小时后的日期

- (NSDate *)offsetHours:(int)hours;
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

// ================================================================= 日期字符串

#pragma mark - 获取格式化为format格式的日期字符串

- (NSString *)stringWithFormat:(NSString *)format;
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

#pragma mark - 获取格式化为YYYY-MM-dd HH:mm格式的日期字符串

- (NSString *)formatYMDHM;
+ (NSString *)formatYMDHM:(NSDate *)date;

#pragma mark - 获取格式化为YYYY/MM/dd HH:mm格式的日期字符串

- (NSString *)formatYMDHM1;
+ (NSString *)formatYMDHM1:(NSDate *)date;

#pragma mark - 获取格式化为YYYY年MM月dd日 HH:mm格式的日期字符串

- (NSString *)formatYMDHM2;
+ (NSString *)formatYMDHM2:(NSDate *)date;

#pragma mark - 获取格式化为YYYY-MM-dd格式的日期字符串

- (NSString *)formatYMD;
+ (NSString *)formatYMD:(NSDate *)date;

#pragma mark - 获取格式化为YYYY/MM/dd格式的日期字符串

- (NSString *)formatYMD1;
+ (NSString *)formatYMD1:(NSDate *)date;

#pragma mark - 获取格式化为YYYY年MM月dd日格式的日期字符串

- (NSString *)formatYMD2;
+ (NSString *)formatYMD2:(NSDate *)date;

#pragma mark - 获取格式化为YYYY/MM/dd HH:mm:ss格式的日期字符串

- (NSString *)formatYMDHMS;
+ (NSString *)formatYMDHMS:(NSDate *)date;

#pragma mark - 获取格式化为YYYY-MM-dd HH:mm:ss格式的日期字符串

- (NSString *)formatYMDHMS1;
+ (NSString *)formatYMDHMS1:(NSDate *)date;

#pragma mark - 获取格式化为HH:mm格式的日期字符串

- (NSString *)formatHM;
+ (NSString *)formatHM:(NSDate *)date;

#pragma mark - 获取月份字符串 [1 - January] [12 - December]

+ (NSString *)monthWithMonthNumber:(NSInteger)month;


// ================================================================= 日期判断

#pragma mark - 判断是否为闰年

- (BOOL)isLeapYear;
+ (BOOL)isLeapYear:(NSDate *)date;

#pragma mark - 是否同一天

- (BOOL)isSameDay:(NSDate *)anotherDate;

#pragma mark - 是否同一周

- (BOOL)isSameWeek:(NSDate *)anotherDate;

#pragma mark - 是否是今天

- (BOOL)isToday;


// ================================================================= 其他

#pragma mark - 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串

- (NSString *)ymdFormat;
- (NSString *)hmFormat;
- (NSString *)hmsFormat;
- (NSString *)ymdHmsFormat;
- (NSString *)ymdHmFormat;
+ (NSString *)ymdFormat;
+ (NSString *)hmsFormat;
+ (NSString *)ymdHmsFormat;
+ (NSString *)ymdHmFormat;

#pragma mark - 获取年龄

+ (NSUInteger)age:(NSDate *)date;

#pragma mark - 获取x分钟前/x小时前/昨天/x天前/x个月前/x年前

- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;

#pragma mark - 获取星座

- (NSString *)getXingzuo;
+ (NSString *)getXingzuo:(NSDate *)date;


@end
