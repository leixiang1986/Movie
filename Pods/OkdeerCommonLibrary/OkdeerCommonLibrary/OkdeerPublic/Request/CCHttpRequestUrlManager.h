//
//  CCHttpRequestUrlManager.h
//  RequestFrameworks
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//
//  URL管理类

#import <Foundation/Foundation.h>

@interface CCHttpRequestUrlManager : NSObject
/**
 *  初始化
 */
+ (instancetype)shareManager;
/**
 * 保存 默认的商城的域名
 */
- (void)saveDefauleMallPrefixUrl:(NSString *)mallPrefixUrl;
/**
 *  保存  默认物业的域名
 */
- (void)saveDefaulePropertyPrefixUrl:(NSString *)propertyPrefixUrl;
/**
 *  保存  默认商家App的域名
 */
- (void)saveDefauleSellerPrefixUrl:(NSString *)sellerPrefixUrl;
/**
 *  保存  默认的update的域名
 */
- (void)saveDefauleUpdatePrefixUrl:(NSString *)updatePrefixUrl;
/**
 * 保存更新的地址
 */
- (void)saveUpdateUrl:(NSString *)updateUrl;

/**
 *  获取商城的域名
 */
- (NSString *)selectFromMallPrefixUrl;
/**
 *  获取物业的域名
 */
- (NSString *)selectFromPropertyPrefixUrl;
/**
 *  获取商家的域名
 */
- (NSString *)selectFromSellerPrefixUrl;
/**
 * 获取Update的域名
 */
- (NSString *)selectFromUpdatePrefixUrl;
/**
 * 获取更新地址
 */
- (NSString *)selectFromUpdateUrl;

/**
 *  保存 手动更改商城的域名
 */
- (void)saveDebugMallPrefixUrl:(NSString *)debugMallPrefixUrl;
/**
 *  保存 手动更改物业的域名
 */
- (void)saveDebugPropertyPrefixUrl:(NSString *)debugPropertyPrefixUrl;
/**
 *  保存 手动更改商家的域名
 */
- (void)saveDebugSellerPrefixUrl:(NSString *)debugSellerPrefixUrl;
/**
 * 保存 服务器返回商城的域名
 */
- (void)saveServesMallPrefixUrl:(NSString *)servesMallPrefixUrl;
/**
 * 保存 服务器返回物业的域名
 */
- (void)saveServesPropertyPrefixUrl:(NSString *)servesPropertyPrefixUrl;
/**
 * 保存 服务器返回商家的域名
 */
- (void)saveServesSellerPrefixUrl:(NSString *)servesSellerPrefixUrl;

@end
