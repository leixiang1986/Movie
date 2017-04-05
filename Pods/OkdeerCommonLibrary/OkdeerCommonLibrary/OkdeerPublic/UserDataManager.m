//
//  UserDataManager.m
//  PublicFrameworks
//
//  Created by Mac on 16/9/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UserDataManager.h"
#import "PublicHeader.h"
#import "OkdeerPublic.h"
#import <objc/runtime.h>
#import "CCCommonMyUserInfoModel.h"
#import "CCCommonLocationModel.h"


NSString *const kOkDeerLoginNotification = @"okDeerLoginNotification";            /**< 登录通知 */
NSString *const kOkDeerLogOutNotification = @"okDeerLogOutNotification";           /**< 退出登录通知 */
NSString *const kUserInforModel = @"KEY_USERINFORMODEL";                            /**< 获取usermodel*/
NSString *const kUserSelectAddress = @"KEY_ADDRESS";                                /**< 用户选择的地址 */
@interface UserDataManager ()

@property (nonatomic,copy) NSString *token;             /**< 登录token */
@property (nonatomic,copy) NSString *version;           /**< 版本号 */
@property (nonatomic,copy) NSString *deviceToken;       /**< iphoneToken */
@property (nonatomic,copy) NSString *versionCode;       /**< 升级code */
@property (nonatomic,assign,getter = isLogined) BOOL logined;               /**< 是否登录的字段 */
@property (nonatomic, assign, getter=isFirstLogin) BOOL firstLogin;        /**< 是否首次登录 */


@end

@implementation UserDataManager
#pragma mark - //****************** 初始化 ******************//
/**
 *  初始化
 */
+ (instancetype)shareManager{
    static UserDataManager *userDataManagaer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDataManagaer = [[UserDataManager alloc] init];
    });
    return userDataManagaer;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self obtainDefaultValue];
    }
    return self;
}


#pragma mark - //****************** private ******************//
/**
 *  获取默认的值
 */
- (void)obtainDefaultValue{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _logined = [_userDefaults boolForKey:KEY_LOGINED];
    _deviceToken =  [_userDefaults objectForKey:KEY_IPONETOKEN];
    _token = [_userDefaults objectForKey:KEY_TOKENINFOR];
 
    NSDictionary *infoDic = [CCUtility dictionaryFromInfoPlist]; 
    _version =  DicGetValueIsClass(infoDic, @"ShowVersion", kString);
    _versionCode = DicGetValueIsClass(infoDic, @"VersionCode", kString);
    
    _userInfo = [CCCommonMyUserInfoModel userInfo];
    _locationInfo = [CCCommonLocationModel locationInfo];
    
    _firstLogin = [_userDefaults boolForKey:KEY_FIRSTLOGIN];
}

- (void)saveToken:(NSString *)token{
    _token = token;
    [_userDefaults setObject:_token forKey:KEY_TOKENINFOR];
    [_userDefaults synchronize];
}

/**
 *  是否登录的字段
 *
 *  @param logined 是否登录的字段
 */
- (void)saveLogined:(NSString *)logined{
   
    logined = GetStringToValue(logined);
    BOOL loging = logined.boolValue;
    BOOL needSendNotification =  _logined != loging ? YES : NO;
    _logined = loging;
    [_userDefaults setBool:_logined forKey:KEY_LOGINED];
    [_userDefaults synchronize];
    if (needSendNotification) {
        if (loging) {
            [self sendLoginNotification];
        }else{
            [self sendLogOutNotification];
        }
    }
    
}

/**
 *  是否登录的字段
 *
 *  @param firstLogin 是否登录的字段
 */
- (void)saveFirstLogin:(NSString *)firstLogin{

    _firstLogin = firstLogin.boolValue;
    [_userDefaults setBool:_firstLogin forKey:KEY_FIRSTLOGIN];
    [_userDefaults synchronize];
}


/**
 *  保存iphoneToken
 *
 *  @param deviceToken iphoneToken
 */
- (void)saveDeviceToken:(NSString *)deviceToken{
    _deviceToken = deviceToken;
    [_userDefaults setObject:_deviceToken forKey:KEY_IPONETOKEN];
    [_userDefaults synchronize];
}

/**
 *  是否首次注册后的登录
 *
 *  @return yes 为首次
 */
- (BOOL)isFirstLogin {
    return _firstLogin;
}

/**
 *  保存版本号
 *
 *  @param version 版本号
 */
- (void)saveVersion:(NSString *)version{
    _version = version;
}
/**
 *  保存升级code
 *
 *  @param versionCode 升级code
 */
- (void)saveVersionCode:(NSString *)versionCode{
    _versionCode = versionCode;
}

/**
 *  发送登录的通知
 */
- (void)sendLoginNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kOkDeerLoginNotification object:nil];
    CCLog(@"login........");
}
/**
 *  发送退出登录的通知
 */
- (void)sendLogOutNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kOkDeerLogOutNotification object:nil];
        CCLog(@"logout........");
}


#pragma mark - //****************** public ******************//
/**
 *  获取用户登录账户
 */
- (NSString *)selectFromUserAccound{
    return GetStringToValue(_userInfo.phone);
}
/**
 *  获取用户Id
 */
- (NSString *)selectFromUserId{
    return GetStringToValue(_userInfo.userId);
}
/**
 *  获取登录token
 */
- (NSString *)selectFromToken{
    return GetStringToValue(_token);
}
/**
 *  获取版本号 带V的
 */
- (NSString *)selectFromVersion{
    return GetStringToValue(_version);
}
/**
 *  获取升级的code
 */
- (NSString *)selectFromVersionCode{
    return GetStringToValue(_versionCode);
}
/**
 *  获取手机的iphoneToken
 */
- (NSString *)selectFromDeviceToken{
    return GetStringToValue(_deviceToken);
}
/**
 *  是否登录状态中
 *
 *  @return yes 为登录状态中  no 为不是登录中
 */
- (BOOL)isLogin{
    return _logined;
}

/**
 *  登录后的用户信息
 */
- (CCCommonMyUserInfoModel *)userInfo {
    return [CCCommonMyUserInfoModel userInfo];
}

/**
 *  首页定位获取或用户选择的地址信息
 */
- (CCCommonLocationModel *)locationInfo {
    return [CCCommonLocationModel locationInfo];
}


NSString *const KEY_TOKENINFOR = @"KEY_TOKENINFOR";                 /**< 验证是否为效 登录返回 */
NSString *const KEY_LOGINED = @"KEY_ISLOGINED";                    /**< 是否登录 */
NSString *const KEY_IPONETOKEN = @"KEY_IPONETOKEN";                 /**< iPhoneToken */
NSString *const KEY_FIRSTLOGIN = @"KEY_FIRSTLOGIN";                 /**< firstLogin */

@end
