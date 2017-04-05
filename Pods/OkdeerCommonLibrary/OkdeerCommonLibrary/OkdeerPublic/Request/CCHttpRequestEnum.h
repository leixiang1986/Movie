//
//  CCHttpRequestEnum.h
//  CloudProperty
//
//  Created by huangshupeng on 15/5/30.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//
// 请求类对应的枚举的

#ifndef CloudProperty_CCHttpRequestEnum_h
#define CloudProperty_CCHttpRequestEnum_h

static NSString *const kRequestSuccessStatues   = @"0";                 /**< 请求成功的标志 */
static NSString *const kServiceErrorStatues     = @"9";                 /**< 请求失败的标志 */
static NSString *const kRequestCodeKey          = @"code";              /**< 请求code 的key */
static NSString *const kRequestMessageKey       = @"message";           /**< 请求message 的key */
static NSString *const kRequestDataKey          = @"data";              /**< 请求data 的key */
static NSString *const kRequestListkey          = @"list";              /**< 请求list 的key */
static NSInteger const kRequestTipsStatuesMin   = 200;                  /**< 提示后台的code最小值 */
static NSInteger const kRequestTipsStatuesMax   = 500;                  /**< 提示后台的code最大值 */
static NSString *const kLoginFail               = @"4" ;                /**< 登录失效 */
static NSString *const kTokenExpiry             = @"TOKENEXPIRY";       /**< token实效的通知名称 */


typedef NS_ENUM(NSUInteger,HttpRequestType) {
    HttpRequestTypePOST = 0 ,         /**< post 请求 */
    HttpRequestTypeGET   ,            /**< get 请求 */
    HttpRequestTypeHEAD  ,            /**< head 请求 */
    HttpRequestTypePUT   ,            /**< put 请求 */
};/**< 请求类型 */

typedef NS_ENUM(NSUInteger,HttpRequestError) {
    HttpRequestSuccess =0,                  /**< 请求成功 */
    HttpRequestErrorTimeOut,       /**< 网络超时 */
    HttpRequestErrorService  ,          /**< 服务器报错 */
    HttpRequestErrorNoNetWork  ,        /**< 没有网络 */
    HttpRequestErrorNoData ,            /**< 没有数据 */
}; /**< 请求的错误码 */


#endif
