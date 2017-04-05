//
//  CCFilmOrderDetailModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/17.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCFilmOrderTypeModel.h"

//电影订单详情的model
@interface CCFilmOrderDetailModel : NSObject
//电影票
@property (nonatomic, copy) NSString *filmName;             /**< 电影名称 */
@property (nonatomic, copy) NSString *room;                 /**< 厅 */
@property (nonatomic, copy) NSString *time;                 /**< 电影的播放时段 */
@property (nonatomic, copy) NSString *seats;                /**< 座位的数组拼接 */
@property (nonatomic, strong) CCFilmOrderTypeModel *state;  /**< 订单状态 */
@property (nonatomic, copy) NSString *tips;                 /**< 取票失败或出票中的提示信息 */

//取票码
@property (nonatomic, copy) NSString *obtainCode;           /**< 取票码 */
@property (nonatomic, copy) NSString *obtainOrderId;        /**< 取票订单id */
@property (nonatomic, copy) NSString *obtainThirdId;        /**< 取票第三方id */
@property (nonatomic, copy) NSString *obtainTips; /**< 取票码的提示信息 */

//订单信息
@property (nonatomic, copy) NSString *phone;                /**< 电话号码 */
@property (nonatomic, copy) NSString *orderId;              /**< 订单id */
@property (nonatomic, copy) NSString *totalPay;             /**< 总金额 */
@property (nonatomic, copy) NSString *preferential;         /**< 优惠金额 */
@property (nonatomic, copy) NSString *paymentAmount;        /**< 应付金额 */

//影院信息
@property (nonatomic, copy) NSString *cinemaName;           /**< 影院名字 */
@property (nonatomic, copy) NSString *address;              /**< 地址 */
@property (nonatomic, copy) NSString *cinemaPhone;          /**< 影院联系电话 */

@end
