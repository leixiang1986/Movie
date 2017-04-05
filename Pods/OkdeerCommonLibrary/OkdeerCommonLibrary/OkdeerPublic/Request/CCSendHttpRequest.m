//
//  CCSendHttpRequest.m
//  Donghua
//
//  Created by Mac on 16/1/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCSendHttpRequest.h"
#import "AFHTTPSessionManager.h"
#import "ReachabilityManager.h"
#import "CCRequestModel.h"
#import "OkdeerPublic.h"
@interface CCSendHttpRequest ()

@property (nonatomic, copy) HttpRequestBlock httpRequestBlock;    /**< 请求对象 */
@property (nonatomic, copy) SuccessBlock successBlock;            /**< 请求成功 */
@property (nonatomic, copy) FailureBlock failureBlock;            /**< 请求失败 */
@property (nonatomic) dispatch_source_t  timer;                   /**< 定时器  */
@property (nonatomic, strong)  AFHTTPSessionManager *requestManager;   /**< 请求对象 */

@property (nonatomic, strong) NSURLSessionDataTask *urlSessionDataTask;  /**< 请求*/
@property (nonatomic, strong) CCRequestModel *requestModel;           /**< 请求model */

@end

@implementation CCSendHttpRequest

/**
 *  调起请求
 */
- (void)httpRequestType:(HttpRequestType)type urlString:(NSString *)urlString parameters:(id)parameters  httpRequest:(HttpRequestBlock)httpRequestBlock success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    
    if (!StringGetLength(urlString)) {
        urlString = @""; 
    }
 
    _requestModel.isRequest =  YES;
    _requestManager = [AFHTTPSessionManager manager];
    
    _successBlock = successBlock;
    _failureBlock = failureBlock;

    if ([[ReachabilityManager sharedManager] isNotReachable] ) {
        [self failureComplete:HttpRequestErrorNoNetWork error:nil info:@{}];
          return;
    }else if (!StringGetLength(urlString)){
        [self failureComplete:HttpRequestErrorService error:nil info:@{}];
        return;
    }
    CCLog(@"url is =====\n %@",urlString);
    CCLog(@"parm is =====\n %@",[CCUtility dictionaryToString:parameters]);
    switch (type) {
        case HttpRequestTypeGET: // get
            [self get:urlString paeamerers:parameters];
            break;
        case HttpRequestTypePOST:  // post
            [self post:urlString paeamerers:parameters];
            break;
        case HttpRequestTypeHEAD:
            [self head:urlString paeamerers:parameters];
            break;
        case HttpRequestTypePUT:
            [self put:urlString paeamerers:parameters];
            break;
        default:
            [self post:urlString paeamerers:parameters];
            break;
    }
    if (httpRequestBlock) {
        httpRequestBlock(self);
    }
}

/**
 *  调起请求
 */
- (void)httpRequestType:(HttpRequestType)type urlString:(NSString *)urlString parameters:(id)parameters requestTimeOut:(int)timeOut httpRequest:(HttpRequestBlock)httpRequestBlock success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    [self httpRequestType:type urlString:urlString parameters:parameters httpRequest:httpRequestBlock success:successBlock failure:failureBlock];
    if (timeOut > 0 ) {
        _timer = [CCUtility countdownWithTimeOut:timeOut run:^(int time, dispatch_source_t timer) {
            
        } completion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_requestManager.operationQueue cancelAllOperations];
            });
        }];
    }
}

/**
 *   发起请求  传入model
 */
- (void)httpRequestModel:(CCRequestModel *) requestModel httpRequest:(HttpRequestBlock)httpRequestBlock success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    _requestModel = requestModel;
    [self httpRequestType:_requestModel.requestType urlString:_requestModel.urlString parameters:_requestModel.parameters requestTimeOut:_requestModel.timeOut httpRequest:httpRequestBlock success:successBlock failure:failureBlock];
}

/*!
 *  post 请求
 */
- (void)post:(NSString *)urlString
  paeamerers:(id)parameters
{
    // 说明服务器返回的JSON数据
    _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    //传入json格式数据，不写则普通post
    _requestManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
   _urlSessionDataTask = [_requestManager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self successResponseObject:responseObject httpUrlResponse:(NSHTTPURLResponse *)task.response] ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureError:error httpUrlResponse:(NSHTTPURLResponse *)task.response];
    }];
}

/*!
 *  get 请求
 *
 *  @param urlString          请求地址
 *  @param parameters   请求参数
 */
- (void)get:(NSString *)urlString
 paeamerers:(id)parameters
{
    // 说明服务器返回的JSON数据
    _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    //传入json格式数据，不写则普通post
    _requestManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
    _urlSessionDataTask = [_requestManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self successResponseObject:responseObject httpUrlResponse:(NSHTTPURLResponse *)task.response] ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self failureError:error httpUrlResponse:(NSHTTPURLResponse *)task.response];
    }];
}

/*!
 *  head 请求
 *
 *  @param urlString          请求地址
 *  @param parameters   请求参数
 */
- (void)head:(NSString *)urlString
  paeamerers:(id)parameters
{
    _urlSessionDataTask =  [_requestManager HEAD:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
        [self successResponseObject:nil httpUrlResponse:(NSHTTPURLResponse *)task.response] ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureError:error httpUrlResponse:(NSHTTPURLResponse *)task.response] ;
    }  ];
}

/*!
 *  put 请求
 *
 *  @param urlString          请求地址
 *  @param parameters   请求参数
 */
- (void)put:(NSString *)urlString paeamerers:(id)parameters
{
    _urlSessionDataTask = [_requestManager PUT:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponseObject:responseObject httpUrlResponse:(NSHTTPURLResponse *)task.response] ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureError:error httpUrlResponse:(NSHTTPURLResponse *)task.response] ;
    }];
}

/*!
 *  成功时的回调
 *
 *  @param httpUrlResponse   成功
 *  @param responseObject 数据源
 */
- (void)successResponseObject:(id)responseObject httpUrlResponse:(NSHTTPURLResponse *)httpUrlResponse{
    [self stopTimer];
    _requestModel.isRequest = NO;
    NSDictionary *info = [self obtainNetWorkTime:httpUrlResponse];
    // 暂时先在这里处理token 失效
    [self dealTokenStatues:responseObject];
    if (_successBlock) {
        _successBlock(self,responseObject,info);
    }
     CCLog(@"responseObject =====\n %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
}
/*!
 *  处理失败的
 */
- (void)failureError:(NSError *)error httpUrlResponse:(NSHTTPURLResponse *)httpUrlResponse{
    HttpRequestError httpRequestError;
    [self stopTimer];
    NSDictionary *info = [self obtainNetWorkTime:httpUrlResponse];
    if ([error code] == kCFURLErrorTimedOut ) {
        httpRequestError = HttpRequestErrorTimeOut;
    }else{
        httpRequestError = HttpRequestErrorService;
    }
    [self failureComplete:httpRequestError error:error info:info];
    
}
/**
 *  失败回调
 */
- (void)failureComplete:(HttpRequestError)httpRequestError error:(NSError *)error info:(NSDictionary *)info
{
    _requestModel.isRequest = NO;
    if (_failureBlock) {
        _failureBlock(self,httpRequestError,error,info);
    }
    CCLog(@"response error is =====\n%@",error);
}
/**
 *  处理token 状态
 */
- (void)dealTokenStatues:(id)responseObject{
    if (responseObject && ![responseObject isKindOfClass:[NSError class]]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSString *code =  [NSString stringWithFormat:@"%@",dic[kRequestCodeKey]];
            NSString *message = dic[kRequestMessageKey];
            if ([code isKindOfClass:[NSString class]] && [code isEqualToString:kLoginFail]) {
                CCLog(@"token 失效  需要重新登录");
                [[NSNotificationCenter defaultCenter] postNotificationName:kTokenExpiry object:message];
            }
        }
    }
}

/**
 *  停止倒计时
 */
- (void)stopTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
}

/**
 *  取消请求
 */
- (void)canceRequest
{
    [self stopTimer];
    [_urlSessionDataTask cancel];
    _requestModel.isRequest = NO; 
    _urlSessionDataTask = nil;
    _httpRequestBlock = nil;
    _successBlock = nil;
    _failureBlock = nil;
}
/**
 *  获取网络的时间
 */
- (NSDictionary *)obtainNetWorkTime:(NSHTTPURLResponse *)httpUrlResponse
{
    NSMutableDictionary *timeInfo = [[NSMutableDictionary alloc] init];
    if ([httpUrlResponse respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dic=[httpUrlResponse allHeaderFields];
        
        NSString *date = [dic objectForKey:@"Date"];
        if (date.length > 5 ) {
            date = [date substringFromIndex:5];
        }
        if (date.length > 3 ) {
            date = [date substringToIndex:[date length]-4];
        }
        NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
        dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
        NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
        [dMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *netDateString = [dMatter stringFromDate:netDate];
        if (!netDateString) {
            netDateString = @"";
        }
        [timeInfo setObject:netDateString forKey:@"netDate"];
    }
    return timeInfo;
}

- (void)dealloc
{
    [self canceRequest];
}

@end
