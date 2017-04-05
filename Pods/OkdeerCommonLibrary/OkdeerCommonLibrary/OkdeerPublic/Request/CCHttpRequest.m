//
//  CCHttpRequest.m
//  RequestFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCHttpRequest.h"
#import "CCRequestModel.h"
#import "CCSendHttpRequest.h"
#import "OkdeerPublic.h"
@implementation CCHttpRequest

/**
 *  请求失败的处理回调
 */
+ (void)requestFailureBlock:(FaileTypeBlock)faileBlock message:(NSString *)message code:(NSString *)code httpRequestError:(HttpRequestError) httpRequestError info:(NSDictionary *)info objc:(id)objc{
    if (faileBlock) {
        faileBlock(code,httpRequestError,message,info,objc);
    }
}
/**
 *  请求对象回调
 */
+ (void)requestHttpRequestBlock:(HttpRequestBlock)httpRequestBlock httpRequest:(CCSendHttpRequest *)httpRequest
{
    if (httpRequestBlock) {
        httpRequestBlock (httpRequest);
    }
}
/**
 *   请求更新版本
 */
+ (void)requestUpdateVersion:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(UpDataVersionSuccessBlock)versionBlock{
    NSString *urlString = UPGRADE_URL;
     
    NSRange range = [urlString rangeOfString:kQuestionMark];
    urlString = [NSString stringWithFormat:@"%@%@versionCode=%@",urlString,(range.location == NSNotFound ? kQuestionMark : kJoiner),[[UserDataManager shareManager] selectFromVersionCode]];
    requestModel.urlString = urlString;
    [[CCSendHttpRequest alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        [self requestHttpRequestBlock:httpRequestBlock httpRequest:sendHttpRequest];
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if (versionBlock) {
            versionBlock(response);
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        if (versionBlock) {
            versionBlock(nil);
        }
    }];
}
/**
 *  请求获取上传七牛图片的token
 */
+ (void)requestUploadImageToken:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(UploadTokenSuccessBlock)uploadSuccessBlock failure:(FaileTypeBlock)failureBlock{
    requestModel.urlString = HTTP_FOR_UPLOADTOKEN_URL;
    [[CCSendHttpRequest alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        [self requestHttpRequestBlock:httpRequestBlock httpRequest:sendHttpRequest];
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if ([CCUtility requestResponseObjectIsTrue:response]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:response];
            NSString *code = [CCUtility getStringFormDic:dic[kRequestCodeKey]];
            NSString *message = DicGetValueIsClass(dic, kRequestMessageKey, kString);
            if ([code isEqualToString:kRequestSuccessStatues]) {
                NSString *token = [CCUtility getStringFormDic:dic[kRequestDataKey]];
                if (uploadSuccessBlock) {
                    uploadSuccessBlock(token);
                }
            }else{
                [self requestFailureBlock:failureBlock message:message code:code httpRequestError:HttpRequestErrorNoData info:info objc:nil];
            }
        }else{
            [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:HttpRequestErrorService info:info objc:nil];
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:httpRequestError info:info objc:nil];
    }];
}

@end
