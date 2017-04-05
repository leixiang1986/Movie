//
//  CCCrashHandler.h
//  CloudCity
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 JuGuang. All rights reserved.
//
/**
 *   捕捉异常情况的
 */
#import <Foundation/Foundation.h>

@interface CCCrashHandler : NSObject
/**
 *  是否开启把错误日志保存到本地    默认不为开启
 */
+ (void)setLocalCrashReportEnabled:(BOOL)ret;
/**
 *  读取错误日志
 */
+ (void)readCrashData;

@end
