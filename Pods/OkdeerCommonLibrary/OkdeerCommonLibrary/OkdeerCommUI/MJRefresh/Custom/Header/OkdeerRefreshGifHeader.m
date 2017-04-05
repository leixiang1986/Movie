//
//  OkdeerRefreshGifHeader.m
//  OkdeerCommUI
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "OkdeerRefreshGifHeader.h"
#import "MJRefreshConst.h"

@implementation OkdeerRefreshGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"homeRefresh0%zd",i];
        if (imageName.length) {
            UIImage *image = [self imagefrombundle:@"MJRefresh" inDirectory:@"Image" fileName:imageName];
            if (image) {
                [idleImages addObject:image];
            }
        }
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"MJRefresh.bundle/homeRefresh0%zd", i]];
//        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"homeRefresh0%zd",i];
        if (imageName.length) {
            UIImage *image = [self imagefrombundle:@"MJRefresh" inDirectory:@"Image" fileName:imageName];
            if (image) {
                [refreshingImages addObject:image];
            }
        }
        //UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"MJRefresh.bundle/homeRefresh0%zd", i]];
        //[refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

//获取到图片
- (UIImage *)imagefrombundle:(NSString *)bundleName inDirectory:(NSString *)inDirectory fileName:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
    //没有找到bundle
    if (!bundle) {
        if (imageName.length) {
            return [UIImage imageNamed:imageName];
        }
        return nil;
    }
    
    UIImage *image = nil;
    
    NSString *imageBundleName = [NSString stringWithFormat:@"%@.bundle%@/%@",bundleName,(inDirectory.length > 0 ? [NSString stringWithFormat:@"/%@",inDirectory] : @""),imageName];
    if (imageBundleName.length){
        //NSLog(@"imagebundle..%@", imageBundleName);
        image = [UIImage imageNamed:imageBundleName];
        //image = [UIImage imageWithContentsOfFile:imageBundleName];
    }
    
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:inDirectory];
    if (!image){
        //NSLog(@"imagepath..");
        //图片路径是nil
        if (!imagePath.length) {
            if (imageName.length) {
                image = [UIImage imageNamed:imageName];
            }
        }
    }
    if(!image){
        image = [UIImage imageNamed:imagePath];
    }
    return image;
}

@end
