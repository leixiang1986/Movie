//
//  CCCommonMyUserInfoModel.m
//  OkdeerUser
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCommonMyUserInfoModel.h"

#define kCCMyUserInforModel @"CCMyUserInforModel"
#define kInstance @"instance"

@implementation CCCommonMyUserInfoModel
{
    id _model;
}

/**
 *   获取用户信息
 */
+ (instancetype)userInfo {
    return [[CCCommonMyUserInfoModel alloc] init];
}

- (instancetype)init {
    if (self = [super init]){
        Class myUserInfo = NSClassFromString(kCCMyUserInforModel);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        _model = [myUserInfo performSelector:NSSelectorFromString(kInstance)];
#pragma clang diagnostic pop
        _phone = [_model phone];
        _loginName = [_model loginName];
        _nickName = [_model nickName];
        _realName = [_model realName];
        _userId = [_model userId];
        _phoneMac = [_model phoneMac];
        _picUrl = [_model picUrl];
        _serviceUrl = [_model serviceUrl];
        _headerImage = [_model headerImage];
        _gender = [_model gender];
        _birthday = [_model birthday];
        _profession = [_model profession];
        _interest = [_model interest];
        _email = [_model email];
        _maritalStatus = [_model maritalStatus];
        _sign = [_model sign];
        _status = [_model status];
        _descriptionStr = [_model descriptionStr];
        _createTime = [_model createTime];
        _updateTime = [_model updateTime];
        _sysNotice = [_model sysNotice];
        _propNotice = [_model propNotice];
        _isLoginPassword = [_model isLoginPassword];
    }
    return self;
}

- (NSString *)phone {
    return [self checkNil:[_model phone]];
}

- (NSString *)loginName {
    return [self checkNil:[_model loginName]];
}

- (NSString *)nickName {
    return [self checkNil:[_model nickName]];
}

- (NSString *)realName {
    return [self checkNil:[_model realName]];
}

- (NSString *)userId {
    return [self checkNil:[_model userId]];
}

- (NSString *)phoneMac {
    return [self checkNil:[_model phoneMac]];
}

- (NSString *)picUrl {
    return [self checkNil:[_model picUrl]];
}

- (NSString *)serviceUrl {
    return [self checkNil:[_model serviceUrl]];
}

- (UIImage *)headerImage {
    if (![_model headerImage]){
        return [UIImage imageNamed:@"headerDefault"];//系统默认图片
    }
    return [_model headerImage];
}

- (NSString *)gender {
    return [self checkNil:[_model gender]];
}

- (NSString *)birthday {
    return [self checkNil:[_model birthday]];
}

- (NSString *)profession {
    return [self checkNil:[_model profession]];
}

- (NSString *)interest {
    return [self checkNil:[_model interest]];
}

- (NSString *)email {
    return [self checkNil:[_model email]];
}

- (NSString *)maritalStatus {
    return [self checkNil:[_model maritalStatus]];
}

- (NSString *)sign {
    return [self checkNil:[_model sign]];
}

- (NSString *)status {
    return [self checkNil:[_model status]];
}

- (NSString *)descriptionStr {
    return [self checkNil:[_model descriptionStr]];
}

- (NSString *)createTime {
    return [self checkNil:[_model createTime]];
}

- (NSString *)updateTime {
    return [self checkNil:[_model updateTime]];
}

- (NSString *)sysNotice {
    return [self checkNil:[_model sysNotice]];
}

- (NSString *)propNotice {
    return [self checkNil:[_model propNotice]];
}

- (NSString *)isLoginPassword {
    return [self checkNil:[_model isLoginPassword]];
}

-(NSString *)checkNil:(NSString *)value
{
    if(!value || ![value isKindOfClass:[NSString class]]) {
        return @"";
    }
    return value;
}

@end
