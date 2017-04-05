//
//  CCRequestModel.h
//  CloudCity
//
//  Created by Mac on 16/1/16.
//  Copyright © 2016年 Mac. All rights reserved.
//
// 请求参数的model

#import <Foundation/Foundation.h>
#import "CCHttpRequestEnum.h"

FOUNDATION_EXPORT NSString *const kRequestkey ;
 
@interface CCRequestModel : NSObject

@property (nonatomic,copy) NSString *urlString;    /**< 请求链接 */
@property (nonatomic,assign) int timeOut;          /**< 请求超时 默认为 30s */
@property (nonatomic, assign) HttpRequestType requestType;    /**< 请求类型 默认为 post*/
@property (nonatomic, strong) id parameters;                  /**< 请求参数 */
@property (nonatomic, assign) BOOL isRequest;       /**< 主动请求flag, 防止重复请求数据, YES - 不可请求, NO - 可以请求 */



@end
