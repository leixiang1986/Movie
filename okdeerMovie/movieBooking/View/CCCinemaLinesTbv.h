//
//  CCCinemaLinesTbv.h
//  okdeerMovie
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMKTransitRouteLine;
@class BMKDrivingRouteLine;
@class BMKWalkingRouteLine;

typedef NS_ENUM(NSInteger, CinemaLineType) {
    CinemaLineType_bus = 100,   /**< 公交车 */
    CinemaLineType_car,     /**< 汽车 */
    CinemaLineType_walk,        /**< 步行 */
};

@interface CCCinemaLinesTbv : UITableView

// --- 获取对应的路线
- (void)requestData:(CinemaLineType)lineType;

@property (nonatomic, copy) void (^cinemaLineBlock)(CinemaLineType lineType, BMKTransitRouteLine *transLine, BMKDrivingRouteLine *driveline, BMKWalkingRouteLine *walkline);

@end
