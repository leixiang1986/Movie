//
//  CCCustomDateAndTime.m
//  ThumbLife
//
//  Created by JuGuang on 14-8-9.
//  Copyright (c) 2014年 聚光电子科技. All rights reserved.
//

#import "CCCustomDateAndTime.h"
#import "OkdeerCommUIHeader.h"
@implementation CCCustomDateAndTime

static CCCustomDateAndTime *dateAndTime = nil;
static NSDateFormatter *formatter = nil;
static NSCalendar *calendar = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (formatter == nil) {
            [self initForMatter];
        }
        if (calendar == nil) {
            [self initCalender];
        }
       
    }
    return self;
}
//初始化时间格式
- (void)initForMatter{
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设置时间格式
}
//初始化NSCalendar
- (void)initCalender{
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:(kUIIOS8UP ? NSCalendarIdentifierGregorian : NSGregorianCalendar)];
}

+(CCCustomDateAndTime *)shareDateAndTime{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateAndTime = [[CCCustomDateAndTime alloc] init];
    });
   
    
    return dateAndTime;
}
/**
 将时间格式转换成字符串
 设置预约时间   当分钟在0-30之间   最小时间为 当前的时  和分钟为30
 当分钟大于30  最小时间为当前的时加1 分钟为0
 */
- (NSString *)datetostring{
    //设置时间格式
    if (calendar == nil) {
        [self initCalender];
    }
    unsigned unit ;

        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;

    
    NSDateComponents *components = [calendar components:unit fromDate:[NSDate date]];
    [components setMinute:[components minute] + 5];
    return [self datetostring:[calendar dateFromComponents:components]];
}
//字符串格式转成日期date转换特定时间格式
- (NSDate *)datestringtodate:(NSString *)dateString{
    if (formatter == nil) {
        [self initForMatter];
    }
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}
//日期date转换特定时间格式  转成字符串格式
- (NSString *)datetostring:(NSDate *)date{
    if (formatter == nil) {
        [self initForMatter];
    }
    NSString *str = [formatter stringFromDate:date];
    return str;
}

//设置最大的天数
- (NSDate *)setmaxiDay:(NSInteger)day{

    if (calendar == nil) {
        [self initCalender];
    }
    unsigned unit ;

    
        unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;

    NSDateComponents *components = [calendar components:unit fromDate:[NSDate date]];
    if ([components minute] < 30) {
        [components setMinute:30];
    }else {
        [components setHour:[components hour] + 1];
        [components setMinute:0];
    }
    [components setDay:[components day] + 7];
    return [calendar dateFromComponents:components];
}


/**
 *  获取当前日期的年
 *
 *  @param date 当前的日期
 *
 *  @return 年
 */
- (NSString *)currentYear:(NSDate *)date{
    unsigned unit ;
    
    unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents *components = [calendar components:unit fromDate:date];
    return [NSString stringWithFormat:@"%ld",(long)[components year]] ;
}
/**
 *  获取当前日期的月
 *
 *  @param date 当前的日期
 *
 *  @return 月
 */
- (NSString *)currentMonth:(NSDate *)date{
    unsigned unit ;
    
    unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents *components = [calendar components:unit fromDate:date];
    return [NSString stringWithFormat:@"%ld",(long)[components month]] ;

}

/**
 *  获取当前日期的日
 *
 *  @param date 当前的日期
 *
 *  @return 日
 */
- (NSString *)currentDay:(NSDate *)date{
    unsigned unit ;
    
    unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents *components = [calendar components:unit fromDate:date];
    return [NSString stringWithFormat:@"%ld",(long)[components day]] ;
}

/**
 根据10位的时间转换成nsdate
 */
- (NSDate *)getDateInteger:(NSTimeInterval)integer{
    return [[NSDate alloc] initWithTimeIntervalSince1970:integer];
}

/**
 *  得到年和月
 *
 *  @param yearMonth 年月的组合
 *
 *  @return
 */
- (NSString *)getYearAndMonth:(NSString *)yearMonth{
    unsigned unit ;
    
    unit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents *components = [calendar components:unit fromDate:[formatter dateFromString:yearMonth]];
    return [NSString stringWithFormat:@"%ld%ld",(long)[components year],(long)[components month]] ;
}


@end
