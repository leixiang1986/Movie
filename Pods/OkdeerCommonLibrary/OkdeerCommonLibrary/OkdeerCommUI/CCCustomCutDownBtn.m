//
//  CCCustomCutDownBtn.m
//  CloudCity
//
//  Created by 雷祥 on 16/2/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomCutDownBtn.h"
#import "UIView+CCView.h"
#import "CCCategorHeader.h"
@interface CCCustomCutDownBtn ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation CCCustomCutDownBtn

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSet];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self defaultSet];
}


- (void)defaultSet {
    _totalTime = 60.0;
    _currentTime = _totalTime;
    _normalColor = UIColorFromHex(0x8CC63F);
    _disableColor = UIColorFromHex(0x999999);
    _textColor = [UIColor yellowColor];
    _textFont = [UIFont systemFontOfSize:14.0];
    _type = CCCustomCutDownBtnTypeDefault;
    [self setNormalState];
    self.titleLabel.font = _textFont;
    [self setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [self setSystemCorneradius:3 withColor:nil withBorderWidth:0];
    [self addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}


- (void)btnClick:(id)sender {
    [self setDisableState];
    __weak typeof(self) weakSelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendWithSender:complete:)]) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.delegate sendWithSender:self complete:^(BOOL ret) {
                if (ret) {
                    [strongSelf startCutDown];
                }
                else {
                    [strongSelf setNormalState];
                }
            }];
        }
    }
    else {
        [self setNormalState];
    }
}

- (void)setNormalState {
    self.enabled = YES;
    if (self.type == CCCustomCutDownBtnTypeEdge) {
        [self setCorneradius:3 withColor:UIColorFromHex(0x8CC63F) withBorderWidth:1];
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:UIColorFromHex(0x8CC63F) forState:(UIControlStateNormal)];
        [self setSystemCorneradius:3 withColor:UIColorFromHex(0x8CC63F) withBorderWidth:1];
    }
    else if (self.type == CCCustomCutDownBtnTypeDefault) {
        [self setBackgroundColor:_normalColor];
        [self setSystemCorneradius:3 withColor:UIColorFromHex(0x8CC63F) withBorderWidth:0];
    }
}

- (void)setDisableState {
    self.enabled = NO;
    [self setBackgroundColor:_disableColor];
    [self setTitle:@"正在发送..." forState:(UIControlStateDisabled)];
    [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
    [self setSystemCorneradius:3 withColor:UIColorFromHex(0x999999) withBorderWidth:1];
}

#pragma mark 外部设置
/**
 *  外部设置总的倒计时时间
 *
 *  @param totalTime 总时间
 */
- (void)setTotalTime:(NSInteger)totalTime {
    _totalTime = totalTime;
    _currentTime = totalTime;   //默认开始的当前时间为总时间
}

/**
 *  设置常态下的背景颜色
 *
 *  @param normalColor normalColor
 */
- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
}

/**
 *  设置不可用状态下的背景颜色
 *
 *  @param disableColor  disableColor
 */
- (void)setDisableColor:(UIColor *)disableColor {
    _disableColor = disableColor;
    [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
}

/**
 *  设置字体颜色
 *
 *  @param textColor 文字颜色
 */
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self setTitleColor:textColor forState:(UIControlStateNormal)];
}

/**
 *  设置字体
 *
 *  @param textFont 字体
 */
- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.titleLabel.font = textFont;
}

-(void)setType:(CCCustomCutDownBtnType)type {
    _type = type;
    [self setNormalState];
}

#pragma mark 定时器处理

-(NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cutDown) userInfo:nil repeats:YES];
        [self pauseTimer];
    }
    return _timer;
}

- (void)startCutDown {
    _currentTime = _totalTime;
    [self resumeTimer];
    _isCutDowning = YES;
    [self setDisableState];
}


- (void)stopCutDown {
    [self pauseTimer];
    [self setTitle:@"重新获取" forState:(UIControlStateNormal)];
    [self setTitle:@"重新获取" forState:(UIControlStateDisabled)];
    [self setNormalState];
    _isCutDowning = NO;

}
-(void)pauseTimer
{
    if (![self.timer isValid]) {
        return ;
    }
    [_timer setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self.timer isValid]) {
        return ;
    }
    [_timer setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self.timer isValid]) {
        return ;
    }
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

- (void)cutDown{
    //CCLog(@"cutDown");
    if (_currentTime > 1) {
        _currentTime --;
        [self setTitle:[NSString stringWithFormat:@"重新获取(%lds)",(long)_currentTime] forState:(UIControlStateDisabled)];
    }
    else {
        [self stopCutDown];
    }
}

/**
 *  外部使用的类，在dealloc中调用
 */
- (void)invalidateTimer {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

-(void)dealloc {
    [self invalidateTimer];
}

@end
