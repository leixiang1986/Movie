//
//  CCCommonLocationModel.h
//  OkdeerUser
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  首页选择的地址\定位的地址
 */
@interface CCCommonLocationModel : NSObject

@property (nonatomic,copy) NSString *locationName;  /**< 定位到的地址名 */
@property (nonatomic,copy) NSString *locationCode;   /**< 若用户选择的是YSC小区,则是小区编号 */
@property (nonatomic,copy) NSString *locationAddress;                /**< 定位到的详细地址 */
@property (nonatomic,assign)double latitude;                    /**< 用户定位的坐标-纬度 */
@property (nonatomic,assign)double longitude;                /**< 用户定位的坐标-经度 */
@property (nonatomic,copy) NSString *city;                      /**< 用户定位到的当前城市(有可能是后台\或手动切换的城市) */
@property (nonatomic,copy) NSString *province;            /**< 用户定位到的当前省 */
@property (nonatomic,copy) NSString *area;                  /**< 用户定位到的当前区 */
@property (nonatomic,copy) NSString *locationPhone;    /**< 若用户选择的是YSC小区, 为小区的服务电话 */
@property (nonatomic, copy) NSString *locatedCity;          /**< 百度定位的当前城市 */

/**
 *  首页选择的地址\定位的地址
 */
+ (instancetype)locationInfo;

@end
