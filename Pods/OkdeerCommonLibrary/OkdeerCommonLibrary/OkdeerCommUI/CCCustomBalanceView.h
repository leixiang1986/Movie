//
//  CustomBalanceView.h
//  CloudCity
//
//  Created by JuGuang on 15/2/9.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCCustomBalanceView;

typedef void(^ClickButtonBlock)( CCCustomBalanceView *view,BOOL ret,NSString *passWord);   /**< 点击回调 */

@interface CCCustomBalanceView : UIView

/**
 *  初始化
 */
- (instancetype)initWithPrice:(NSString *)price clickBlock:(ClickButtonBlock)clickBlock;

/**
 *  展示
 */
- (void)showView;
/**
 *   隐藏
 */
- (void)hideView;


@end
