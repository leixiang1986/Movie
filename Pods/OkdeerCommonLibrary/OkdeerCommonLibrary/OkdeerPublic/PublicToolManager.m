//
//  PublicToolManager.m
//  PublicFrameworks
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "PublicToolManager.h"

@implementation PublicToolManager
/**
 *  是否是调试状态（是否可以设置ip）
 *
 *  @return
 */
+ (BOOL)getSettingOfDebug {
    NSDictionary *dic = [self getSettingDic];
    BOOL isDebug = [(NSNumber *)dic[@"Debug"] boolValue];
    return isDebug;
}

/**
 *  是否开启第三方崩溃日志
 *
 *  @return
 */
+ (BOOL)getSettingOfThirdPartCrash {
    NSDictionary *dic = [self getSettingDic];
    return [(NSNumber *)dic[@"ThirdPartCrach"] boolValue];
}

/**
 *  是否开启本地崩溃日志
 *
 *  @return
 */
+ (BOOL)getSettingOfLocalCrash {
    NSDictionary *dic = [self getSettingDic];
    return [(NSNumber *)dic[@"LocalCrach"] boolValue];
}
/**
 * 是否可以获取服务器的IP
 */
+ (BOOL)getSettingOfServes{
    NSDictionary *dic = [self getSettingDic];
    return [(NSNumber *)dic[@"ServicesUrl"] boolValue];
}
/**
 *  得到设置的数据字典
 *
 *  @return 数据字典
 */
+ (NSDictionary *)getSettingDic {
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent: @"PublicToolInfo.plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:finalPath];
    return dictionary;
}

@end
