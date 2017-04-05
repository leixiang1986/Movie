//
//  UIView+MJ.m
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIView+CCView.h"
#import "CCCategorHeader.h"
@implementation UIView (CCView)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
-(CGFloat)top{
    return self.frame.origin.y;
}

-(CGFloat)bottom{
    return self.frame.size.height + self.frame.origin.y;
}

-(CGFloat)left{
    return self.frame.origin.x;
}

-(CGFloat)right{
    return self.frame.size.width + self.frame.origin.x;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setTop:(CGFloat)top{
    self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

-(void)setLeft:(CGFloat)left{
    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setBottom:(CGFloat)bottom{
    self.frame = CGRectMake(self.frame.origin.x, bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

-(void)setRight:(CGFloat)right{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, right - self.frame.size.width, self.frame.size.height);
}

-(void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

/**
 *  系统的设置圆角方法
 *
 *  @param corneradius 圆角半径
 *  @param borderColor 边框颜色
 *  @param borderWidth 边框宽度
 */
- (void)setSystemCorneradius:(CGFloat)corneradius withColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth {
    self.layer.cornerRadius = corneradius;
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    if (borderWidth) {
        self.layer.borderWidth = borderWidth;
    }
    self.layer.masksToBounds = YES;
}


/*
 设置圆角
 corneradius 圆角半径
 borderColor 边界颜色
 borderWidth 边界宽度
 */
- (void)setCorneradius:(CGFloat)corneradius withColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth {
    [self setupCorneradius:corneradius];
    [self setupborderWidth:borderWidth borderColor:borderColor];
}
/**
 *  设置圆角
 */
- (void)setupCorneradius:(CGFloat)corneradius
{
    self.layer.cornerRadius = corneradius;
    self.layer.masksToBounds = YES;
}

/**
 *  设置圆角  用UIBezierPath 画的
 */
- (void)setupBezierCorneradius:(CGFloat)corneradius
{
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corneradius];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
}

/**
 *  设置边框
 */
- (void)setupborderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.borderWidth = borderWidth;
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

/**
 *  创建导航栏的状态栏
 */
+ (UIView *)setupBarStatueView
{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ([UIScreen mainScreen].bounds.size.width), 20)];
    statusBarView.backgroundColor = UIColorFromHex(COLOR_FAFAFA);
    return statusBarView;
}

/**
 *  设置自身背景渐变色
 *
 *  @param colors       渐变色的数组，包含的元素为CGColor，数组包含的是对象要转化为id类型。（(id)[[[UIColor blackColor] colorWithAlphaComponent:1]CGColor]）
 *  @param locations    位置数组，各渐变色的位置，［0-1］
 *  @param beginPoint   起始点
 *  @param endPoint     结束点
 */
+ (CAGradientLayer *)gradientLayerWithFrame:(CGRect)frame withColors:(NSArray<id> *)colors withLocations:(NSArray <NSNumber *>*)locations withBeginPoint:(CGPoint)beginPoint withEndPoint:(CGPoint)endPoint {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    CGRect newGradientLayerFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    gradientLayer.frame = newGradientLayerFrame;
    //添加渐变的颜色组合
    if (colors.count) { //有颜色才设置，否则结束
        gradientLayer.colors = colors;
    }
    else {
        return nil;
    }

    if (locations.count) {
        gradientLayer.locations = locations;
    }
    gradientLayer.startPoint = beginPoint;
    gradientLayer.endPoint = endPoint;
    //例如
//    gradientLayer.startPoint = CGPointMake(0,0);
//    gradientLayer.endPoint = CGPointMake(1,1);
    return gradientLayer;
}

#pragma mark - *** 离屏渲染处理 by chenzl copy from github  ***
- (void)setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    [self setCornerRadius:radius withBorderColor:borderColor borderWidth:borderWidth backgroundColor:nil backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
}

- (void)setJMRadius:(JMRadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    [self setJMRadius:radius withBorderColor:borderColor borderWidth:borderWidth backgroundColor:nil backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
}

- (void)setCornerRadius:(CGFloat)radius withBackgroundColor:(UIColor *)backgroundColor {
    
    [self setCornerRadius:radius withBorderColor:nil borderWidth:0 backgroundColor:backgroundColor backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
}

- (void)setJMRadius:(JMRadius)radius withBackgroundColor:(UIColor *)backgroundColor {
    
    [self setJMRadius:radius withBorderColor:nil borderWidth:0 backgroundColor:backgroundColor backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
}

- (void)setCornerRadius:(CGFloat)radius withImage:(UIImage *)image {
    
    [self setCornerRadius:radius withBorderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:image contentMode:UIViewContentModeScaleAspectFill];
}

- (void)setJMRadius:(JMRadius)radius withImage:(UIImage *)image {
    
    [self setJMRadius:radius withBorderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:image contentMode:UIViewContentModeScaleAspectFill];
}

- (void)setCornerRadius:(CGFloat)radius withImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    
    [self setCornerRadius:radius withBorderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:image contentMode:contentMode];
}

- (void)setJMRadius:(JMRadius)radius withImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    
    [self setJMRadius:radius withBorderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:image contentMode:contentMode];
}

- (void)setCornerRadius:(CGFloat)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode {
    
    [self setJMRadius:JMRadiusMake(radius, radius, radius, radius) withBorderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor backgroundImage:backgroundImage contentMode:contentMode];
}

- (void)setJMRadius:(JMRadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode {
    
    [self setNeedsLayout];
    NSValue *radiusValue = [NSValue valueWithBytes:&radius objCType:@encode(JMRadius)];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"radius"] = radiusValue;
    
    if (borderColor)
        dic[@"borderColor"] = borderColor;
    else
        dic[@"borderColor"] = NSNull.null;
    
    dic[@"borderWidth"] = [NSNumber numberWithFloat:borderWidth];
    
    if (backgroundColor)
        dic[@"backgroundColor"] = backgroundColor;
    else
        dic[@"backgroundColor"] = NSNull.null;

    if (backgroundImage)
        dic[@"backgroundImage"] = backgroundImage;
    else
        dic[@"backgroundImage"] = NSNull.null;
    
    dic[@"contentMode"] = [NSNumber numberWithFloat:contentMode];
    
    [self performSelector:@selector(setRadius:) withObject:dic afterDelay:0 inModes:@[NSRunLoopCommonModes]];
}

- (void)setRadius:(NSMutableDictionary *)dic {
    
    JMRadius radius;
    [dic[@"radius"] getValue:&radius];
    UIColor *borderColor;
    UIColor *backgroundColor;
    UIImage *backgroundImage;
    
    if (dic[@"borderColor"] == NSNull.null)
        borderColor = nil;
    else
        borderColor = dic[@"borderColor"];
    
    if (dic[@"backgroundColor"] == NSNull.null)
        backgroundColor = nil;
    else
        backgroundColor = dic[@"backgroundColor"];
    
    if (dic[@"backgroundImage"] == NSNull.null)
        backgroundImage = nil;
    else
        backgroundImage = dic[@"backgroundImage"];
    
    [self setJMRadius:radius withBorderColor:borderColor borderWidth:[dic[@"borderWidth"] floatValue] backgroundColor:backgroundColor backgroundImage:backgroundImage contentMode:[dic[@"contentMode"] integerValue] size:self.bounds.size];
}

- (void)setJMRadius:(JMRadius)radius withBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage contentMode:(UIViewContentMode)contentMode size:(CGSize)size {
    if (size.width == 0 || size.height == 0) {
       
        return;
    }
    size = CGSizeMake(pixel(size.width), pixel(size.height));
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [UIImage jm_imageWithRoundedCornersAndSize:size JMRadius:radius borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor backgroundImage:backgroundImage withContentMode:contentMode];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.frame = CGRectMake(pixel(self.frame.origin.x), pixel(self.frame.origin.y), size.width, size.height);
            if ([self isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)self).image = image;
            } else if ([self isKindOfClass:[UIButton class]] && backgroundImage) {
                [((UIButton *)self) setBackgroundImage:image forState:UIControlStateNormal];
            } else if ([self isKindOfClass:[UILabel class]]) {
                self.layer.backgroundColor = [UIColor colorWithPatternImage:image].CGColor;
            } else {
                self.layer.contents = (__bridge id _Nullable)(image.CGImage);
            }
        });
    });
}

extern float pixel(float num) {
    
    float unit = 1.0 / [UIScreen mainScreen].scale;
    double remain = fmod(num, unit);
    return num - remain + (remain >= unit / 2.0? unit: 0);
}


/**
 *  抖动
 *
 *  @param viewToShake
 */
-(void)shakeView
{
    CGFloat t =5.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    self.transform = translateLeft;

    [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.04 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}


@end
