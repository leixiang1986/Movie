//
//  CCCrashHandler.m
//  CloudCity
//
//  Created by Mac on 15/12/21.
//  Copyright © 2015年 JuGuang. All rights reserved.
//

#import "CCCrashHandler.h"
#import "PublicHeader.h"
#import "OkdeerPublic.h"
#define kCloudCityCrash      @"okdeerLocationCrash"      // 保存的目录

@implementation CCCrashHandler
 
static void handleRootException( NSException* exception )
{
    
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; // 将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
 
    NSString *date = [CCUtility obtainTimeInterval];
    NSString *crashString = [NSString stringWithFormat:@"异常时间:%@\n %@\n%@\n%@",date,name,reason,symbols];
    NSLog(@"%@",crashString);
    NSString *crashPath = [CCCrashHandler obtainCrashPath];
    
    [crashString writeToFile:[NSString stringWithFormat:@"%@/%@.xml",crashPath,date] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

/**
 *  是否开启把错误日志保存到本地    默认不为开启
 */
+ (void)setLocalCrashReportEnabled:(BOOL)ret
{
    if (ret) {
        NSSetUncaughtExceptionHandler( &handleRootException );
        [self readCrashData];
    }else{
        [self cleanCrash];
    }
}
/**
 *  清除所有的错误日志
 */
+ (void)cleanCrash
{
    // 清空错误日志
    [CCUtility deleteFile:[self obtainCrashPath]];
}
/**
 *  获取错误日志的文件件
 */
+ (NSString *)obtainCrashPath
{
    NSString *cachePath = [CCUtility getCachePath];
    NSString *crashPath = [CCUtility  creatDirectoryRootPath:cachePath andDirectoryName:kCloudCityCrash];
    return crashPath;
}

/**
 *  读取错误日志
 */
+ (void)readCrashData
{
    dispatch_async(dispatch_queue_create("CrashQueue", NULL), ^{
        NSString *crashPath = [self obtainCrashPath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:crashPath];
        //列举目录内容，可以遍历子目录
        
        
        NSString *nextPath = @"";
        while((nextPath = [myDirectoryEnumerator nextObject] )!=nil)
            
        {
            if (nextPath && nextPath.length) {
                NSLog(@"%s---错误日志:--\n%@",__func__,[[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",crashPath,nextPath] encoding:NSUTF8StringEncoding error:nil]);
            }
        }
    });
    
 
}

@end
