//
//  CCCustomScrollView.m
//  CloudCity
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomScrollView.h"
#import "MJRefresh.h"

@implementation CCCustomScrollView
#pragma mark - //****************** setter ******************//
- (void)setHeaderRefereshBlock:(HeaderRefereshBlock)headerRefereshBlock{
    _headerRefereshBlock = headerRefereshBlock;
    [self addHeaderReferesh];
}
#pragma mark - //****************** 方法 ******************//
/**
 *  停止刷新加载动画
 */
- (void)stopReferesh{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
}
/**
 *  添加刷新控件
 */
- (void)addHeaderReferesh{
    if (_headerRefereshBlock) {
        __weak typeof(self) weakSelf = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf headerRefreshing];
            }
        }];
    }else{
        self.mj_header = nil;
    }
}
/**
 *  刷新回调
 */
-(void)headerRefreshing{
    if (self.headerRefereshBlock) {
        self.headerRefereshBlock(self);
    }
}

- (void)dealloc{
    [self stopReferesh];
    if (_headerRefereshBlock) {
        _headerRefereshBlock = nil;
    }
    self.mj_header = nil;
}

@end
