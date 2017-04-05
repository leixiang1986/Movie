//
//  CCSendHttpRequest.h
//  Donghua
//
//  Created by Mac on 16/1/11.
//  Copyright © 2016年 Mac. All rights reserved.
//
// 调用请求的类

#import <Foundation/Foundation.h>
#import "CCHttpRequestEnum.h"
@class CCSendHttpRequest,CCRequestModel;

typedef void(^SuccessBlock)(CCSendHttpRequest *sendHttpRequest,id response,NSDictionary *info);
typedef void(^FailureBlock)(CCSendHttpRequest *sendHttpRequest,HttpRequestError httpRequestError,NSError *error,NSDictionary *info);
typedef void(^HttpRequestBlock)(CCSendHttpRequest *sendHttpRequest);

@interface CCSendHttpRequest : NSObject

/**
 *   发起请求  传入model
 */
- (void)httpRequestModel:(CCRequestModel *) requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
/**
 *  取消请求
 */
- (void)canceRequest;

@end
