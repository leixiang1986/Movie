//
//  CCHttpRequest+CCLoginRequest.m
//  CloudCity
//
//  Created by Mac on 16/3/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCHttpRequest+CCLoginRequest.h"
#import "CCMyUserInforModel.h"

#define kVersionCode            @"V1.2.0"

// 登录URL
#define HTTP_FOR_Login_URL    AppendURL(HTTP_MALLPrefix_URL,@"/buyer",kVersionCode,@"/login")

@implementation CCHttpRequest (CCLoginRequest)

/**
 *  登录请求
 */
+ (void)requestLogin:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(void (^)(void))successBlock failure:(FaileTypeBlock)failureBlock {
    
    requestModel.urlString = HTTP_FOR_Login_URL;
    [[CCSendHttpRequest  alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        if (httpRequestBlock) {
            httpRequestBlock(sendHttpRequest);
        }
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if ([CCUtility requestResponseObjectIsTrue:response]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:response];
            NSString *code = DicGetValue(dic, kRequestCodeKey);
            NSString *message = DicGetValue(dic, kRequestMessageKey);
            
            if (code && [code isEqualToString:kRequestSuccessStatues]){
                NSString * token = DicGetValueIsClass(dic, @"token", @"NSString");
                NSDictionary * data = DicGetValueIsClass(dic, @"data", @"NSDictionary");
                if (data && token.length){
                    
                    [CCMyUserInforModel modelObjectWithDictionaryForUserInfor:data];
                    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [[UserDataManager shareManager] performSelector:NSSelectorFromString(@"saveToken:") withObject:token];
                    [[UserDataManager shareManager] performSelector:NSSelectorFromString(@"saveFirstLogin:") withObject:DicGetValueIsClass(data, @"isOneLogin", kString)];
                    [[UserDataManager shareManager] performSelector:NSSelectorFromString(@"saveLogined:") withObject:@"1"];
#pragma clang diagnostic pop
                    
                    if (successBlock) {
                        successBlock();
                    }
                }else {
                    if (failureBlock){
                        failureBlock(code, HttpRequestErrorNoData, message, info, nil);
                    }
                }
            }else {
                if (failureBlock){
                    failureBlock(code, HttpRequestErrorNoData, message, info, nil);
                }
            }
        }else {
            if (failureBlock){
                failureBlock(kServiceErrorStatues, HttpRequestErrorService, @"", info, nil);
            }
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        if (failureBlock){
            failureBlock(kServiceErrorStatues, httpRequestError, @"", info, nil);
        }
    }];
}


@end
