//
//  CCAroundCarouselView.m
//  CloudCity
//
//  Created by JuGuang on 15/3/5.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import "CCAroundCarouselView.h"

#define widthAA 5

@interface CCAroundCarouselView ()

@property (nonatomic,strong) CCCustomLabel * nextActivitLabel;   //临时
@property (nonatomic,strong)  NSTimer *timer ;
@property (nonatomic,strong)  UIView *leftView;
@property (nonatomic,strong)  UIView *rightView;
@end

@implementation CCAroundCarouselView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame] ;
    if (self) {
        _nameColor = [UIColor blackColor];
        _leftSpace = widthAA;
        _rightSpace = widthAA;
        [self creatUI];
    }
    return self;
}
#pragma mark -创建UI
- (void)creatUI{
    _activitLabel_ = [[CCCustomLabel alloc] initWithFrame:CGRectMake( _leftSpace, 0, self.frame.size.width - _leftSpace - _rightSpace , self.frame.size.height)];
    _activitLabel_.textColor = _nameColor ;
    _activitLabel_.font = [UIFont systemFontOfSize:12];
    _activitLabel_.backgroundColor = [UIColor clearColor];
    [self addSubview:_activitLabel_];
    //左边显示的一点空白
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _leftSpace, self.frame.size.height)];
    self.leftView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.leftView];
    
    //右边显示的一点空白
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - _rightSpace, 0, CGRectGetWidth(self.leftView.frame), CGRectGetHeight(self.leftView.frame))];
    self.rightView.backgroundColor = [UIColor clearColor] ;
    [self addSubview:self.rightView];
    [self.leftView.superview bringSubviewToFront:self.leftView];
    [self.rightView.superview bringSubviewToFront:self.rightView];
    self.layer.masksToBounds = YES;
}

#pragma mark -重写
- (void)setNameStr:(NSString *)nameStr{
    if (_nameStr != nameStr) {
        _nameStr = nil ;
        _nameStr = nameStr ;
        _activitLabel_.frame = CGRectMake(_leftSpace, 0, self.frame.size.width - _leftSpace - _rightSpace , self.frame.size.height);
        _activitLabel_.text = _nameStr;
        _activitLabel_.frame = [_activitLabel_ calculate:YES];
        
        if (self.nextActivitLabel) {
            self.nextActivitLabel.frame = CGRectMake(CGRectGetMaxX(_activitLabel_.frame), CGRectGetMinY(_activitLabel_.frame), CGRectGetWidth(_activitLabel_.frame), CGRectGetHeight(_activitLabel_.frame))  ;
        }
        [self startTimer];
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _activitLabel_.frame = CGRectMake( _leftSpace, 0, self.frame.size.width - _leftSpace - _rightSpace , self.frame.size.height);
    self.leftView.frame = CGRectMake(0, 0, _leftSpace, self.frame.size.height);
    self.rightView.frame = CGRectMake(self.frame.size.width - _rightSpace, 0, CGRectGetWidth(self.leftView.frame), CGRectGetHeight(self.leftView.frame));
    _activitLabel_.frame = [_activitLabel_ calculate:YES];
    if (self.nextActivitLabel) {
        self.nextActivitLabel.frame = CGRectMake(CGRectGetMaxX(_activitLabel_.frame), CGRectGetMinY(_activitLabel_.frame),CGRectGetWidth(_activitLabel_.frame), CGRectGetHeight(_activitLabel_.frame))  ;
    }

}

- (void)setNameColor:(UIColor *)nameColor{
    _nameColor = nameColor;
    _activitLabel_.textColor = _nameColor ;
    self.nextActivitLabel.textColor = _nameColor;
}


/**
 *  倒计时 过程中
 */
- (void)acttimeRun{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect oldFrame = _activitLabel_.frame ;
        oldFrame.origin.x = oldFrame.origin.x - 1 ;
        _activitLabel_.frame = oldFrame ;
        CGRect oldFrame1 = self.nextActivitLabel.frame;
        oldFrame1.origin.x =  CGRectGetMaxX(_activitLabel_.frame) ;
        self.nextActivitLabel.frame = oldFrame1;
    } completion:^(BOOL finished) {
        if (CGRectGetMinX(_activitLabel_.frame) < -CGRectGetWidth(_activitLabel_.frame)) {
            _activitLabel_.hidden = YES;
            CGRect oldFrame = _activitLabel_.frame ;
            oldFrame.origin.x = _leftSpace ;
            _activitLabel_.frame = oldFrame;
            _activitLabel_.hidden = NO;
            self.nextActivitLabel.hidden = YES;
            CGRect oldFrame1 = self.nextActivitLabel.frame;
            oldFrame1.origin.x = CGRectGetMaxX(_activitLabel_.frame);
            self.nextActivitLabel.frame = oldFrame1;
            self.nextActivitLabel.hidden = NO;
        }
    }];
}

/**
 *  开始计时
 */
- (void)startTimer{
    //判断lable的宽度 是否超过当前的view
    //  超过  启动计时器  启动文字左右轮播
    if ( CGRectGetWidth(_activitLabel_.frame) > self.frame.size.width - _leftSpace - _rightSpace) {
        if (!self.nextActivitLabel) {
            _nextActivitLabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_activitLabel_.frame), CGRectGetMinY(_activitLabel_.frame), CGRectGetWidth(_activitLabel_.frame), CGRectGetHeight(_activitLabel_.frame)) ] ;
            _nextActivitLabel.textColor = _activitLabel_.textColor ;
            _nextActivitLabel.font = _activitLabel_.font ;
            _nextActivitLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:_nextActivitLabel];
        }
        _nextActivitLabel.text = _activitLabel_.text;
        _nextActivitLabel.hidden = NO;
        if (!_timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(acttimeRun) userInfo:nil repeats:YES] ;
        }
        _isRunning = YES;

        [_leftView.superview bringSubviewToFront:_leftView];
        [_rightView.superview bringSubviewToFront:_rightView];
    }
    else{
        _isRunning = NO;
        _activitLabel_.text = _nameStr;
        if (_nextActivitLabel) {
            _nextActivitLabel.text = @"";
            _nextActivitLabel.hidden = YES;
        }

        [self stopTimer] ;
        _activitLabel_.frame = CGRectMake( _leftSpace, 0, self.frame.size.width - _leftSpace - _rightSpace , self.frame.size.height);   //在个人中心，如果先设置了一个长的昵称，提交后再设置为短的，名称会跑偏
    }
}
/**
 *  停止计时
 */
- (void)stopTimer{
    [self.timer invalidate];
    self.timer  = nil;
    _isRunning = NO;
}

- (void)dealloc
{
    [self stopTimer] ;
}

@end
