//
//  PublicToolManager.h
//  PublicFrameworks
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//
/**
 *  获取PublicToolInfo.list 的状态
 */
#import <Foundation/Foundation.h>

@interface PublicToolManager : NSObject
/**
 *  是否是调试状态（是否可以设置ip）
 *
 *  @return  BOOL
 */
+ (BOOL)getSettingOfDebug;
/**
 *  是否开启第三方崩溃日志
 *
 *  @return BOOL
 */
+ (BOOL)getSettingOfThirdPartCrash;
/**
 *  是否开启本地崩溃日志
 *
 *  @return BOOL
 */
+ (BOOL)getSettingOfLocalCrash;
/**
 * 是否可以获取服务器的IP
 */
+ (BOOL)getSettingOfServes;

@end
