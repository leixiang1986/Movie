//
//  CCNoDataView.h
//  OkdeerUser
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCNoDataView : UIView

/**
 *  加载错误的页面上的数据
 *
 *  @param text  文字
 *  @param image 图片
 */
- (void)loadText:(NSString *)text image:(UIImage *)image;

/**
 * 获取最底部的UIView
 */
- (UIView *)obtainBottomView;


+ (instancetype)initWithText:(NSString *)text image:(UIImage *)image inSuperView:(UIView *)superView show:(BOOL)show;

/**
 *  加载默认文字和图片
 *
 *  @param superView 父view
 */
+ (instancetype)showWithDefaultInSuperView:(UIView *)superView show:(BOOL)show;

/**
 *  隐藏
 */
- (void)hide;

@end
