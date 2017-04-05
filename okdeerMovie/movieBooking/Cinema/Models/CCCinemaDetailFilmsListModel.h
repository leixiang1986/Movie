//
//  CCCinemaDetailFilmsListModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
//电影院详情中电影排期列表中的电影model
@interface CCCinemaDetailFilmsListModel : NSObject
@property (nonatomic,copy) NSString *startTime;         /**< 开始时间 */
@property (nonatomic,copy) NSString *endTime;           /**< 结束时间 */
@property (nonatomic,copy) NSString *filmType;          /**< 电影类型 */
@property (nonatomic,copy) NSString *roomType;          /**< 厅类型 */
@property (nonatomic,copy) NSString *price;             /**< 价格 */
@property (nonatomic,copy) NSString *oldPrice;          /**< 原价 */
@property (nonatomic,copy) NSString *preferentialMsg;   /**< 优惠信息 */
@property (nonatomic,assign) BOOL canBuy;               /**< 是否可以购买 */

@end
