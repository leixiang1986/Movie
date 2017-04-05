//
//  CCCustomDateAndTime.h
//  ThumbLife
//
//  Created by JuGuang on 14-8-9.
//  Copyright (c) 2014年 聚光电子科技. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 设置时间格式 
 将date格式转换成字符串
 将字符串时间转换成date格式
 设置特定格式
 */
@interface CCCustomDateAndTime : NSObject

+(CCCustomDateAndTime *)shareDateAndTime;
/**
 将时间格式转换成字符串
 设置预约时间   当分钟在0-30之间   最小时间为 当前的时  和分钟为30
 当分钟大于30  最小时间为当前的时加1 分钟为0
 */
- (NSString *)datetostring;
/**
 字符串格式转成日期date转换特定时间格式
 
 @param dateString 字符串时间格式
 
 @return date格式
 */
- (NSDate *)datestringtodate:(NSString *)dateString;
/**
 日期date转换特定时间格式  转成字符串格式
 
 @param  date 格式
 
 @return 字符串时间格式
 */
- (NSString *)datetostring:(NSDate *)date;
/**
 
 设置最大的天数
 @param day 最大天数
 
 @return 最长时间
 */

- (NSDate *)setmaxiDay:(NSInteger)day;
/**
 *  获取当前日期的年
 *
 *  @param date 当前的日期
 *
 *  @return 年
 */
- (NSString *)currentYear:(NSDate *)date;

/**
 *  获取当前日期的月
 *
 *  @param date 当前的日期
 *
 *  @return 月
 */
- (NSString *)currentMonth:(NSDate *)date;
/**
 *  获取当前日期的日
 *
 *  @param date 当前的日期
 *
 *  @return 日
 */
- (NSString *)currentDay:(NSDate *)date;

/**
 根据10位的时间转换成nsdate
 */
- (NSDate *)getDateInteger:(NSTimeInterval)integer;
/**
 *  得到年和月
 *
 *  @param yearMonth 年月的组合
 *
 *  @return  NSString
 */
- (NSString *)getYearAndMonth:(NSString *)yearMonth ;


@end
