//
//  UIView+MJ.h
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+RoundedCorner.h"

@interface UIView (CCView)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@property (nonatomic,assign) CGFloat bottom;  //底部
@property (nonatomic,assign) CGFloat top;     //顶部
@property (nonatomic,assign) CGFloat left;    //左边
@property (nonatomic,assign) CGFloat right;   //右边
@property (nonatomic,assign) CGFloat width;   //宽度
@property (nonatomic,assign) CGFloat height;  //高度

/**
 *  系统的设置圆角方法
 *
 *  @param corneradius 圆角半径
 *  @param borderColor 边框颜色
 *  @param borderWidth 边框宽度
 */
- (void)setSystemCorneradius:(CGFloat)corneradius withColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;

/*
 设置圆角
 corneradius 圆角半径
 borderColor 边界颜色
 borderWidth 边界宽度
 */
- (void)setCorneradius:(CGFloat)corneradius withColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;
/**
 *  设置圆角
 */
- (void)setupCorneradius:(CGFloat)corneradius;
/**
 *  设置圆角  用UIBezierPath 画的
 */
- (void)setupBezierCorneradius:(CGFloat)corneradius;

/**
 *  设置边框
 */
- (void)setupborderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  设置自身背景渐变色
 *
 *  @param frame      frame
 *  @param colors     渐变色的数组，包含的元素为CGColor，数组包含的是对象要转化为id类型。（(id)[[[UIColor blackColor] colorWithAlphaComponent:1]CGColor]）
 *  @param locations  位置数组，各渐变色的位置，［0-1］
 *  @param beginPoint 起始点
 *  @param endPoint   结束点
 *
 *  @return 返回渐变层
 */
+ (CAGradientLayer *)gradientLayerWithFrame:(CGRect)frame withColors:(NSArray<id> *)colors withLocations:(NSArray <NSNumber *>*)locations withBeginPoint:(CGPoint)beginPoint withEndPoint:(CGPoint)endPoint;

/**
 *  创建导航栏的状态栏
 */
+ (UIView *)setupBarStatueView;

/**给view设置一个圆角边框*/
- (void)setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**给view设置一个圆角边框,四个圆角弧度可以不同*/
- (void)setJMRadius:(JMRadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


/**给view设置一个圆角背景颜色*/
- (void)setCornerRadius:(CGFloat)radius withBackgroundColor:(UIColor *)backgroundColor;

/**给view设置一个圆角背景颜色,四个圆角弧度可以不同*/
- (void)setJMRadius:(JMRadius)radius withBackgroundColor:(UIColor *)backgroundColor;


/**给view设置一个圆角背景图*/
- (void)setCornerRadius:(CGFloat)radius withImage:(UIImage *)image;

///**给view设置一个圆角背景图,四个圆角弧度可以不同*/
- (void)setJMRadius:(JMRadius)radius withImage:(UIImage *)image;


/**给view设置一个contentMode模式的圆角背景图*/
- (void)setCornerRadius:(CGFloat)radius withImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode;

///**给view设置一个contentMode模式的圆角背景图,四个圆角弧度可以不同*/
- (void)setJMRadius:(JMRadius)radius withImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode;


/**设置所有属性配置出一个圆角背景图*/
- (void)setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode;

/**设置所有属性配置出一个圆角背景图,四个圆角弧度可以不同*/
- (void)setJMRadius:(JMRadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode;

/**设置所有属性配置出一个圆角背景图，并多传递了一个size参数，如果JMRoundedCorner没有拿到view的size，可以调用这个方法*/
- (void)setJMRadius:(JMRadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode size:(CGSize)size;


/**
 *  抖动
 */
-(void)shakeView;

@end
