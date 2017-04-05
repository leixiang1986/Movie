//
//  CAKeyframeAnimation+Extame.h
//  CloudCity
//
//  Created by Mac on 16/1/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAKeyframeAnimation (Extame)

/**
 *  控件  放大  缩小    动画变回默认的状态   minValue 缩小最小的值  maxValue 放大到最大的值  currentValue  当前的值  spaceValue  变回的间距  duration 动画时间  repeatCount 重复的次数  （注  minValue maxValue currentValue 这里是控件的比例  例如 0.5 就是控件原来的一半）
 */
+ (CAKeyframeAnimation *)obtainAnimationToMinValue:(CGFloat)minValue maxValue:(CGFloat)maxValue currentValue:(CGFloat)currentValue spaceVaule:(CGFloat)spaceValue duration:(NSTimeInterval)duration repeatCount:(float)repeatCount;
/**
 *  控件的左右晃动   numberOfShakes 在时间内的晃动的次数  vigourOfShake 晃动幅度（相对于总宽度） durationOfShake 晃动延续时常（秒）
 */
+ (CAKeyframeAnimation *)obtionPositionTo:(int)numberOfShakes vigourOfShake:(float)vigourOfShake durationOfShake:(float)durationOfShake view:(UIView *)view;

/**
 *  曲线动画
 *
 *  @param startPoint    动画起点
 *  @param endpoint      动画终点
 *  @param view          动画的位置
 *  @param delegate      动画delegate
 *  @param completeBlock 回调
 */
+ (void)curveAnimationStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endpoint view:(UIView *)view delegate:(id)delegate layerFrame:(CGRect)layerFrame picImage:(UIImage *)picImage complete:(void(^) (CALayer *layer))completeBlock ;

@end
