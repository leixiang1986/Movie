//
//  UINavigationBar+CCAwesome.h
//  CloudProperty
//
//  Created by huangshupeng on 15/6/9.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CCAwesome)
/**
 *  设置导航栏背景颜色
 *
 *  @param backgroundColor 颜色
 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
/**
 *  设置导航栏透明度
 *
 *  @param alpha 透明度
 */
- (void)lt_setContentAlpha:(CGFloat)alpha;
/**
 *  偏移
 *
 *  @param translationY     translationY
 */
- (void)lt_setTranslationY:(CGFloat)translationY;
/**
 *  移除
 */
- (void)lt_reset;
/**
 *  设置导航栏文字的颜色和字体大小
 */
- (void)lt_setTitleTextColor:(UIColor *)textColor textFont:(UIFont *)textFont;
/**
 *  设置ShadowImage
 */
- (void)lt_setShadowImage:(UIImage *)image;
/**
 * 显示自定义view
 */
- (void)showView;
/**
 * 隐藏自定义view
 */
- (void)hideView:(UIColor *)backBroundColor;

@end
