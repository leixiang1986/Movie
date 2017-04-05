//
//  CCUtility+Timer.h
//  PublicFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//
// gcd 定时器
#import "CCUtility.h"

typedef void(^RunBlock)(int time, dispatch_source_t timer);     /**< 定时器 每一秒  运行中 */
typedef void(^RunIntervalBlock)(double time,dispatch_source_t timer);   /**< 定时器 interval  运行中 */
typedef void(^FinishCompletionBlock)(void);                     /**< 定时器 结束 */

@interface CCUtility (Timer)
/**
 *  倒计时    每一秒执行一次
 */
+ (dispatch_source_t)countdownWithTimeOut:(int)timeOut run:(RunBlock)runBlock completion:(FinishCompletionBlock)completion;
/**
 *  倒计时  根据  interval  多久执行一次  最低是0.1
 */
+ (dispatch_source_t)countdownWithTimeOut:(double)timeOut interval:(double)interval run:(RunIntervalBlock)runBlock completion:(FinishCompletionBlock)completion;

/**
 *  计时   每一秒执行一次
 */
+ (dispatch_source_t)timingWithRun:(RunBlock)runBlock;
/**
 *  计时    每一秒执行一次   有最大的值
 */
+ (dispatch_source_t)timingWithMaxTimeOut:(int)maxTimeOut run:(RunBlock)runBlock completion:(FinishCompletionBlock)completion;
@end
