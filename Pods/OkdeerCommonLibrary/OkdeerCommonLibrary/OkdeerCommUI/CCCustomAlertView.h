//
//  CCCustomAlertView.h
//  CloudMall
//
//  Created by JuGuang on 14/11/15.
//  Copyright (c) 2014年 JuGuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCustomAlertView : UIAlertView

/**
 自定义设置弹出提示框 自动隐藏
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm timer  多少秒后隐藏
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andhideAlertViewTimeOut:(CGFloat)timer;
/**
 自定义设置弹出提示框  需要手动隐藏  并且调用代理
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm delegate  点击按钮代理
 @parm buttonTitle 按钮的标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andDelegate:(id)delegate andButtonTitle:(NSString *)buttonTitle;
/**
 自定义设置弹出提示框  需要手动隐藏 和多个按钮 并且调用代理
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm delegate  点击按钮代理
 @parm canceButtonTitle 取消按钮的标题
 @parm buttonTitleArray 其他按钮的标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andDelegate:(id)delegate andCanceButtonTitle:(NSString *)canceButtonTitle andButtonTitleArray:(NSArray *)buttonTitleArray;
/**
 自定义设置弹出提示框  手动隐藏
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm buttonTitle 按钮的标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andButtonTitle:(NSString *)buttonTitle;

/**
 *  自定义设置弹出提示框  自定义设置弹出提示框 可自动隐藏也可手动关闭
 *
 *  @param title       提示框的标题
 *  @param message     提示框的内容
 *  @param cancelTitle 取消按钮title
 *  @param timer       多少秒后隐藏
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle andhideAlertViewTimeOut:(CGFloat)timer;
/**
 *  取消alertView
 *
 *  @param alertView  alertView
 */
- (void)dismissAlertView:(UIAlertView *)alertView;

/**
 *  设置自动隐藏的AlertView,并传递delegate
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andhideAlertViewTimeOut:(CGFloat)timer delegate:(id)delegate;

@end
