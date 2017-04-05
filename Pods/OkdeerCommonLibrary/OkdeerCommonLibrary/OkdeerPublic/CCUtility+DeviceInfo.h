//
//  CCUtility+DeviceInfo.h
//  PublicFrameworks
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 Mac. All rights reserved.
//
// 获取设备信息

#import "CCUtility.h"

@interface CCUtility (DeviceInfo)
/**
 *  获取设备型号
 */
+ (NSString*)obtainDevicePlatform;
/**
 *  获取 手机版本
 */
+ (NSString *)obtainSystemVersion;
/**
 *  获取 屏幕像素
 */
+ (NSString *)obtainScreen;
/**
 *  获取 uuid  唯一标识
 */
+ (NSString *)obtainUUID;
/**
 *  获取IP地址
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
/**
 *  获取IP地址信息
 */
+ (NSDictionary *)getIPAddresses;
@end
