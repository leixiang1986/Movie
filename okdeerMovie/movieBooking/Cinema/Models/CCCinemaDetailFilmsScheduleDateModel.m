//
//  CCCinemaDetailFilmsScheduleDateModel.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsScheduleDateModel.h"

@implementation CCCinemaDetailFilmsScheduleDateModel
+ (instancetype)modelWithDate:(NSDate *)date andCurrentDate:(NSDate *)currentDate{
    CCCinemaDetailFilmsScheduleDateModel *model = [[self alloc] init];
    model.date = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componets = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
    NSInteger day = componets.day;

    NSDateComponents *currentComponets = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay ) fromDate:currentDate];
    NSInteger currentDay = currentComponets.day;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *showDayFormat = @"M月d日";
    NSString *requestDayFormat = @"yyyy-MM-dd";
    [dateFormatter setDateFormat:showDayFormat];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSMutableString *showResult = [[NSMutableString alloc] init];
    if (day == currentDay) {
        [showResult appendString:@"今天"];
    }
    else if (day == currentDay + 1) {
        [showResult appendString:@"明天"];
    }
    else {
        NSString *weekday = [self weekFromIndex:componets.weekday];
        [showResult appendString:weekday];
    }
    [showResult appendString:dateStr];

    [dateFormatter setDateFormat:requestDayFormat];
    model.requestDate = [dateFormatter stringFromDate:date];
    model.showDate = showResult;

    return model;
}

+ (NSString *)weekFromIndex:(NSInteger)index {
    NSArray *weeks = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    if (index >= 1 && index <= 7) {
        return weeks[index - 1];
    }

    return @"";
}



@end
