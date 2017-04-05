//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshNormalHeader.h"
#import "UIHeader.h"

@interface MJRefreshNormalHeader()
{
    __unsafe_unretained UIImageView *_arrowView;
}

@property (nonatomic, strong) CALayer *oneCircleLayer;      //第一个球
@property (nonatomic, strong) CALayer *twoCircleLayer;      //第二个球
@property (nonatomic, strong) CABasicAnimation *oneBasicAnimation;  //第一个球动画
@property (nonatomic, strong) CABasicAnimation *twoBasicAnimation;  //第二个球动画

@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
//        UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"arrow.png")] ?: [UIImage imageNamed:MJRefreshFrameworkSrcName(@"arrow.png")];
//        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
//        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

//第一个圆
- (CALayer *)oneCircleLayer
{
    if (!_oneCircleLayer) {
        _oneCircleLayer = [CALayer layer];
        _oneCircleLayer.frame = CGRectMake((CGRectGetWidth(self.frame) - 50.0) * 0.5, (self.mj_h - 20.f)*0.5 , 20.f, 20.f);
        _oneCircleLayer.backgroundColor = UIColorFromHex(0xDF5356).CGColor;
        _oneCircleLayer.cornerRadius = 10.f;
        _oneCircleLayer.hidden = YES;
        [self.layer addSublayer:_oneCircleLayer];
    }
    return _oneCircleLayer;
}
//第二个圆
- (CALayer *)twoCircleLayer
{
    if (!_twoCircleLayer) {
        _twoCircleLayer = [CALayer layer];
        _twoCircleLayer.frame = CGRectMake(CGRectGetMaxX(self.oneCircleLayer.frame)+10.0, (self.mj_h - 20.f)*0.5 , 20.f, 20.f);
        _twoCircleLayer.backgroundColor = UIColorFromHex(0xECAB41).CGColor;
        _twoCircleLayer.cornerRadius = 10.f;
        _twoCircleLayer.hidden = YES;
        [self.layer addSublayer:_twoCircleLayer];
    }
    return _twoCircleLayer;
}
//第一个圆动画
- (CABasicAnimation *)oneBasicAnimation
{
    if (!_oneBasicAnimation) {
        _oneBasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _oneBasicAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        _oneBasicAnimation.toValue = [NSNumber numberWithFloat:1.3];
        _oneBasicAnimation.autoreverses = YES;
        _oneBasicAnimation.fillMode = kCAFillModeForwards;
        _oneBasicAnimation.repeatCount = MAXFLOAT;
    }
    return _oneBasicAnimation;
}
//第二个圆动画
- (CABasicAnimation *)twoBasicAnimation
{
    if (!_twoBasicAnimation) {
        _twoBasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _twoBasicAnimation.fromValue = [NSNumber numberWithFloat:1.3];
        _twoBasicAnimation.toValue = [NSNumber numberWithFloat:1.0];
        _twoBasicAnimation.autoreverses = YES;
        _twoBasicAnimation.fillMode = kCAFillModeForwards;
        _twoBasicAnimation.repeatCount = MAXFLOAT;
    }
    return _twoBasicAnimation;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
//    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)stateLabelHidden
{
    self.stateLabel.hidden = YES;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    //隐藏statelabel
    self.stateLabel.hidden = YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.oneCircleLayer.frame = CGRectMake((CGRectGetWidth(self.frame) - 50.0) * 0.5, (self.mj_h - 20.f)*0.5 , 20.f, 20.f);
    self.twoCircleLayer.frame = CGRectMake(CGRectGetMaxX(self.oneCircleLayer.frame)+10.0, (self.mj_h - 20.f)*0.5 , 20.f, 20.f);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            [self stopAnimation];
            self.stateLabel.hidden = NO;
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.stateLabel.text = @"刷新完成";
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                //延迟hidden
                [self performSelector:@selector(stateLabelHidden) withObject:nil afterDelay:0.6];
                if (self.state != MJRefreshStateIdle) return;
            }];
        } else {
            self.stateLabel.hidden = YES;
            [self stopAnimation];
        }
    } else if (state == MJRefreshStatePulling) {
        
        self.stateLabel.hidden = YES;
        [self stopAnimation];
    } else if (state == MJRefreshStateRefreshing) {
        
        self.stateLabel.hidden = YES;
        [self addAnimation];
    }
}


#pragma mark - /*** 本身动画相关 ***/
/**
 *  加动画
 */
- (void)addAnimation
{
    self.oneCircleLayer.hidden = NO;
    self.twoCircleLayer.hidden = NO;
    [self.oneCircleLayer addAnimation:self.oneBasicAnimation forKey:@"ONEscaleAnimation"];
    [self.twoCircleLayer addAnimation:self.twoBasicAnimation forKey:@"TWOscaleAnimation"];
}

/**
 *  移除动画
 */
- (void)stopAnimation
{
    self.oneCircleLayer.hidden = YES;
    self.twoCircleLayer.hidden = YES;
    [self.oneCircleLayer removeAllAnimations];
    [self.twoCircleLayer removeAllAnimations];
}

@end
