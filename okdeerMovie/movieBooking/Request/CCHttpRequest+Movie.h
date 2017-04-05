//
//  CCHttpRequest+Movie.h
//  okdeerMovie
//
//  Created by Mac on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

/************
 *
 *  电影订座相关Http请求
 *
 ************/

@class CCFilmDetailInfoModel;

// --- 影片列表block
typedef void(^moviePlayingArrSuccess)(NSString *code,NSString *msg, NSArray *arr, NSString *totalPage);
// --- 影片详情block
typedef void(^movieDetailInfoSuccess)(NSString *code, NSString *msg, CCFilmDetailInfoModel *detailModel);
// --- 影片对应日期影院信息
typedef void(^filmCinemaDataListSuccess)(NSString *code,NSString *msg, NSArray *arr, NSString *totalPage);

@interface CCHttpRequest (Movie)

/**
 *  请求正在热映影片列表
 */
+ (void)requestFilmOnPlaying:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(moviePlayingArrSuccess)successBlock failure:(FaileTypeBlock)failureBlock;

/**
 *  请求正在热映影片列表
 */
+ (void)requestFilmWillPlaying:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(moviePlayingArrSuccess)successBlock failure:(FaileTypeBlock)failureBlock;

/**
 *  请求影片详细信息
 */
+ (void)requestFilmDetailInfo:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(movieDetailInfoSuccess)successBlock failure:(FaileTypeBlock)failureBlock;

/**
 *  请求影片对应日期影院信息
 */
+ (void)requestFilmCinemaDataList:(CCRequestModel *)requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(filmCinemaDataListSuccess)successBlock failure:(FaileTypeBlock)failureBlock;

@end
