//
//  UINavigationBar+CCAwesome.m
//  CloudProperty
//
//  Created by huangshupeng on 15/6/9.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "UINavigationBar+CCAwesome.h"
#import <objc/runtime.h>
#import "UIImage+CCImage.h"
#import "UIHeader.h"
@implementation UINavigationBar (CCAwesome)

static char overlayKey;
static char emptyImageKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)emptyImage
{
    return objc_getAssociatedObject(self, &emptyImageKey);
}

- (void)setEmptyImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &emptyImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 *  设置导航栏背景颜色
 *
 *  @param backgroundColor 颜色
 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}
/**
 *  偏移
 *
 *  @param translationY
 */
- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}
/**
 *  设置导航栏透明度
 *
 *  @param alpha 透明度
 */
- (void)lt_setContentAlpha:(CGFloat)alpha
{
    if (!self.overlay) {
        [self lt_setBackgroundColor:self.barTintColor];
    }
    [self setAlpha:alpha forSubviewsOfView:self];
    if (alpha == 1) {
        if (!self.emptyImage) {
            self.emptyImage = [UIImage new];
        }
        self.backIndicatorImage = self.emptyImage;
    }
}

- (void)setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if (subview == self.overlay) {
            continue;
        }
        subview.alpha = alpha;
        [self setAlpha:alpha forSubviewsOfView:subview];
    }
}
/**
 *  移除
 */
- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

/**
 *  设置导航栏文字的颜色和字体大小
 */
- (void)lt_setTitleTextColor:(UIColor *)textColor textFont:(UIFont *)textFont{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = textFont;
    
    dict[NSForegroundColorAttributeName] = textColor;
    [self setTitleTextAttributes:dict];
}
/**
 *  设置ShadowImage
 */
- (void)lt_setShadowImage:(UIImage *)image
{
    [self setShadowImage:image];
}
/**
 * 显示自定义view
 */
- (void)showView{
    self.shadowImage = [UIImage new];
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.overlay.hidden = NO;
}
/**
 * 隐藏自定义view
 */
- (void)hideView:(UIColor *)backBroundColor{
    self.shadowImage = [UIImage imageWithColor:UIColorFromHex(COLOR_E2E2E2) size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1/([UIScreen mainScreen].scale))];
    [self setBackgroundImage:[UIImage createImageWithColor:backBroundColor] forBarMetrics:UIBarMetricsDefault];
    self.overlay.hidden = YES;
}

@end
