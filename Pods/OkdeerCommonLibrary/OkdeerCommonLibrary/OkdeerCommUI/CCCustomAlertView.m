//
//  CCCustomAlertView.m
//  CloudMall
//
//  Created by JuGuang on 14/11/15.
//  Copyright (c) 2014年 JuGuang. All rights reserved.
//

#import "CCCustomAlertView.h"


@implementation CCCustomAlertView{
    UIAlertView *_customAlertView;    //弹出框
    
}
/**
 设置提示标题  内容  代理  按钮标题
 @parm title  标题
 @parm message  内容
 @parm delegate  代理
 @parm canceButtonTitle  按钮标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andDelegate:(id)delegate andCanceButtonTitle:(NSString *)canceButtonTitle{
    if (!_customAlertView) {
        _customAlertView = [self initWithTitle:title message:message delegate:delegate cancelButtonTitle:canceButtonTitle otherButtonTitles:nil, nil];
    }else{
        _customAlertView.title = title;
        _customAlertView.message = message;
    }
   
}

/**
 自定义设置弹出提示框  自定义设置弹出提示框 自动隐藏
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm timer  多少秒后隐藏
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andhideAlertViewTimeOut:(CGFloat)timer{
    [self setAlertViewTitle:title andMessage:message andDelegate:nil andCanceButtonTitle:nil];
    [self performSelector:@selector(dismissAlertView:) withObject:_customAlertView afterDelay:timer];
    [self showAlertView];
}

/**
 *  设置自动隐藏的AlertView,并传递delegate(在切换不同控制器时，非本控制器的alertview 不显示)
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andhideAlertViewTimeOut:(CGFloat)timer delegate:(id)delegate {
    [self setAlertViewTitle:title andMessage:message andDelegate:delegate andCanceButtonTitle:nil];
    [self performSelector:@selector(dismissAlertView:) withObject:_customAlertView afterDelay:timer];
    [self showAlertView];
}


/**
 *  自定义设置弹出提示框  自定义设置弹出提示框 可自动隐藏也可手动关闭
 *
 *  @param title       提示框的标题
 *  @param message     提示框的内容
 *  @param cancelTitle 取消按钮title
 *  @param timer       多少秒后隐藏
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle andhideAlertViewTimeOut:(CGFloat)timer{
    [self setAlertViewTitle:title andMessage:message andDelegate:nil andCanceButtonTitle:cancelTitle];
    [self performSelector:@selector(dismissAlertView:) withObject:_customAlertView afterDelay:timer];
    [self showAlertView];
}

/**
 自定义设置弹出提示框  需要手动隐藏  并且调用代理
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm delegate  点击按钮代理
 @parm buttonTitle 按钮的标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andDelegate:(id)delegate andButtonTitle:(NSString *)buttonTitle{
    [self setAlertViewTitle:title andMessage:message andDelegate:delegate andCanceButtonTitle:buttonTitle];
    [self showAlertView];
}

/**
 自定义设置弹出提示框  需要手动隐藏 和多个按钮 并且调用代理
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm delegate  点击按钮代理
 @parm canceButtonTitle 取消按钮的标题
 @parm buttonTitleArray 其他按钮的标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andDelegate:(id)delegate andCanceButtonTitle:(NSString *)canceButtonTitle andButtonTitleArray:(NSArray *)buttonTitleArray{
    [self setAlertViewTitle:title andMessage:message andDelegate:delegate andCanceButtonTitle:canceButtonTitle];
    for (NSInteger i = 0 ; i < buttonTitleArray.count ; i ++ ) {
        [_customAlertView addButtonWithTitle:[buttonTitleArray objectAtIndex:i]];
    }
    [self showAlertView];
}

/**
 自定义设置弹出提示框  手动隐藏
 @parm title  提示框的标题
 @parm message  提示框的内容
 @parm buttonTitle 按钮的标题
 */
- (void)setAlertViewTitle:(NSString *)title andMessage:(NSString *)message andButtonTitle:(NSString *)buttonTitle{
    [self setAlertViewTitle:title andMessage:message andDelegate:nil andCanceButtonTitle:buttonTitle];
    [self showAlertView];
}

//显示提示框
- (void)showAlertView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_customAlertView show];
    });
}

//隐藏提示框
- (void)dismissAlertView:(UIAlertView *)alertView{
    if (alertView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
        });
    }
}
- (void)dealloc {
    _customAlertView = nil;
}
@end
