//
//  CCHttpRequest+CCLoginRequest.h
//  CloudCity
//
//  Created by Mac on 16/3/1.
//  Copyright © 2016年 Mac. All rights reserved.
//


#define kThePhoneRegisteredCode 401             // 该手机号已注册的返回code
#define kNoSetupPWCode 402             // 该手机号未设置密码的返回code

@class CCRegisterVoucher;

@interface CCHttpRequest (CCLoginRequest)


/**
 *  登录请求
 */
+ (void)requestLogin:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(void (^)(void))successBlock failure:(FaileTypeBlock)failureBlock;


@end
