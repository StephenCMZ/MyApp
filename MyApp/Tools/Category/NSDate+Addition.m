//
//  NSDate+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

// ================================================================= 基本信息

#pragma mark - 获取日，月，年，小时，分钟，秒

- (NSUInteger)day{
    return [NSDate day:self];
}
- (NSUInteger)month{
    return [NSDate month:self];
}
- (NSUInteger)year{
    return [NSDate year:self];
}
- (NSUInteger)hour{
    return [NSDate hour:self];
}
- (NSUInteger)minute{
    return [NSDate minute:self];
}
- (NSUInteger)second{
    return [NSDate second:self];
}
+ (NSUInteger)day:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
    return [dayComponents day];
}
+ (NSUInteger)month:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    return [dayComponents month];
}
+ (NSUInteger)year:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
    return [dayComponents year];
}
+ (NSUInteger)hour:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
    return [dayComponents hour];
}
+ (NSUInteger)minute:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
    return [dayComponents minute];
}
+ (NSUInteger)second:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
    return [dayComponents second];
}

#pragma mark - 获取一年中的总天数

- (NSUInteger)daysInYear{
    return [NSDate daysInYear:self];
}
+ (NSUInteger)daysInYear:(NSDate *)date{
    return [self isLeapYear:date] ? 366 : 365;
}

#pragma mark - 获取一月中的周数(可能为4,5,6)

- (NSUInteger)weeksOfMonth{
    return [NSDate weeksOfMonth:self];
}
+ (NSUInteger)weeksOfMonth:(NSDate *)date{
    return [[date lastdayOfMonth] weekOfYear] - [[date begindayOfMonth] weekOfYear] + 1;
}

#pragma mark - 获取指定月份的天数

- (NSUInteger)daysInMonth:(NSUInteger)month{
    return [NSDate daysInMonth:self month:month];
}
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month{
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
        return 31;
        case 2:
        return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

#pragma mark - 获取当前日期月份的天数

- (NSUInteger)daysInMonth{
    return [NSDate daysInMonth:self];
}
+ (NSUInteger)daysInMonth:(NSDate *)date{
    return [self daysInMonth:date month:[date month]];
}

#pragma mark - 获取该日期是该年的第几周

- (NSUInteger)weekOfYear{
    return [NSDate weekOfYear:self];
}
+ (NSUInteger)weekOfYear:(NSDate *)date{
    NSUInteger i;
    NSUInteger year = [date year];
    
    NSDate *lastdate = [date lastdayOfMonth];
    
    for (i = 1;[[lastdate dateAfterDay:-7 * i] year] == year; i++) {
        
    }
    
    return i;
}

#pragma mark - 距离该日期前几天

- (NSUInteger)daysAgo{
    return [NSDate daysAgo:self];
}
+ (NSUInteger)daysAgo:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}

#pragma mark - 获取星期几 [1 - Sunday] [7 - Saturday]

- (NSInteger)weekday{
    return [NSDate weekday:self];
}
+ (NSInteger)weekday:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

#pragma mark - 获取星期几(名称) [1 - Sunday] [7 - Saturday]

- (NSString *)dayFromWeekday{
    return [NSDate dayFromWeekday:self];
}
+ (NSString *)dayFromWeekday:(NSDate *)date{
    switch([date weekday]) {
        case 1:
        return @"星期天";
        break;
        case 2:
        return @"星期一";
        break;
        case 3:
        return @"星期二";
        break;
        case 4:
        return @"星期三";
        break;
        case 5:
        return @"星期四";
        break;
        case 6:
        return @"星期五";
        break;
        case 7:
        return @"星期六";
        break;
        default:
        break;
    }
    return @"";
}

// ================================================================= 获取date

#pragma mark - 获取string格式为format的日期

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

#pragma mark - 根据字符串返回日期,字符串格式"yyyy-MM-dd HH:mm:ss zzz"

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
    return [dateFormatter dateFromString:dateString];
}

#pragma mark - 获取该月的第一天的日期

- (NSDate *)begindayOfMonth{
    return [NSDate begindayOfMonth:self];
}
+ (NSDate *)begindayOfMonth:(NSDate *)date{
    return [self dateAfterDate:date day:-[date day] + 1];
}

#pragma mark - 获取该月的最后一天的日期

- (NSDate *)lastdayOfMonth{
     return [NSDate lastdayOfMonth:self];
}
+ (NSDate *)lastdayOfMonth:(NSDate *)date{
    NSDate *lastDate = [self begindayOfMonth:date];
    return [[lastDate dateAfterMonth:1] dateAfterDay:-1];
}

#pragma mark - 返回day天后的日期(若day为负数,则为|day|天前的日期)

- (NSDate *)dateAfterDay:(NSUInteger)day{
     return [NSDate dateAfterDate:self day:day];
}
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

#pragma mark - 返回month后的日期(若month为负数,则为|month|前的日期)

- (NSDate *)dateAfterMonth:(NSUInteger)month{
    return [NSDate dateAfterDate:self month:month];
}
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

#pragma mark - 返回numYears年后的日期

- (NSDate *)offsetYears:(int)numYears{
    return [NSDate offsetYears:numYears fromDate:self];
}
+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate{
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 返回numMonths月后的日期

- (NSDate *)offsetMonths:(int)numMonths{
    return [NSDate offsetMonths:numMonths fromDate:self];
}
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate{
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 返回numDays天后的日期

- (NSDate *)offsetDays:(int)numDays{
    return [NSDate offsetDays:numDays fromDate:self];
}
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate{
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

#pragma mark - 返回numHours小时后的日期

- (NSDate *)offsetHours:(int)hours{
    return [NSDate offsetHours:hours fromDate:self];
}
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate{
    if (fromDate == nil) {
        return nil;
    }
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

// ================================================================= 日期字符串

#pragma mark - 获取格式化为format格式的日期字符串

- (NSString *)stringWithFormat:(NSString *)format{
    return [NSDate stringWithDate:self format:format];
}
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format{
    return [date stringWithFormat:format];
}

#pragma mark - 获取格式化为YYYY-MM-dd HH:mm格式的日期字符串

- (NSString *)formatYMDHM{
    return [NSDate formatYMDHM:self];
}
+ (NSString *)formatYMDHM:(NSDate *)date{
    return [NSString stringWithFormat:@"%@ %@",[NSDate formatYMD:date],[NSDate formatHM:date]];
}

#pragma mark - 获取格式化为YYYY/MM/dd HH:mm格式的日期字符串

- (NSString *)formatYMDHM1{
    return [NSDate formatYMDHM1:self];
}
+ (NSString *)formatYMDHM1:(NSDate *)date{
    return [NSString stringWithFormat:@"%@ %@",[NSDate formatYMD1:date],[NSDate formatHM:date]];
}

#pragma mark - 获取格式化为YYYY年MM月dd日 HH:mm格式的日期字符串

- (NSString *)formatYMDHM2{
    return [NSDate formatYMDHM2:self];
}
+ (NSString *)formatYMDHM2:(NSDate *)date{
    return [NSString stringWithFormat:@"%@ %@",[NSDate formatYMD2:date],[NSDate formatHM:date]];
}

#pragma mark - 获取格式化为YYYY-MM-dd格式的日期字符串

- (NSString *)formatYMD{
    return [NSDate formatYMD:self];
}
+ (NSString *)formatYMD:(NSDate *)date{
    return [NSString stringWithFormat:@"%d-%02d-%02d",(int)[date year],(int)[date month], (int)[date day]];
}

#pragma mark - 获取格式化为YYYY/MM/dd格式的日期字符串

- (NSString *)formatYMD1{
    return [NSDate formatYMD1:self];
}
+ (NSString *)formatYMD1:(NSDate *)date{
    return [NSString stringWithFormat:@"%d/%02d/%02d",(int)[date year],(int)[date month], (int)[date day]];
}

#pragma mark - 获取格式化为YYYY年MM月dd日格式的日期字符串

- (NSString *)formatYMD2{
    return [NSDate formatYMD2:self];
}
+ (NSString *)formatYMD2:(NSDate *)date{
    return [NSString stringWithFormat:@"%d年%02d月%02d日",(int)[date year],(int)[date month], (int)[date day]];
}

#pragma mark - 获取格式化为YYYY/MM/dd HH:mm:ss格式的日期字符串

- (NSString *)formatYMDHMS{
    return [NSDate formatYMDHMS:self];
}
+ (NSString *)formatYMDHMS:(NSDate *)date{
    return [NSString stringWithFormat:@"%@ %@:%02d",[NSDate formatYMD:date],[NSDate formatHM:date],(int)date.second];
}

#pragma mark - 获取格式化为YYYY-MM-dd HH:mm:ss格式的日期字符串

- (NSString *)formatYMDHMS1{
    return [NSDate formatYMDHMS1:self];
}
+ (NSString *)formatYMDHMS1:(NSDate *)date{
    return [NSString stringWithFormat:@"%@ %@:%02d",[NSDate formatYMD1:date],[NSDate formatHM:date],(int)date.second];
}

#pragma mark - 获取格式化为HH:mm格式的日期字符串

- (NSString *)formatHM{
    return [NSDate formatHM:self];
}
+ (NSString *)formatHM:(NSDate *)date{
    return [NSString stringWithFormat:@"%02d:%02d",(int)[date hour],(int)[date minute]];
}

#pragma mark - 获取月份字符串 [1 - January] [12 - December]

+ (NSString *)monthWithMonthNumber:(NSInteger)month{
    switch(month) {
        case 1:
        return @"January";
        break;
        case 2:
        return @"February";
        break;
        case 3:
        return @"March";
        break;
        case 4:
        return @"April";
        break;
        case 5:
        return @"May";
        break;
        case 6:
        return @"June";
        break;
        case 7:
        return @"July";
        break;
        case 8:
        return @"August";
        break;
        case 9:
        return @"September";
        break;
        case 10:
        return @"October";
        break;
        case 11:
        return @"November";
        break;
        case 12:
        return @"December";
        break;
        default:
        break;
    }
    return @"";
}


// ================================================================= 日期判断

#pragma mark - 判断是否为闰年

- (BOOL)isLeapYear{
    return [NSDate isLeapYear:self];
}
+ (BOOL)isLeapYear:(NSDate *)date{
    NSUInteger year = [date year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) { return YES; }
    return NO;
}

#pragma mark - 是否同一天

- (BOOL)isSameDay:(NSDate *)anotherDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

#pragma mark - 是否同一周

- (BOOL)isSameWeek:(NSDate *)anotherDate{
    NSMutableArray *thisWeekDateArr = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 7; i++) {
        [thisWeekDateArr addObject:[self dateAfterDay:i - [self weekday]]];
    }
    
    return [thisWeekDateArr indexOfObject:anotherDate];
}

#pragma mark - 是否是今天

- (BOOL)isToday{
    return [self isSameDay:[NSDate date]];
}


// ================================================================= 其他

#pragma mark - 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串

- (NSString *)ymdFormat{
     return [NSDate ymdFormat];
}
- (NSString *)hmFormat {
    return [NSDate hmFormat];
}
- (NSString *)hmsFormat{
    return [NSDate hmsFormat];
}
- (NSString *)ymdHmsFormat{
    return [NSDate ymdHmsFormat];
}
- (NSString *)ymdHmFormat{
    return [NSDate ymdHmFormat];
}
+ (NSString *)ymdFormat{
    return @"yyyy-MM-dd";
}
+ (NSString *)hmFormat {
    return @"HH:mm";
}
+ (NSString *)hmsFormat{
    return @"HH:mm:ss";
}
+ (NSString *)ymdHmsFormat{
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}
+ (NSString *)ymdHmFormat{
    return [NSString stringWithFormat:@"%@ %@",[self ymdFormat],[self hmFormat]];
}

#pragma mark - 获取年龄

+ (NSUInteger)age:(NSDate *)date{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

#pragma mark - 获取x分钟前/x小时前/昨天/x天前/x个月前/x年前

- (NSString *)timeInfo{
     return [NSDate timeInfoWithDate:self];
}
+ (NSString *)timeInfoWithDate:(NSDate *)date{
    return [self timeInfoWithDateString:[self stringWithDate:date format:[self ymdHmsFormat]]];
}
+ (NSString *)timeInfoWithDateString:(NSString *)dateString{
    NSDate *date = [self dateWithString:dateString format:[self ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self daysInMonth:date month:[date month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate month];
            int preMonth = (int)[date month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

#pragma mark - 获取星座

- (NSString *)getXingzuo{
    return [NSDate getXingzuo:self];
}
+ (NSString *)getXingzuo:(NSDate *)date{
    //计算星座
    NSString *retStr=@"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month=0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day=0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
        if(i_day>=20 && i_day<=31){
            retStr=@"水瓶座";
        }
        if(i_day>=1 && i_day<=19){
            retStr=@"摩羯座";
        }
        break;
        case 2:
        if(i_day>=1 && i_day<=18){
            retStr=@"水瓶座";
        }
        if(i_day>=19 && i_day<=31){
            retStr=@"双鱼座";
        }
        break;
        case 3:
        if(i_day>=1 && i_day<=20){
            retStr=@"双鱼座";
        }
        if(i_day>=21 && i_day<=31){
            retStr=@"白羊座";
        }
        break;
        case 4:
        if(i_day>=1 && i_day<=19){
            retStr=@"白羊座";
        }
        if(i_day>=20 && i_day<=31){
            retStr=@"金牛座";
        }
        break;
        case 5:
        if(i_day>=1 && i_day<=20){
            retStr=@"金牛座";
        }
        if(i_day>=21 && i_day<=31){
            retStr=@"双子座";
        }
        break;
        case 6:
        if(i_day>=1 && i_day<=21){
            retStr=@"双子座";
        }
        if(i_day>=22 && i_day<=31){
            retStr=@"巨蟹座";
        }
        break;
        case 7:
        if(i_day>=1 && i_day<=22){
            retStr=@"巨蟹座";
        }
        if(i_day>=23 && i_day<=31){
            retStr=@"狮子座";
        }
        break;
        case 8:
        if(i_day>=1 && i_day<=22){
            retStr=@"狮子座";
        }
        if(i_day>=23 && i_day<=31){
            retStr=@"处女座";
        }
        break;
        case 9:
        if(i_day>=1 && i_day<=22){
            retStr=@"处女座";
        }
        if(i_day>=23 && i_day<=31){
            retStr=@"天秤座";
        }
        break;
        case 10:
        if(i_day>=1 && i_day<=23){
            retStr=@"天秤座";
        }
        if(i_day>=24 && i_day<=31){
            retStr=@"天蝎座";
        }
        break;
        case 11:
        if(i_day>=1 && i_day<=21){
            retStr=@"天蝎座";
        }
        if(i_day>=22 && i_day<=31){
            retStr=@"射手座";
        }
        break;
        case 12:
        if(i_day>=1 && i_day<=21){
            retStr=@"射手座";
        }
        if(i_day>=21 && i_day<=31){
            retStr=@"摩羯座";
        }
        break;
    }
    return retStr;
}

@end
