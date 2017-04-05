//
//  RequestMessageTip.m
//  OkdeerUser
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "RequestMessageTip.h"
#import <UIKit/UIKit.h>


@implementation RequestMessageTip





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
NSString * obtainRequestErrMsg(NSString *msg,NSString *code,HttpRequestError requestError,NSString *localMsg){
    NSString *requestMsg = localMsg;
    if (requestError == HttpRequestErrorNoNetWork) {
        requestMsg = @"网络不可用，请检查您的网络设置；";
    }else{
        if (msg && msg.length && [code integerValue] >= kRequestTipsStatuesMin && [code integerValue] <= kRequestTipsStatuesMax) {
            requestMsg = msg;
        }
    }
    return requestMsg;
}

/**
 *   提示请求错误信息  根据后台的code提示
 *
 *  @param msg          后台的提示信息
 *  @param code          后台对应的code
 *  @param requestError 请求错误码
 *  @param localMsg     本地的提示信息   只有code小于规定的值 或大于的值就会提示这个或msg为空
 */
void showRequestErrMsgTip(NSString *msg,NSString *code,HttpRequestError requestError,NSString *localMsg){
    NSString *requestMsg = obtainRequestErrMsg(msg, code, requestError, localMsg);
    if (![code isEqualToString:kLoginFail]) {
        showMessageTip(requestMsg);
    }
}
/**
 *  提示信息
 */
void showMessageTip(NSString *msg){
    if (msg && msg.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
        NSInteger time = kMessageTipTime;
        if (time == 0) time = 3;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                 [alertView dismissWithClickedButtonIndex:0 animated:YES];
            });
        });
    }
}

@end
