//
//  UserDataManager.h
//  PublicFrameworks
//
//  Created by Mac on 16/9/6.
//  Copyright © 2016年 Mac. All rights reserved.
//
/**
 *  用户信息的类
 */
#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const kOkDeerLoginNotification;            /**< 登录通知 */
FOUNDATION_EXPORT NSString *const kOkDeerLogOutNotification;           /**< 退出登录通知 */
FOUNDATION_EXPORT NSString *const kUserInforModel;                     /**< 获取usermodel*/
FOUNDATION_EXPORT NSString *const kUserSelectAddress;                  /**< 用户选择的地址*/

@class  CCCommonMyUserInfoModel, CCCommonLocationModel;

@interface UserDataManager : NSObject
@property (nonatomic,strong,readonly) NSUserDefaults *userDefaults;
@property (nonatomic, strong) CCCommonMyUserInfoModel *userInfo;                   /**< 登录后的用户信息 */
@property (nonatomic, strong) CCCommonLocationModel *locationInfo;                  /**< 首页定位获取或用户选择的地址信息 */


/**
 *  初始化
 */
+ (instancetype)shareManager;
/**
 *  获取用户登录账户
 */
- (NSString *)selectFromUserAccound;
/**
 *  获取用户Id
 */
- (NSString *)selectFromUserId;
/**
 *  获取登录token
 */
- (NSString *)selectFromToken;
/**
 *  获取版本号 带V的
 */
- (NSString *)selectFromVersion;
/**
 *  获取升级的code
 */
- (NSString *)selectFromVersionCode;
/**
 *  获取手机的iphoneToken
 */
- (NSString *)selectFromDeviceToken;

/**
 *  是否登录状态中
 *
 *  @return yes 为登录状态中  no 为不是登录中 
 */
- (BOOL)isLogin;
/**
 *  保存iphoneToken
 *
 *  @param deviceToken iphoneToken
 */
- (void)saveDeviceToken:(NSString *)deviceToken;

/**
 *  是否首次注册后的登录
 *
 *  @return yes 为首次
 */
- (BOOL)isFirstLogin;
@end
