//
//  CCHttpRequestUrlManager.m
//  RequestFrameworks
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCHttpRequestUrlManager.h"
#import "OkdeerPublic.h"
#import "PublicToolManager.h"
/**
 *  获取域名时  默认是先获取本地的域名  接下来是获取是否可以获取服务器返回的域名  在接下来就是获取是否为debug 模式下的
 */


@interface CCHttpRequestUrlManager ()
// 默认的
@property (nonatomic,copy) NSString *mallPrefixUrl;             /**< 默认 商城域名 */
@property (nonatomic,copy) NSString *propertyPrefixUrl;         /**< 默认 物业域名  */
@property (nonatomic,copy) NSString *sellerPrefixUrl;           /**< 默认 商家app域名  */
@property (nonatomic,copy) NSString *updatePrefixUrl;           /**< 默认 update域名*/

// debug
@property (nonatomic,copy) NSString *debugMallPrefixUrl;        /**< debug 商城域名 */
@property (nonatomic,copy) NSString *debugPropertyPrefixUrl;    /**< debug 物业域名  */
@property (nonatomic,copy) NSString *debugSellerPrefixUrl;      /**< debug 商家app域名  */
// serves
@property (nonatomic,copy) NSString *servesMallPrefixUrl;       /**< 服务器 商城域名*/
@property (nonatomic,copy) NSString *servesPropertyPrefixUrl;   /**< 服务器 物业域名*/
@property (nonatomic,copy) NSString *servesSellerPrefixUrl;     /**< 服务器 商家app域名*/

@property (nonatomic,copy) NSString *updateUrl;                 /**< 更新地址*/


@end

@implementation CCHttpRequestUrlManager

/**
 *  初始化
 */
+ (instancetype)shareManager{
    static CCHttpRequestUrlManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CCHttpRequestUrlManager alloc] init];
    });
    return manager;
}

/**
 * 保存 默认的商城的域名
 */
- (void)saveDefauleMallPrefixUrl:(NSString *)mallPrefixUrl{
    _mallPrefixUrl = mallPrefixUrl;
}
/**
 *  保存  默认物业的域名
 */
- (void)saveDefaulePropertyPrefixUrl:(NSString *)propertyPrefixUrl{
    _propertyPrefixUrl = propertyPrefixUrl;
}
/**
 *  保存  默认商家App的域名
 */
- (void)saveDefauleSellerPrefixUrl:(NSString *)sellerPrefixUrl{
    _sellerPrefixUrl = sellerPrefixUrl;
}
/**
 *  保存  默认的update的域名
 */
- (void)saveDefauleUpdatePrefixUrl:(NSString *)updatePrefixUrl{
    _updatePrefixUrl = updatePrefixUrl;
}
/**
 * 保存更新的地址
 */
- (void)saveUpdateUrl:(NSString *)updateUrl{
    _updateUrl = updateUrl;
}
/**
 *  获取商城的域名
 */
- (NSString *)selectFromMallPrefixUrl{
    NSString *urlPath = _mallPrefixUrl;
    if ([PublicToolManager getSettingOfServes] && StringGetLength(_servesMallPrefixUrl)) {
        urlPath = _servesMallPrefixUrl;
    }
    
    if ([PublicToolManager getSettingOfDebug] && StringGetLength(_debugMallPrefixUrl)) {
        urlPath = _debugMallPrefixUrl;
    }
    return GetStringToValue(urlPath);
}
/**
 *  获取物业的域名
 */
- (NSString *)selectFromPropertyPrefixUrl{
    NSString *urlPath = _propertyPrefixUrl;
    if ([PublicToolManager getSettingOfServes] && StringGetLength(_servesPropertyPrefixUrl)) {
        urlPath = _servesPropertyPrefixUrl;
    }
    if ([PublicToolManager getSettingOfDebug] &&  StringGetLength(_debugPropertyPrefixUrl)) {
        urlPath = _debugPropertyPrefixUrl;
    }
    return  GetStringToValue(urlPath);
}
/**
 *  获取商家的域名
 */
- (NSString *)selectFromSellerPrefixUrl{
    NSString *urlPath = _sellerPrefixUrl;
    if ([PublicToolManager getSettingOfServes] && StringGetLength(_servesSellerPrefixUrl)) {
        urlPath = _servesSellerPrefixUrl;
    }
    if ([PublicToolManager getSettingOfDebug] && StringGetLength(_debugSellerPrefixUrl)) {
        urlPath = _debugSellerPrefixUrl;
    }
    return GetStringToValue(urlPath);
}
/**
 * 获取Update的域名
 */
- (NSString *)selectFromUpdatePrefixUrl{
    return GetStringToValue(_updatePrefixUrl);
}
/**
 * 获取更新地址
 */
- (NSString *)selectFromUpdateUrl{
    return GetStringToValue(_updateUrl); 
}
/**
 *  保存 手动更改商城的域名
 */
- (void)saveDebugMallPrefixUrl:(NSString *)debugMallPrefixUrl{
    _debugMallPrefixUrl = debugMallPrefixUrl;
}
/**
 *  保存 手动更改物业的域名
 */
- (void)saveDebugPropertyPrefixUrl:(NSString *)debugPropertyPrefixUrl{
    _debugPropertyPrefixUrl = debugPropertyPrefixUrl;
}
/**
 *  保存 手动更改商家的域名
 */
- (void)saveDebugSellerPrefixUrl:(NSString *)debugSellerPrefixUrl{
    _debugSellerPrefixUrl = debugSellerPrefixUrl; 
}
/**
 * 保存 服务器返回商城的域名
 */
- (void)saveServesMallPrefixUrl:(NSString *)servesMallPrefixUrl{
    _servesMallPrefixUrl = servesMallPrefixUrl;
}
/**
 * 保存 服务器返回物业的域名
 */
- (void)saveServesPropertyPrefixUrl:(NSString *)servesPropertyPrefixUrl{
    _servesPropertyPrefixUrl = servesPropertyPrefixUrl;
}
/**
 * 保存 服务器返回商家的域名
 */
- (void)saveServesSellerPrefixUrl:(NSString *)servesSellerPrefixUrl{
    _servesSellerPrefixUrl = servesSellerPrefixUrl;
}
@end
