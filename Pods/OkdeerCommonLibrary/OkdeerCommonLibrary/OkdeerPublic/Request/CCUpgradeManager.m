//
//  UpgradeManager.m
//  ThumbLife
//
//  Created by 韦 启鹏 on 14-7-4.
//  Copyright (c) 2014年 韦 启鹏. All rights reserved.
//

#import "CCUpgradeManager.h"
#import "CCHttpRequestUrlHeader.h"
#import "CCHttpRequest.h"
#import "CCRequestModel.h"
#import "OkdeerPublic.h"
@interface CCUpgradeManager ()

@property (nonatomic,strong) NSDictionary *infoDictionary;
@property (nonatomic,assign)  BOOL needUpgrade;

@end

@implementation CCUpgradeManager

@synthesize delegate = _delegate;

static CCUpgradeManager *manager = nil;

+(CCUpgradeManager *)instance
{
    if (manager == nil) {
        manager = [[CCUpgradeManager alloc]init];
    }
    return manager;
}

//Safari 打开下载页面
-(void)gotoDownloadUrl
{
    NSURL *downloadUrl = [NSURL URLWithString:DicGetValueIsClass(self.infoDictionary, @"downLoadUrl", kString)];
    [[UIApplication sharedApplication] openURL:downloadUrl];
}

//获取软件更新信息
-(void)getUpgradeInfo
{
    CCRequestModel *reqeuestModel = [[CCRequestModel alloc] init];
    reqeuestModel.requestType = HttpRequestTypeGET ;
    [CCHttpRequest requestUpdateVersion:reqeuestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        
    } success:^(id responseObject) {
        if ([CCUtility requestResponseObjectIsTrue:responseObject]) {
            NSDictionary *dic = [CCUtility requestReturnTypeOfDictionary:responseObject];
            [self dealwithUpgradeInfo:dic];
        }
    }];
}

//处理软件更新
-(void)dealwithUpgradeInfo:(NSDictionary *)dic
{
    NSString *code = [CCUtility getStringFormDic:dic[kRequestCodeKey]];
    //    NSString *message = [CCUtility getStringFormDic:dic[kRequestMessageKey]];
    if ([code isEqualToString:kRequestSuccessStatues]) {
        NSDictionary *data = [CCUtility getDicFormDic:dic[kRequestDataKey]];
        NSString *downLoadUrl = [CCUtility getStringFormDic:data[@"downLoadUrl"]];
        CCLog(@"downLoadUrl %@",downLoadUrl);
        NSString *isForce = [CCUtility getStringFormDic:data[@"isForce"]];
        NSString *versionCode = [CCUtility getStringFormDic:data[@"versionCode"]];
        NSString *versionName = [CCUtility getStringFormDic:data[@"versionName"]];
        NSArray *detailArray = [CCUtility getArrayFormDic:data[@"updateInfo"]];
        NSMutableString *detail = [[NSMutableString alloc] init];
        self.infoDictionary =  data;
        [detail appendString:@"\n"];
        for (NSDictionary *info in detailArray) {
            NSString *infoString = [CCUtility getStringFormDic:info[@"info"]];
            if (StringGetLength(infoString)) {
                [detail appendString:infoString];
                [detail appendString:@"\n"];
            }
        }
        CCLog(@"downLoadUrl = %@ isForce = %@ versionCode = %@ versionName = %@",downLoadUrl,isForce,versionCode,versionName);
        if ([self checkVersion:versionCode] && self.delegate && [self.delegate respondsToSelector:@selector(showUpgradeAlert:detail:isForce:)]) {
            [self.delegate showUpgradeAlert:versionName detail:detail isForce:isForce];
        }
    }
}

//检查是否需要更新
-(BOOL)checkVersion:(NSString *)newVersion
{
 
    self.needUpgrade = NO;
    if (newVersion) {
        NSString *curVersionCode = [[UserDataManager shareManager] selectFromVersionCode];
        if ([newVersion compare:curVersionCode] > 0) {
            self.needUpgrade = YES;
        }
        
    }
    return self.needUpgrade;
 
}


- (BOOL)isNeedUpdate
{
    if (self.needUpgrade) {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
