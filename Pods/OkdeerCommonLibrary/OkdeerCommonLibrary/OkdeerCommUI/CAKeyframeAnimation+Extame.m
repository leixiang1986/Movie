//
//  CAKeyframeAnimation+Extame.m
//  CloudCity
//
//  Created by Mac on 16/1/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CAKeyframeAnimation+Extame.h"
#import "UIImage+CCImage.h"

@implementation CAKeyframeAnimation (Extame)

/**
 *  控件  放大  缩小    动画变回默认的状态   minValue 缩小最小的值  maxValue 放大到最大的值  currentValue  当前的值  spaceValue  变回的间距  duration 动画时间  repeatCount 重复的次数  （注  minValue maxValue currentValue 这里是控件的比例  例如 0.5 就是控件原来的一半）
 */
+ (CAKeyframeAnimation *)obtainAnimationToMinValue:(CGFloat)minValue maxValue:(CGFloat)maxValue currentValue:(CGFloat)currentValue spaceVaule:(CGFloat)spaceValue duration:(NSTimeInterval)duration repeatCount:(float)repeatCount
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
    
    BOOL canRun = YES;                // 是否循环  yes 为循环  no 跳出循环
    
    BOOL isAdd = YES;   // 是否加 还是减  yes 为加 no 为减
    [valuesArray  addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(currentValue,currentValue,1.0) ]];
    if (currentValue >= maxValue) {
        // 当前的值等于最大值  为减
        currentValue = maxValue;
        isAdd = NO;
    }else if (currentValue <= minValue){
        currentValue = minValue;
        isAdd = YES;
    }
    CGFloat nowValue = currentValue;   // 当前的值赋给临时的值
    if (isAdd) {
        nowValue = nowValue + spaceValue;
    }else{
        nowValue = nowValue - spaceValue;
    }
    while (canRun) {
        [valuesArray addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(nowValue, nowValue, 1.0)]];
        // 判断nowValue 等于最大的值  是 加  否则是否等于最小的值  为减
        if (nowValue >= maxValue) {
            nowValue = maxValue;
            isAdd = NO;
        }else if (nowValue <= minValue){
            nowValue = minValue;
            isAdd = YES;
        }
        
        if (isAdd) {
            nowValue = nowValue + spaceValue;
        }else{
            nowValue = nowValue - spaceValue;
        }
        // 判断 nowValue 是否等于当前的值 并且是加   跳出循环
        if (nowValue == currentValue  && isAdd) {
            canRun = NO;
        }else if ((nowValue == minValue || nowValue == maxValue) && nowValue == currentValue){
            // 判断 nowValue 是否等于 当前的值  并且  nowValue 等于最小值或等于最大值   跳出循环
            canRun = NO;
        }
        
    }
    [valuesArray addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(currentValue, currentValue, 1.0)]];
    animation.values = valuesArray;
    return animation;
}
/**
 *  控件的左右晃动   numberOfShakes 在时间内的晃动的次数  vigourOfShake 晃动幅度（相对于总宽度） durationOfShake 晃动延续时常（秒）
 */
+ (CAKeyframeAnimation *)obtionPositionTo:(int)numberOfShakes vigourOfShake:(float)vigourOfShake durationOfShake:(float)durationOfShake view:(UIView *)view
{
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint layerPosition = view.layer.position;
    
    NSValue *startVaulue = [NSValue valueWithCGPoint: view.layer.position];
    NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
    [valuesArray addObject:startVaulue];
    
    for (NSInteger i = 0 ; i < numberOfShakes; i ++ ) {
        CGFloat proportion = 1 - (float)i/ numberOfShakes;
        NSValue *valueLeft = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x - CGRectGetWidth(view.frame) * vigourOfShake * proportion, layerPosition.y)];
        NSValue *valueright = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x + CGRectGetWidth(view.frame) * vigourOfShake * proportion, layerPosition.y)];
        [valuesArray addObject:valueLeft];
        [valuesArray addObject:valueright];
    }
    [valuesArray addObject:startVaulue];
    moveAnimation.values = valuesArray;
    moveAnimation.duration = durationOfShake;
    moveAnimation.removedOnCompletion = YES;
    return moveAnimation;
}

/**
 *  曲线动画
 *
 *  @param startPoint    动画起点
 *  @param endpoint      动画终点
 *  @param view          动画的位置
 *  @param delegate      动画delegate
 *  @param completeBlock 回调
 */
+ (void)curveAnimationStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endpoint view:(UIView *)view delegate:(id)delegate layerFrame:(CGRect)layerFrame picImage:(UIImage *)picImage complete:(void (^)(CALayer *))completeBlock{
    
    CALayer  *layer = [CALayer layer];
    if ([picImage isKindOfClass:[UIImage class]]) {
         layer.contents = (__bridge id)picImage.CGImage;
    }else{
        layer.contents = (__bridge id)[UIImage imageWithColor:[UIColor colorWithRed:255.0/255.0f green:204.0f/255.0f blue:0.00f/255.0f alpha:1] size:CGSizeMake(8, 8)].CGImage;
        layer.cornerRadius = layerFrame.size.height / 2 ;
    }
    layer.frame = layerFrame;
    layer.opacity = 1;

    [view.layer addSublayer:layer];
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //动画起点
    [path moveToPoint:startPoint];
    //贝塞尔曲线控制点
    float sx = startPoint.x;
//    float sy = startPoint.y;
    float ex = endpoint.x;
    float ey = endpoint.y;
    float x =  (ex - sx ) /2.0f + sx;
    float y =  ey - ([UIApplication sharedApplication].statusBarFrame.size.height);
    CGPoint centerPoint= CGPointMake(x, y);
    [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
    
    
    CFTimeInterval duration = 1.00f ;
    //key frame animation to show the bezier path animation
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.removedOnCompletion = YES;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue  =[NSNumber numberWithFloat:0.4f];
    basicAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.animations = @[animation,basicAnimation];
    animationGroup.removedOnCompletion = YES;
    
    animationGroup.delegate = delegate;
  
    [layer addAnimation:animationGroup forKey:nil];
    if (completeBlock) {
        completeBlock(layer) ;
    }
   
}


@end
