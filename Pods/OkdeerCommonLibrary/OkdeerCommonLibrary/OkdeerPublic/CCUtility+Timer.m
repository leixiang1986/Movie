//
//  CCUtility+Timer.m
//  PublicFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCUtility+Timer.h"

@implementation CCUtility (Timer)

/**
 *  倒计时  每一秒执行一次
 */
+ (dispatch_source_t)countdownWithTimeOut:(int)timeOut run:(RunBlock)runBlock completion:(FinishCompletionBlock)completion
{
    __block int surplusSecond = timeOut;
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_source_t _timer = [self obtainTimerWithEvenHandler:^(dispatch_source_t timer) {
        if (surplusSecond <= 0 ) {
            dispatch_source_cancel(timer);
            dispatch_async(mainQueue, ^{
                if (completion) {
                    completion();
                }
            });
        }else{
            surplusSecond -- ;
            dispatch_async(mainQueue, ^{
                if (runBlock) {
                    runBlock(surplusSecond,timer);
                }
            });
        }
    }];
    
    return _timer;
}

/**
 *  倒计时  根据  interval  多久执行一次  最低是0.1
 */
+ (dispatch_source_t)countdownWithTimeOut:(double)timeOut interval:(double)interval run:(RunIntervalBlock)runBlock completion:(FinishCompletionBlock)completion
{
    if (interval < 0.1) {
        interval = 0.1;
    }
    __block double surplusSecond = timeOut;
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_source_t _timer = [self obtainTimerWithInterval:interval evenHandler:^(dispatch_source_t timer) {
        
        if (surplusSecond < 0.1 ) {
            dispatch_source_cancel(timer);
            dispatch_async(mainQueue, ^{
                if (completion) {
                    completion();
                }
            });
        }else{
            
            dispatch_async(mainQueue, ^{
                surplusSecond = surplusSecond - interval ;
                if (runBlock) {
                    runBlock(surplusSecond,timer);
                }
            });
        }
    }];
    return _timer;
}

/**
 *  计时
 */
+ (dispatch_source_t)timingWithRun:(RunBlock)runBlock
{
    __block int second = 0;
    dispatch_source_t _timer = [self obtainTimerWithEvenHandler:^(dispatch_source_t timer) {
        second ++ ;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (runBlock) {
                runBlock(second,timer);
            }
        });
    }];
    return _timer;
}
/**
 *  计时   有最大的值
 */
+ (dispatch_source_t)timingWithMaxTimeOut:(int)maxTimeOut run:(RunBlock)runBlock completion:(FinishCompletionBlock)completion
{
    __block int surplusSecond = maxTimeOut;
    __block int second = 0 ;
    
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_source_t _timer = [self obtainTimerWithEvenHandler:^(dispatch_source_t timer) {
        if (second >= surplusSecond) {
            dispatch_source_cancel(timer);
            dispatch_async(mainQueue, ^{
                if (completion) {
                    completion();
                }
            });
            
        }else{
            second ++ ;
            dispatch_async(mainQueue, ^{
                if (runBlock) {
                    runBlock(second,timer);
                }
            });
        }
    }];
    return _timer;
}

+ (dispatch_source_t)obtainTimerWithEvenHandler:(void(^)(dispatch_source_t timer))evenHangBlock
{
    return [self obtainTimerWithInterval:1.0 evenHandler:evenHangBlock];
}

+ (dispatch_source_t)obtainTimerWithInterval:(double)interval evenHandler:(void(^)(dispatch_source_t timer))evenHangBlock
{
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //定时循环执行事件
    //dispatch_source_set_timer 方法值得一提的是最后一个参数（leeway），他告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器每5秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每10分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。他的意义在于降低资源消耗。
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{ //计时器事件处理器
        
        dispatch_async(mainQueue, ^{
            if (evenHangBlock) {
                evenHangBlock(_timer);
            }
        });
    });
    dispatch_source_set_cancel_handler(_timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
        
    });
    dispatch_resume(_timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
    return _timer;
}

@end
