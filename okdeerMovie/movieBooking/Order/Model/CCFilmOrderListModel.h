//
//  CCFilmOrderListModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFilmOrderListModel : NSObject
@property (nonatomic, copy) NSString *cinemaName;       /**< 影院名字 */
@property (nonatomic, copy) NSString *orderState;       /**< 订单状态 */
@property (nonatomic, copy) NSString *image;            /**< 图片 */
@property (nonatomic, copy) NSString *filmName;         /**< 影片名字 */
@property (nonatomic, copy) NSString *time;             /**< 开始时间 */
@property (nonatomic, copy) NSString *room;             /**< 厅 */
@property (nonatomic, copy) NSString *seats;            /**< 座位 */
@property (nonatomic, copy) NSString *price;            /**< 价格 */
@end
