//
//  CCRequestModel.m
//  CloudCity
//
//  Created by Mac on 16/1/16.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCRequestModel.h"
#import "ReachabilityManager.h"
#import "OkdeerPublic.h"
NSString *const kRequestkey = @"okdeerok";

@implementation CCRequestModel

@synthesize parameters = _parameters;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestType = HttpRequestTypePOST;
        _timeOut = 30;
    }
    return self;
}

- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    NSRange range = [urlString rangeOfString:@"?"];
    _urlString =  [CCUtility concatenatedCoding:[NSString stringWithFormat:@"%@%@%@",urlString,(range.location == NSNotFound ? @"?":@"&"),[self obtainPublicParm]]];
}

/**
 *  获取公共的参数
 */
- (NSString *)obtainPublicParm
{
    NSString *timeInterval = [CCUtility obtainTimeInterval];
    NSString *machineCode = [CCUtility obtainUUID];
    NSString *timeDeers = [CCUtility  encryptWithText:[NSString stringWithFormat:@"%@%@",timeInterval,machineCode] key:kRequestkey];
    NSString *deers = [NSString stringWithFormat:@"%@%@",timeInterval,timeDeers];
    deers = [CCUtility concatenatedKey:deers];
   
    return [NSString stringWithFormat:@"machineCode=%@%@networkType=%@%@screen=%@%@clientVersion=%@%@brand=%@%@token=%@%@deers=%@",machineCode,@"&", GetStringToValue([ReachabilityManager sharedManager].netWorkStatus),@"&",[CCUtility obtainScreen],@"&",[CCUtility obtainSystemVersion],@"&",[CCUtility obtainDevicePlatform],@"&",[[UserDataManager shareManager] selectFromToken],@"&",deers];
}

- (id)parameters
{
    if (IsClassTrue(_parameters, kDictionary) || !_parameters) {
        NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
        if (_parameters) {
            [parm addEntriesFromDictionary:_parameters];
        }
        NSDictionary *data = DicGetValueIsClass(parm, kRequestDataKey, kDictionary);
        if (data) {
            NSMutableDictionary *tempData = [[NSMutableDictionary alloc] initWithDictionary:data];
            NSString *userId = DicGetValueIsClass(tempData, @"userId", kString);
            if (!userId || !StringGetLength(userId)) {
                 [tempData setObject:(StringGetLength([[UserDataManager shareManager] selectFromUserId]) ? [[UserDataManager shareManager] selectFromUserId]: @"") forKey:@"userId"];
            }
            [parm setObject:tempData forKey:kRequestDataKey];
        }else{
            if (!DicGetValueIsClass(parm, kRequestDataKey, kArray)) {
                NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
                [tempData setObject:(StringGetLength([[UserDataManager shareManager] selectFromUserId])? [[UserDataManager shareManager] selectFromUserId] : @"") forKey:@"userId"];
                [parm setObject:tempData forKey:kRequestDataKey];
            }
        }
        _parameters = parm;
    }
    return _parameters;
}

@end
