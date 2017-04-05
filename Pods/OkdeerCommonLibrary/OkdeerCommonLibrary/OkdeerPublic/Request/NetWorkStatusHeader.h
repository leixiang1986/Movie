//
//  NetWorkStatusHeader.h
//  RequestFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//
// 网络状态的基础数据类

#ifndef NetWorkStatusHeader_h
#define NetWorkStatusHeader_h


static NSString *const kNetWorkToNoReachable     = @"NoReachable";         /**< 没有网络*/
static NSString *const kNetWorkToWifi            = @"Wifi";                 /**< wifi 网络*/
static NSString *const kNetWorkTo4G              = @"4G";                  /**< 4G 网络 */
static NSString *const kNetWorkTo3G              = @"3G";                  /**< 3G 网络*/
static NSString *const kNetWorkTo2G              = @"2G";                  /**< 2G 网络*/
static NSString *const kNetWorkToUnKnown         = @"unKnown";             /**< 未知 网络 */

static NSString *const kNetWorkStatusChangeNotification = @"netWorkStatusChangeNotification";    /**< 网络状态改变的通知 */
static NSString *const kMallIpChangeNotification = @"mallIpChangeNotification";             /**< 商城IP发生改变的通知 只有开启debug默认为发通知*/
static NSString *const kPropertyIpChangeNotification = @"propertyIpChangeNotification";     /**< 物业IP发生改变的通知 只有开启debug默认为发通知*/
static NSString *const kSellertIpChangeNotifiction = @"sellertIpChangeNotifiction";         /**< 商家IP发生改变的通知 只有开启debug默认为发通知*/
static NSString *const kAllIpChangeNotification = @"AllIpChangeNotification";               /**< 所有的IP发生变化的通知*/
#endif /* NetWorkStatusHeader_h */
