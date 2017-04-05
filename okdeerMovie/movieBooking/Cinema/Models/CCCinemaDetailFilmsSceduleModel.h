//
//  CCCinemaDetailFilmsSceduleModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

typedef NS_ENUM(NSInteger, FilmsSceduleDataType) {
    FilmsSceduleDataTypeWithData,         //有数据
    FilmsSceduleDataTypeRequestNoData,    //请求失败
    FilmsSceduleDataTypeSellOut,          //卖完
    FilmsSceduleDataTypeNoSchedule,       //没有安排
    FilmsSceduleDataTypeComingMovie       //未上映
};

#import <Foundation/Foundation.h>
#import "CCCinemaDetailFilmsListModel.h"


//排片信息,组装请求的排片信息，用于展示
@interface CCCinemaDetailFilmsSceduleModel : NSObject
@property (strong, nonatomic) NSDate *currentDate;  //当前日期
@property (strong, nonatomic) NSDate *selectDate;   //选中的日期
@property (strong, nonatomic) NSArray *dateList;    //日期列表
@property (strong, nonatomic) NSArray <CCCinemaDetailFilmsListModel *>*filmList;    //当前选中日期排期影片列表
@property (assign, nonatomic) FilmsSceduleDataType dataType;            /**< 有没有数据的类型 */
@property (strong, nonatomic) NSString *tips;                               /**< 优惠提示信息 */
@end
