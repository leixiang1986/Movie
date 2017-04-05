//
//  RequestMessageTip.h
//  OkdeerUser
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 okdeer. All rights reserved.
//
// 提示信息
#import <Foundation/Foundation.h>
#import "CCHttpRequestEnum.h"


static NSInteger const kMessageTipTime = 3 ;   /**< 消息弹出框的时间 */


@interface RequestMessageTip : NSObject

/**
 *  获取请求错误信息 根据后台的code提示
 *
 *  @param msg          后台的提示信息
 *  @param code         后台对应的code
 *  @param requestError 请求错误码
 *  @param localMsg     本地的提示信息   只有code小于规定的值 或大于的值就会提示这个或msg为空
 *
 *  @return 错误信息
 */
NSString * obtainRequestErrMsg(NSString *msg,NSString *code,HttpRequestError requestError,NSString *localMsg);

/**
*   提示请求错误信息  根据后台的code提示
*
*  @param msg          后台的提示信息
*  @param code          后台对应的code
*  @param requestError 请求错误码
*  @param localMsg     本地的提示信息   只有code小于规定的值 或大于的值就会提示这个或msg为空
*/
void showRequestErrMsgTip(NSString *msg,NSString *code,HttpRequestError requestError,NSString *localMsg);
/**
 *  提示信息
 */
void showMessageTip(NSString *msg);

@end
