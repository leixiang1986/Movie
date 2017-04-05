//
//
//  CustomNavigationbar
//
//  Created by 雷祥 on 14-12-17.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  NSNotificationCenter
 *  首页和我的首页present控制器时的通知
 *  捕捉此通知即可,
 */
FOUNDATION_EXPORT NSString *const kHOMEORMINEVCPRESENTVC;

@interface CCBaseViewController : UIViewController

@property (nonatomic, assign, getter=isWillDisappear) BOOL willDisappear;       /**< 控制器是否即将消失 */
@property (nonatomic, copy) void (^gestureShouldPopBlock)(void);                /**< 手势返回的block */


//点击返回的方法，子类继承，在子类中写需要添加的内容
-(void)backBtnClick:(id)sender;//暴露外部方法，以便子类继承

/**
 *  改变相应的高度     状态栏改变会执行此方法
 */
- (void)changeAppFrame ;
/**
 * IP改变的通知
 */
- (void)ipChangeNotification;

/**
 *  textField改变调用的方法
 */
-(void)textFieldTextDidChange:(NSNotification *)notify;

/**
 *  textView改变调用的方法
 */
- (void)textViewTextDidChange:(NSNotification *)notify;

/**< 更新数据 */
- (void)upDateData;
/**
 *  执行跳转  具体操作由子类进行操作
 *
 *  @param currentVC 当前的控制器
 *  @param objc  控制器需要的参数
 */
+ (void)controllerPush:(UIViewController *)currentVC objc:(id )objc;
@end
