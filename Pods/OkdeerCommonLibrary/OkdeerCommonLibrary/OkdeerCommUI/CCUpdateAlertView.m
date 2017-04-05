//
//  CCUpdateAlertView.m
//  CloudMall
//
//  Created by huangshupeng on 15/9/7.
//  Copyright (c) 2015年 CloudCity. All rights reserved.
//

#import "CCUpdateAlertView.h"
#import "UIHeader.h"
#import "CCCustomLabel.h"

#define kLeftSpace      30    /**< contentView  距离左边的间距*/
#define kRightSpace     30    /**< contentView  距离右边的间距*/
#define kTopSpace       64    /**< contentview 距顶部的间距 */
#define kBottomSpace    64    /**< contentview 距顶部的间距 */
#define kTitleLSpace    10    /**< 文字 距 contentview 的左边距 */
#define kTitleRSpace    10    /**< 文字 距 contentview 的右边距 */
#define kTitleHeight    40    /**< 标题的提示的高度 */
#define kTitleFont      18    /**< 标题的字体大小 */
#define kLineLayerHeight 1    /**< 分割线的高度 */
#define kVersionFont    14    /**< 版本的字体大小 */
#define kVersionTop     14    /**< 版本 距上的间距 */
#define kMessageTop     16    /**< 内容 距上的间距*/   
#define kMessageFont    14    /**< 内容的字体大小 */
#define kMessageBottom  14    /**< 内容距下的 间距 */
#define kOnlyButtonW    175   /**< 只有一个按钮的宽度 */
#define kOnlyButtonH    44    /**< 只有一个按钮的高度  */
#define kButtonBottom   14    /**< 只有一个按钮 对底部的间距 */
#define kButtonH        50    /**< 按钮的高度 */
@interface CCUpdateAlertView ()

@property (nonatomic,strong) UIView *contentView;                 /**< */
@property (nonatomic,strong) UIScrollView *messageScrollView;     /**< 内容 滑动区域 */
@property (nonatomic,strong) CCCustomLabel *titleLabel;           /**< 标题 */
@property (nonatomic,strong) CALayer *topLineLayer;               /**< 顶部的layer*/
@property (nonatomic,strong) CALayer *buttonTopLineLayer;         /**< 按钮上的分隔线 */
@property (nonatomic,strong) CALayer *buttonCenterLineLayer;      /**< 按钮 之间的分隔线  */
@property (nonatomic,strong) CCCustomLabel *messageLabel;         /**< 内容 */
@property (nonatomic,strong) CCCustomLabel *currentVersionLabel;  /**< 当前版本 */
@property (nonatomic,strong) CCCustomLabel *lastVersionLabel;     /**< 最新版本 */
@property (nonatomic,strong) UIButton *canceButton;               /**< 取消按钮 */
@property (nonatomic,strong) UIButton *doneButton;                /**< 确定按钮 */

@property (nonatomic,strong) NSString *title;                     /**< 标题 */
@property (nonatomic,strong) NSString *message;                   /**< 内容 */
@property (nonatomic,strong) NSString *currentVersion;            /**< 当前版本 */
@property (nonatomic,strong) NSString *lastVersion;               /**< 最新版本 */
@property (nonatomic,strong) NSString *canceButtonTitle;          /**< 取消按钮 */
@property (nonatomic,strong) NSString *doneButtonTitle;           /**< 确定按钮*/

@end

@implementation CCUpdateAlertView
{
    
}


/**
 *  初始化 控件 UI
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message currentVersion:(NSString *)currentVersion lastVersion:(NSString *)lastVersion canceButtonTitle:(NSString *)canceButtonTitle doneButtonTitle:(NSString *)doneButtonTitle delegate:(id)delegate
{
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _currentVersion = currentVersion;
        _lastVersion = lastVersion;
        _canceButtonTitle = canceButtonTitle;
        _doneButtonTitle = doneButtonTitle;
        _delegate = delegate; 
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        [self creatUI];
        [self assignmentValue]; 
    }
    return self;
}

/**
 *  创建UI
 */
- (void)creatUI
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kLeftSpace, 0, CGRectGetWidth(self.frame) - kLeftSpace - kRightSpace, 0)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView setupCorneradius:3];
        [self addSubview:_contentView];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(kTitleLSpace, 0, _contentView.width - kTitleLSpace - kTitleRSpace, kTitleHeight) withFontSize:kTitleFont withTextColor:UIColorFromHex(0x8CC63F) backColor:nil];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
    }
    
    if (!_topLineLayer) {
        _topLineLayer = [CALayer layer];
        _topLineLayer.backgroundColor = UIColorFromHex(0x8CC63F).CGColor;
        _topLineLayer.frame = CGRectMake(kTitleLSpace, _titleLabel.bottom, CGRectGetWidth(_contentView.frame) - kTitleLSpace - kTitleRSpace, kLineLayerHeight);
        [_contentView.layer addSublayer:_topLineLayer];
    }
    if (!_currentVersionLabel) {
        _currentVersionLabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(kTitleLSpace, CGRectGetMaxY(_topLineLayer.frame) + kVersionTop, CGRectGetWidth(_contentView.frame) - kTitleLSpace - kTitleRSpace, kVersionFont) withFontSize:kVersionFont withTextColor:UIColorFromHex(0x666665) backColor:[UIColor whiteColor]];
        [_contentView addSubview:_currentVersionLabel];
    }
    if (!_lastVersionLabel) {
        _lastVersionLabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(_currentVersionLabel.left, _currentVersionLabel.bottom + 5, _currentVersionLabel.width, _currentVersionLabel.height) withFontSize:kVersionFont withTextColor:UIColorFromHex(0x666666) backColor:nil];
        [_contentView addSubview:_lastVersionLabel];
    }
    
    if (!_messageScrollView) {
        _messageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kTitleLSpace, _lastVersionLabel.bottom + kMessageTop, CGRectGetWidth(_contentView.frame) - kTitleLSpace - kTitleRSpace, 0)];
        _messageScrollView.showsVerticalScrollIndicator = NO;
        [_contentView addSubview:_messageScrollView];
    }
    
    if (!_messageLabel) {
        _messageLabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(0, 0, _messageScrollView.width, 0) withFontSize:kMessageFont withTextColor:UIColorFromHex(0x666666) backColor:nil];
        _messageLabel.numberOfLines = 0 ;
        [_messageScrollView addSubview:_messageLabel];
    }
    
    if (!_canceButton) {
        _canceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_canceButton setTitleColor:UIColorFromHex(0xCCCCCC) forState:UIControlStateNormal];
        _canceButton.titleLabel.font = FONTDEFAULT(15);
        [_canceButton addTarget:self action:@selector(clickCanceButton) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_canceButton];
    }
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitleColor:UIColorFromHex(0x8CC63F) forState:UIControlStateNormal];
        _doneButton.titleLabel.font = FONTDEFAULT(15);
        [_doneButton addTarget:self action:@selector(clickDoneButton) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_doneButton];
    }
    if (!_buttonTopLineLayer) {
        _buttonTopLineLayer = [CALayer layer];
        _buttonTopLineLayer.backgroundColor = UIColorFromHex(0xE2E2E2).CGColor;
        [_contentView.layer addSublayer:_buttonTopLineLayer];
    }
    if (!_buttonCenterLineLayer) {
        _buttonCenterLineLayer = [CALayer layer];
        _buttonCenterLineLayer.backgroundColor = UIColorFromHex(0xE2E2E2).CGColor;
        [_contentView.layer addSublayer:_buttonCenterLineLayer];
    }
}
/**
 *  赋值
 */
- (void)assignmentValue
{
    _titleLabel.text = _title;
    _currentVersionLabel.text = _currentVersion;
    _lastVersionLabel.text = _lastVersion;
    _messageLabel.text = _message;
    [_canceButton setTitle:_canceButtonTitle forState:UIControlStateNormal];
    [_doneButton setTitle:_doneButtonTitle forState:UIControlStateNormal];
    
    CGRect messageFrame = [_messageLabel calculate:NO];
    CGFloat messageHeight = CGRectGetHeight(messageFrame);
    _messageLabel.height = messageHeight;
    
    CGFloat buttonH = 0.0f;
    if (_canceButtonTitle.length) {
        buttonH = kButtonH;
        [_doneButton setTitleColor:UIColorFromHex(0x8CC63F) forState:UIControlStateNormal];
        _doneButton.backgroundColor = [UIColor whiteColor];
    }else{
        buttonH = kButtonBottom + kOnlyButtonH;
        _doneButton.backgroundColor = UIColorFromHex(0x8CC63F);
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton setupCorneradius:3];
    }
    
    if (_lastVersionLabel.bottom + kMessageTop + messageHeight + kMessageBottom + buttonH + kTopSpace + kBottomSpace > CGRectGetHeight(self.frame)) {
        _messageScrollView.height = CGRectGetHeight(self.frame) - _lastVersionLabel.bottom - kMessageTop - kMessageBottom - buttonH - kTopSpace - kBottomSpace;
    }else{
        _messageScrollView.height = messageHeight;
    }
    _messageScrollView.contentSize = CGSizeMake(0, _messageLabel.bottom);
    CGFloat contentHeight = _messageScrollView.bottom + kMessageBottom + buttonH;
    _contentView.frame = CGRectMake(kLeftSpace, (CGRectGetHeight(self.frame) - contentHeight) / 2.0f, _contentView.width, contentHeight);
    
    if (_canceButtonTitle.length) {
        _buttonCenterLineLayer.hidden = NO;
        _buttonTopLineLayer.hidden = NO;
        _canceButton.hidden = NO;
        _doneButton.hidden = NO;
        _canceButton.frame = CGRectMake(0, _messageScrollView.bottom + kMessageBottom, CGRectGetWidth(_contentView.frame) / 2.0f, kButtonH);
        _doneButton.frame = CGRectMake(_canceButton.right, _canceButton.top, _canceButton.width, _canceButton.height);
        _buttonTopLineLayer.frame = CGRectMake(0, _canceButton.top, CGRectGetWidth(_contentView.frame), 1);
        _buttonCenterLineLayer.frame = CGRectMake(_canceButton.right, _canceButton.top, 1, _canceButton.height);
    }else{
        _buttonCenterLineLayer.hidden = YES;
        _buttonTopLineLayer.hidden = YES;
        _canceButton.hidden = YES;
        _doneButton.hidden = NO;
        _doneButton.frame = CGRectMake((CGRectGetWidth(_contentView.frame) - kOnlyButtonW) / 2.0f, _messageScrollView.bottom + kMessageBottom, kOnlyButtonW, kOnlyButtonH);
    }
    
}


/**
 *   获取位置
 */
- (NSInteger)buttonWithTitle:(NSString *)title
{
    NSInteger index  = 0 ;
    if ([title isEqualToString:_canceButtonTitle]) {
        index = 0 ;
    }else if ([title isEqualToString:_doneButtonTitle]){
        index = 1;
    }else{
        index = 0;
    }
    return index;
}
/**
 *  获取标题
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = @"";
    if (buttonIndex == 0 ) {
        buttonTitle = _canceButtonTitle;
    }else if (buttonIndex == 1){
        buttonTitle = _doneButtonTitle;
    }else{
        buttonTitle = _canceButtonTitle;
    }
    return buttonTitle;
}
/**
 *  展示
 */
- (void)show{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [self.superview bringSubviewToFront:self];
    self.backgroundColor = [UIColor clearColor];
    _contentView.hidden = YES;
 
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        _contentView.hidden = NO;
 
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  隐藏view
 */
- (void)hideView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        _contentView.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 按钮点击事件
/**
 *  点击取消按钮
 */
- (void)clickCanceButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(updateAlertView:clickButtonIndex:)]) {
        [_delegate updateAlertView:self clickButtonIndex:0];
    }
    [self hideView];
}
/**
 *  点击确定按钮
 */
- (void)clickDoneButton{
    if (_delegate && [_delegate respondsToSelector:@selector(updateAlertView:clickButtonIndex:)]) {
        [_delegate updateAlertView:self clickButtonIndex:1];
    }
    [self hideView];
}


@end
