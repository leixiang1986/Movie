//
//  CCCommonLocationModel.m
//  OkdeerUser
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCommonLocationModel.h"

#define kCCLocationModel @"CCLocationModel"
#define kInstance @"instance"

@interface CCCommonLocationModel ()
{
    id _model;
}
@end

@implementation CCCommonLocationModel

/**
 *  首页选择的地址\定位的地址
 */
+ (instancetype)locationInfo {
    return [[CCCommonLocationModel alloc] init];
}

- (instancetype)init {
    if (self = [super init]){
        Class location = NSClassFromString(kCCLocationModel);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        _model = [location performSelector:NSSelectorFromString(kInstance)];
#pragma clang diagnostic pop
        _locationName = [_model locationName];
        _locationCode = [_model locationCode];
        _locationAddress = [_model locationAddress];
        _latitude = [_model latitude];
        _longitude = [_model longitude];
        _city = [_model city];
        _province = [_model province];
        _area = [_model area];
        _locationPhone = [_model locationPhone];
        _locatedCity = [_model locatedCity];
    }
    return self;
}

- (NSString *)locationName {
    return [self checkNil:[_model locationName]];
}

- (NSString *)locationCode {
    return  [self checkNil:[_model locationCode]];
}

- (NSString *)locationAddress {
    return [self checkNil:[_model locationAddress]];
}

- (double)latitude {
    return [_model latitude];
}

- (double)longitude {
    return [_model longitude];
}

- (NSString *)city {
    return [self checkNil:[_model city]];
}

- (NSString *)province {
    return [self checkNil:[_model province]];
}

- (NSString *)area {
    return [self checkNil:[_model area]];
}

- (NSString *)locationPhone {
    return [self checkNil:[_model locationPhone]];
}

- (NSString *)locatedCity {
    return [self checkNil:[_model locatedCity]];
}

-(NSString *)checkNil:(NSString *)value
{
    if(!value || ![value isKindOfClass:[NSString class]]) {
        return @"";
    }
    return value;
}

@end
