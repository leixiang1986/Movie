//
//  CCHttpRequest.h
//  RequestFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//
// 请求基础类

#import <Foundation/Foundation.h>
#import "CCHttpRequestEnum.h"
#import "CCHttpRequestUrlHeader.h"

@class CCRequestModel,CCSendHttpRequest;

typedef void(^FaileTypeBlock)(NSString *code,HttpRequestError httpRequestError,NSString *msg,NSDictionary *info,id objc);   /**< 失败block code 错误编码 httpRequestError 请求失败的 msg 请求失败提示语 info 请求体的（当前请求回来网络时间）objc  扩展属性 */
typedef void(^HttpRequestBlock)(CCSendHttpRequest *sendHttpRequest);     /**< 请求对象 block */
typedef void(^UpDataVersionSuccessBlock)(id responseObject);       /**< 获取版本数据成功 */
typedef void(^UploadTokenSuccessBlock)(NSString *token);            /**< 获取 上传的token 成功 */

#define HTTP_FOR_UPLOADTOKEN_URL      StringAppend(HTTP_MALLPrefix_URL,@"/common/fileUploadToken")  // 获取上传的token

@interface CCHttpRequest : NSObject

/**
 *  请求失败的处理回调
 */
+ (void)requestFailureBlock:(FaileTypeBlock)faileBlock message:(NSString *)message code:(NSString *)code httpRequestError:(HttpRequestError) httpRequestError info:(NSDictionary *)info objc:(id)objc;
/**
 *  请求对象回调
 */
+ (void)requestHttpRequestBlock:(HttpRequestBlock)httpRequestBlock httpRequest:(CCSendHttpRequest *)httpRequest;

/**
 *   请求更新版本
 */
+ (void)requestUpdateVersion:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(UpDataVersionSuccessBlock)versionBlock;
/**
 *  请求获取上传七牛图片的token
 */
+ (void)requestUploadImageToken:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(UploadTokenSuccessBlock)uploadSuccessBlock failure:(FaileTypeBlock)failureBlock;

@end
