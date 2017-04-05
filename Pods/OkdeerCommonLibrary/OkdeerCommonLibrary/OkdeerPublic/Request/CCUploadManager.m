//
//  CCUploadManager.m
//  QiNiuDemo
//
//  Created by huangshupeng on 16/3/21.
//  Copyright © 2016年 huangshupeng. All rights reserved.
//

#import "CCUploadManager.h"
#import "QiniuSDK.h"
#import <UIKit/UIKit.h>
#import "CCHttpRequest.h"
#import "CCRequestModel.h"
#import "OkdeerPublic.h"
#import "CCHttpRequest.h"
#import "RequestMessageTip.h"

@interface CCUploadManager ()

@property (nonatomic,copy) UploadFailureBlock failureBlock;   /**< 上传失败 */
@property (nonatomic,copy) UploadSuccessBlock successBlock;   /**< 上传成功  */
@property (nonatomic,strong) NSArray *imageArray;     /**< 图片数组  */
@property (nonatomic,strong) NSArray *successKeyArray; /**< 成功的key 的数组 */
@property (nonatomic,strong) NSArray *failurekeyArray; /**< 失败的key 的数组 */
@property (nonatomic,strong) NSArray *uploadKeyModelArray;  /**< 上传的key */
@property (nonatomic,assign) UploadModuleType moduleType;  /**< 模块 */
@property (nonatomic,assign) BOOL uploading;      /**< 上传中 */
@property (nonatomic,strong) QNUploadManager *upLoadManager;  /**< 上传对象 */
@property (nonatomic,assign) __block BOOL flag;
@property (nonatomic,strong) CCRequestModel *requestModel;     /**< 请求对象 */

@end

@implementation CCUploadManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static CCUploadManager *uploadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploadManager = [super allocWithZone:zone];
    });
    return uploadManager;
}

+ (instancetype)instance
{
    return [[self alloc] init];
}
#pragma mark - /*** getter ***/
- (QNUploadManager *)upLoadManager
{
    if (!_upLoadManager) {
        _upLoadManager = [[QNUploadManager alloc] init];
    }
    return _upLoadManager;
}

- (CCRequestModel *)requestModel
{
    if (!_requestModel) {
        _requestModel = [[CCRequestModel alloc] init];
    }
    return _requestModel;
}

/**
 *  上传多张图片
 */
- (void)uploadImages:(NSArray *)imageArray moduleType:(UploadModuleType)moduleType success:(UploadSuccessBlock)successBlock failure:(UploadFailureBlock)failureBlock
{
    if (!_uploading && ArrayGetCount(imageArray)) {
        _imageArray = imageArray;
        _successKeyArray = nil;
        _failurekeyArray = nil;
        _uploadKeyModelArray = nil;
        _successBlock = successBlock;
        _failureBlock = failureBlock;
        _moduleType = moduleType;
        [self requestToken];
    }else{
        if (failureBlock) {
            failureBlock(@"请选择图片",@[],imageArray);
        }
    }
}

/**
 *  上传图片
 */
- (void)uploadImage:(NSString *)token{
    _uploadKeyModelArray = [self obtainKeys];
    _flag = NO;
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSDictionary *parm = @{@"deadline":[NSString stringWithFormat:@"%.0f",timeInterval + 3600]};
    
    for (NSInteger i = 0; i < _uploadKeyModelArray.count; i ++ ) {
        CCUploadKeyModel *keyModel = ArrayGetValueIsClass(_uploadKeyModelArray, i, @"CCUploadKeyModel");
        if (keyModel) {
            QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
                //CCLog(@"key=%@  percent = %f",key,percent);
            } params:parm checkCrc:NO cancellationSignal:^BOOL{
                return _flag;
            }];
            [self.upLoadManager putData:keyModel.imageData key:keyModel.keyName token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                //数据回调即设置未不在上传中.. fix me ^_^ by chenzl
                _uploading = NO;
                //CCLog(@"%@---%@",info,resp);
                if (info.statusCode == 200) {
                    [self uploadSuccess:key];
                }else{
                    [self uploadFaile:key];
                }
            } option:uploadOption];
        }
    }
    _uploading = YES;
}

/**
 *  上传成功的统计
 */
- (void)uploadSuccess:(NSString *)key{
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObjectsFromArray:_successKeyArray];
    [keyArray addObject:(key.length ? key : @"")];
    
    _successKeyArray = keyArray;
    if (_successKeyArray.count >= _uploadKeyModelArray.count && _successBlock) {
        NSMutableArray *uploadMArray = [[NSMutableArray alloc] init];
        for (CCUploadKeyModel *model  in _uploadKeyModelArray) {
            if (IsClassTrue(model, @"CCUploadKeyModel")) {
                if (StringGetLength(model.keyName)) {
                    [uploadMArray addObject:model.keyName];
                }
            }
        }
        _successBlock(uploadMArray);
        //_uploading = NO;
    }
}

/**
 *  上传失败的统计
 */
- (void)uploadFaile:(NSString *)key{
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObjectsFromArray:_failurekeyArray];
    if (key && key.length) {
        [keyArray addObject:key];
    }
    _failurekeyArray = keyArray;
    if (_failurekeyArray.count + _successKeyArray.count >= _uploadKeyModelArray.count && _failureBlock) {
        NSMutableArray *failureImageArray = [[NSMutableArray alloc] init];
        for (CCUploadKeyModel *model in _uploadKeyModelArray) {
            BOOL exist = [_failurekeyArray containsObject:model.keyName];
            if (exist) {
                if (model.uploadImage) {
                    [failureImageArray addObject:model.uploadImage];
                }
            }
        }
        _failureBlock(@"上传图片失败，请重试!",_successKeyArray,failureImageArray);
        //_uploading = NO;
    }
}

/**
 *  获取上传的key
 */
- (NSArray *)obtainKeys{
    NSMutableArray *key = [[NSMutableArray alloc] init];
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *uuid = [CCUtility obtainUUID];
   
    for (NSInteger  i = 0 ; i < _imageArray.count; i ++ ) {
        UIImage *image = ArrayGetValueIsClass(_imageArray, i, @"UIImage");
        if (image) {
            NSArray *tempArray = [CCUtility disposeImagesWithArray:@[image]];
            NSData *imageData = DicGetValue([tempArray firstObject], kImageDataKey);
            if (imageData) {
                NSString *keyString = [NSString stringWithFormat:@"%.0f%ld%@",timeInterval ,(long)i,uuid];
                CCUploadKeyModel *keyModel = [[CCUploadKeyModel alloc] init];
                keyModel.keyName = keyString;
                keyModel.uploadImage = image;
                keyModel.imageData = imageData;
                [key addObject:keyModel];
            }
        }
        
        //Add, 如果上传的是网络链接(七牛链接), 将7牛链接转为NSData, fix me ^_^
        NSString *qiNiuUrl = ArrayGetValueIsClass(_imageArray, i, kString);
        if ([qiNiuUrl length]) {
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:qiNiuUrl]];
            if (imageData) {
                NSString *keyString = [NSString stringWithFormat:@"%.0f%ld%@",timeInterval ,(long)i,uuid];
                CCUploadKeyModel *keyModel = [[CCUploadKeyModel alloc] init];
                keyModel.keyName = keyString;
                keyModel.uploadImage = image;
                keyModel.imageData = imageData;
                [key addObject:keyModel];
            }
        }
    }
    return key;
}
/**
 *  获取到上传的凭证 token
 */
- (void)requestToken{
    if (!self.requestModel.isRequest) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
       NSString *moduleName = [self obtainModuleName];
        [data setObject:(StringGetLength(moduleName) ? moduleName : @"") forKey:@"token"];
        [dic setObject:data forKey:@"data"];
        self.requestModel.parameters = dic;
        [CCHttpRequest requestUploadImageToken:self.requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
            
        } success:^(NSString *token) {
             [self uploadImage:token];
        } failure:^(NSString *code, HttpRequestError httpRequestError, NSString *msg, NSDictionary *info, id objc) {
            NSString *message = obtainRequestErrMsg(msg, code, httpRequestError, @"上传图片失败哦!");
            if (_failureBlock) {
                _failureBlock(message,@[],_imageArray);
            }
        }];
    }
}

- (NSString *)obtainModuleName{
    NSString *moduleName = @"";
    switch (self.moduleType) {
        case UploadModuleTypeAtBrand: {
            moduleName = @"brand";
            break;
        }
        case UploadModuleTypeAtGoods: {
                 moduleName = @"goods";
            break;
        }
        case UploadModuleTypeAtStore: {
                 moduleName = @"store";
            break;
        }
        case UploadModuleTypeAtProperty: {
                 moduleName = @"property";
            break;
        }
        case UploadModuleTypeAtOperate: {
                 moduleName = @"operate";
            break;
        }
        case UploadModuleTypeAtAdvert: {
                 moduleName = @"advert";
            break;
        }
        case UploadModuleTypeAtOrder: {
                 moduleName = @"order";
            break;
            
        }
        case UploadModuleTypeAtMyinfo:{
            moduleName = @"myinfo";
            break;
        }
        case UploadModuleTypeAtPropertyservice:{
            moduleName = @"propertyservice";
            break;
        }
    }
    return moduleName;
}

/**
 *  取消请求
 */
- (void)canceRequest
{
    _failurekeyArray = nil;
    _successKeyArray = nil;
    _failureBlock = nil;
    _successBlock = nil;
    _uploadKeyModelArray = nil;
    _uploading = NO;
    _imageArray = nil;
    _flag = YES;
}

@end

@implementation CCUploadKeyModel

@end

