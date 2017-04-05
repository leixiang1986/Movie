//
//  CCCinemaDetailFilmsScheduleDateModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

//电影排期的date
@interface CCCinemaDetailFilmsScheduleDateModel : NSObject
@property (nonatomic, strong) NSDate *date;                     //日期
//@property (nonatomic, strong) NSDate *currentDate;      //当前的日期
@property (nonatomic, copy) NSString *showDate;                 //用于显示的转化日期文字(今天11月9日)
@property (nonatomic, copy) NSString *requestDate;              //用于请求的转化字段
@property (nonatomic, assign, getter=isSelect) BOOL select;           //是否选中

+ (instancetype)modelWithDate:(NSDate *)date andCurrentDate:(NSDate *)currentDate;

@end
