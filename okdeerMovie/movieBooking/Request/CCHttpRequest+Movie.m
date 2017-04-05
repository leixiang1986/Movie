//
//  CCHttpRequest+Movie.m
//  okdeerMovie
//
//  Created by Mac on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCHttpRequest+Movie.h"

#define kVersionCode            @"V1.2.0"

#define HTTP_FilmOnPlayingList_URL  AppendURL(HTTP_MALLPrefix_URL,@"/movie",kVersionCode,@"/movie")
#define HTTP_FilmWillPlayingList_URL  AppendURL(HTTP_MALLPrefix_URL,@"/movie",kVersionCode,@"/movie")
#define HTTP_FilmDetailInfo_URL  AppendURL(HTTP_MALLPrefix_URL,@"/movie",kVersionCode,@"/movie")
#define HTTP_FilmCinemaDataList_URL  AppendURL(HTTP_MALLPrefix_URL,@"/movie",kVersionCode,@"/movie")

@implementation CCHttpRequest (Movie)

/**
 *  请求影片列表
 */
+ (void)requestFilmOnPlaying:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(moviePlayingArrSuccess)successBlock failure:(FaileTypeBlock)failureBlock
{
    requestModel.urlString = HTTP_FilmOnPlayingList_URL;
    [[CCSendHttpRequest  alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        if (httpRequestBlock) {
            httpRequestBlock(sendHttpRequest);
        }
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if ([CCUtility requestResponseObjectIsTrue:response]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:response];
            NSString *code  = DicGetValueIsClass(dic, kCode, kString);
            NSString *message = DicGetValueIsClass(dic, kMessage, kString);
            NSDictionary *data = DicGetValueIsClass(dic, kData, kDictionary);
            if ([code isEqualToString:kRequestSuccessStatues]) {
                if (successBlock) {
                    // --- 获取数据返回
                }
            }
            else {
                
                [self requestFailureBlock:failureBlock message:message code:code httpRequestError:HttpRequestErrorNoData info:info objc:nil];
            }
        }
        else {
            [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:HttpRequestErrorService info:info objc:nil];
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:httpRequestError info:info objc:nil];
    }];
}

/**
 *  请求正在热映影片列表
 */
+ (void)requestFilmWillPlaying:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(moviePlayingArrSuccess)successBlock failure:(FaileTypeBlock)failureBlock
{
    requestModel.urlString = HTTP_FilmWillPlayingList_URL;
    [[CCSendHttpRequest  alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        if (httpRequestBlock) {
            httpRequestBlock(sendHttpRequest);
        }
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if ([CCUtility requestResponseObjectIsTrue:response]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:response];
            NSString *code  = DicGetValueIsClass(dic, kCode, kString);
            NSString *message = DicGetValueIsClass(dic, kMessage, kString);
            NSDictionary *data = DicGetValueIsClass(dic, kData, kDictionary);
            if ([code isEqualToString:kRequestSuccessStatues]) {
                if (successBlock) {
                    // --- 获取数据返回
                }
            }
            else {
                
                [self requestFailureBlock:failureBlock message:message code:code httpRequestError:HttpRequestErrorNoData info:info objc:nil];
            }
        }
        else {
            [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:HttpRequestErrorService info:info objc:nil];
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:httpRequestError info:info objc:nil];
    }];
}

/**
 *  请求影片详细信息
 */
+ (void)requestFilmDetailInfo:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(movieDetailInfoSuccess)successBlock failure:(FaileTypeBlock)failureBlock
{
    requestModel.urlString = HTTP_FilmDetailInfo_URL;
    [[CCSendHttpRequest  alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        if (httpRequestBlock) {
            httpRequestBlock(sendHttpRequest);
        }
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if ([CCUtility requestResponseObjectIsTrue:response]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:response];
            NSString *code  = DicGetValueIsClass(dic, kCode, kString);
            NSString *message = DicGetValueIsClass(dic, kMessage, kString);
            NSDictionary *data = DicGetValueIsClass(dic, kData, kDictionary);
            if ([code isEqualToString:kRequestSuccessStatues]) {
                if (successBlock) {
                    // --- 获取数据返回
                }
            }
            else {
                
                [self requestFailureBlock:failureBlock message:message code:code httpRequestError:HttpRequestErrorNoData info:info objc:nil];
            }
        }
        else {
            [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:HttpRequestErrorService info:info objc:nil];
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:httpRequestError info:info objc:nil];
    }];
}

/**
 *  请求影片对应日期影院信息
 */
+ (void)requestFilmCinemaDataList:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(filmCinemaDataListSuccess)successBlock failure:(FaileTypeBlock)failureBlock
{
    requestModel.urlString = HTTP_FilmCinemaDataList_URL;
    [[CCSendHttpRequest  alloc] httpRequestModel:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        if (httpRequestBlock) {
            httpRequestBlock(sendHttpRequest);
        }
    } success:^(CCSendHttpRequest *sendHttpRequest, id response, NSDictionary *info) {
        if ([CCUtility requestResponseObjectIsTrue:response]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:response];
            NSString *code  = DicGetValueIsClass(dic, kCode, kString);
            NSString *message = DicGetValueIsClass(dic, kMessage, kString);
            NSDictionary *data = DicGetValueIsClass(dic, kData, kDictionary);
            if ([code isEqualToString:kRequestSuccessStatues]) {
                if (successBlock) {
                    // --- 获取数据返回
                }
            }
            else {
                
                [self requestFailureBlock:failureBlock message:message code:code httpRequestError:HttpRequestErrorNoData info:info objc:nil];
            }
        }
        else {
            [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:HttpRequestErrorService info:info objc:nil];
        }
    } failure:^(CCSendHttpRequest *sendHttpRequest, HttpRequestError httpRequestError, NSError *error, NSDictionary *info) {
        [self requestFailureBlock:failureBlock message:@"" code:kServiceErrorStatues httpRequestError:httpRequestError info:info objc:nil];
    }];
}

@end
