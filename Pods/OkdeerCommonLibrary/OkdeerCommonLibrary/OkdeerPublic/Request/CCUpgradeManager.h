//
//  UpgradeManager.h
//  ThumbLife
//
//  Created by 韦 启鹏 on 14-7-4.
//  Copyright (c) 2014年 韦 启鹏. All rights reserved.
//
// 更新的类

#import <Foundation/Foundation.h>

@protocol UpgradeManagerDelegate <NSObject>
-(void)showUpgradeAlert:(NSString *)version detail:(NSString *)detail isForce:(NSString *)isForce;
@end



@interface CCUpgradeManager : NSObject

@property (nonatomic,weak) id <UpgradeManagerDelegate> delegate;
+(CCUpgradeManager *)instance;
-(void)getUpgradeInfo;
-(void)gotoDownloadUrl;
-(BOOL)isNeedUpdate;
@end
