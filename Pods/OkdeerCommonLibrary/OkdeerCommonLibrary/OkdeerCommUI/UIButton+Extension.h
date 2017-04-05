//
//  UIButton+Extension.h
//  CloudCity
//
//  Created by Mac on 15/6/30.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(Extension)


- (void)imgModeScaleAspectFill;

- (void)setStateNormalImage:(UIImage *)nImg highlightedImage:(UIImage *)hImg;
/**
 *  初始化一个按钮 没有边框的 背景颜色是蓝色的  椭圆
 */
+ (UIButton *)buttonTitle:(NSString *)title target:(id)target action:(SEL)action;
/**
 *  创建一个button 按钮size为 25*25 实际图片大小为17.5*17.5 UI要求
 *
 */
+ (UIButton *)buttonMustItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

/**
 *  创建一个BarButtonItem按照指定的大小
 *
 *  @param image     正常下的图片
 *  @param highImage 高亮下的图片
 *  @param target    target
 *  @param action    回调
 *
 */
+ (instancetype)buttonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage size:(CGSize)size target:(id)target action:(SEL)action;
@end
