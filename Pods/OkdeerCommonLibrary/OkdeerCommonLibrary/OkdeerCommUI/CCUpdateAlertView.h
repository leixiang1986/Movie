//
//  CCUpdateAlertView.h
//  CloudMall
//
//  Created by huangshupeng on 15/9/7.
//  Copyright (c) 2015年 CloudCity. All rights reserved.
//
// 更新的提示框
#import <UIKit/UIKit.h>
@protocol CCUpdateAlertViewDelegate;
@interface CCUpdateAlertView : UIView

/**
 *  初始化 控件 UI
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message currentVersion:(NSString *)currentVersion lastVersion:(NSString *)lastVersion canceButtonTitle:(NSString *)canceButtonTitle doneButtonTitle:(NSString *)doneButtonTitle delegate:(id)delegate;

@property (nonatomic,assign)id<CCUpdateAlertViewDelegate>  delegate;
/**
 *   获取位置
 */
- (NSInteger)buttonWithTitle:(NSString *)title;
/**
 *  获取标题
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;
/**
 *  展示
 */
- (void)show;
@end

@protocol CCUpdateAlertViewDelegate <NSObject>
@optional
- (void)updateAlertView:(CCUpdateAlertView *)updateAlertView clickButtonIndex:(NSInteger )buttonIndex ;

@end
