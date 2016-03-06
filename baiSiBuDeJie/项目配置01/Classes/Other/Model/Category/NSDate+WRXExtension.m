//
//  NSDate+WRXExtension.m
//  项目配置01
//
//  Created by wang on 16/1/24.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSDate+WRXExtension.h"

@implementation NSDate (WRXExtension)

//时间处理
/*
 今年 （昨天，今天（xx小时前，xx多少分钟前，刚刚））
 其他年份
 
 年月日时分秒对应的时间格式：yyyy-MM-dd HH:mm:ss
 */

/**
 * 是否是今年
 */
- (BOOL)isThisYear{

    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];//字符串和NSDate对象相互转换时，要设置格式
    formatter.dateFormat = @"yyyy";
   NSString *selfString = [formatter stringFromDate:self];
    NSString *nowString = [formatter stringFromDate:now];
    return [selfString isEqualToString:nowString];
}

/**
 * 是否是今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfString = [formatter stringFromDate:self];
    NSString *nowString = [formatter stringFromDate:now];
    return [selfString isEqualToString:nowString];

}

/**
 * 是否是昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];//NSCalendar对象用来计算两个NSDate对象之间的时间差
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfString = [formatter stringFromDate:self];
    NSString *nowString = [formatter stringFromDate:now];
    NSDate *selfDate = [formatter dateFromString:selfString];
    NSDate *nowDate = [formatter dateFromString:nowString];
   NSDateComponents *com = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];//options传0；
    return com.year == 0 && com.month == 0 && com.day == 1;
}
@end
