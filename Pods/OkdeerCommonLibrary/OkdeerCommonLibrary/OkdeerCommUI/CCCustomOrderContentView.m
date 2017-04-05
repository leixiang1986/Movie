//
//  CCCustomOrderContentView.m
//  CloudCity
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomOrderContentView.h"
#import "CCCustomLabel.h"
#import "CCCategorHeader.h"
#import "UIView+CCView.h"

#define kStringSpace  6    /**< 字与字之间的间距 */

@interface CCCustomOrderContentView ()
{
    CCCustomLabel *_titleLbl;      /**< 标题label */
    CCCustomLabel *_contentLbl;    /**< 内容label */
    CCCustomLabel *_tempLbl;       /**< 临时label */
    CGFloat _topSpace;             /**< 标题label距上边距 */
    CGFloat _leftSpace;            /**< 标题label距左边距 */
    CGFloat _rightSpace;           /**< 标题label距右边距 */
    CGSize _currentSize ;          /**< 默认的size */
}

@property (nonatomic, assign) BOOL isHidden;       /**< 是否隐藏 */

@end

@implementation CCCustomOrderContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _leftSpace = 12 ;
        _rightSpace = 12 ;
        _titleWidth = 57 ;
        //单行 可以修改默认高度.
        _defaultHeight  = 32 ;
        _isHidden = YES;
        _titleFont = FONTDEFAULT(14);
        _contentFont = FONTDEFAULT(14);
        _titleColor = UIColorFromHex(0x999999);
        _contentColor = UIColorFromHex(0x333333);
        _titleTextAlignment = NSTextAlignmentLeft;
        _contentTextAlignment = NSTextAlignmentLeft;
        
        [self creatUI] ;
    }
    return self;
}
/**
 *  创建UI
 */
- (void)creatUI
{
    // 标题
    _titleLbl = [[CCCustomLabel alloc] initWithFrame:CGRectMake(_leftSpace, _topSpace, _titleWidth, _titleFont.pointSize) withFontSize:_titleFont.pointSize withTextColor:_titleColor backColor:[UIColor clearColor]];
    [self addSubview:_titleLbl];
    
    _tempLbl = [[CCCustomLabel alloc] initWithFrame:CGRectMake(_leftSpace, _topSpace, _titleWidth, _titleFont.pointSize) withFontSize:_titleFont.pointSize withTextColor:_titleColor backColor:[UIColor clearColor]];
    _tempLbl.text = @"1";
    _currentSize = [_tempLbl getLabelSizeHeight:kStringSpace];
    // 内容
    _contentLbl = [[CCCustomLabel alloc] initWithFrame:CGRectMake(_titleLbl.right + _rightSpace, _topSpace, CGRectGetWidth(self.frame) - _titleLbl.right - _rightSpace - _leftSpace, _contentFont.pointSize) withFontSize:_contentFont.pointSize withTextColor:_contentColor backColor:_titleLbl.backgroundColor];
    _contentLbl.opaque = _titleLbl.opaque;
    _contentLbl.numberOfLines = 0 ;
    [self addSubview:_contentLbl];
}

#pragma mark - 重写setter方法
/**
 *  设置字体颜色
 *
 *  @param titleColor 颜色
 */
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor ;
    _titleLbl.textColor = _titleColor ;
}

- (void)setContentColor:(UIColor *)contentColor
{
    _contentColor = contentColor ;
    _contentLbl.textColor = _contentColor ;
}
/**
 *  设置字体大小
 *
 *  @param titleFont 大小
 */
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont ;
    _titleLbl.font = _titleFont;
    _tempLbl.font = _titleFont;
    [self layoutSubviews];
}

- (void)setContentFont:(UIFont *)contentFont
{
    _contentFont = contentFont ;
    _contentLbl.font = _contentFont ;
    [self layoutSubviews];
}

//设置默认高度
- (void)setDefaultHeight:(CGFloat)defaultHeight
{
    _defaultHeight = defaultHeight ;
    [self layoutSubviews];
}

//设置字体宽度
- (void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth ;
    [self layoutSubviews];
}

/**
 *  设置字体的样式
 *
 *  @param titleTextAlignment 样式
 */
- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment
{
    _titleTextAlignment = titleTextAlignment;
    _titleLbl.textAlignment = _titleTextAlignment;
    _tempLbl.textAlignment = _titleTextAlignment;
}

- (void)setContentTextAlignment:(NSTextAlignment)contentTextAlignment
{
    _contentTextAlignment = contentTextAlignment;
    _contentLbl.textAlignment = _contentTextAlignment;
}
- (void)setContent:(NSString *)content{
    _content = content;
    _contentLbl.text = _content;
    [self layoutSubviews];
}
/**
 *  为标题和内容赋值
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)assignmentOfTitle:(NSString *)title withContent:(NSString *)content{
    _titleLbl.text = title;
    _contentLbl.text = content;
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    _topSpace = (_defaultHeight - _titleFont.pointSize)/ 2 ;  //计算上边距
    _tempLbl.frame =  CGRectMake(_tempLbl.left, _tempLbl.top, _titleWidth, _titleFont.pointSize);
    _currentSize = [_tempLbl getLabelSizeHeight:kStringSpace];
    
    //计算title的长度
    CGSize titleSize = [_titleLbl getLabelSizeHeight:kStringSpace onlyText:_currentSize];
    if (titleSize.width > _titleWidth) {
        //超过默认长度的-> 就设置为当前的长度
        _titleWidth = titleSize.width;
    }
    _titleLbl.frame = CGRectMake( (_titleWidth > 0 ? _leftSpace : 0 ) , _topSpace, _titleWidth, titleSize.height) ;
    
    _contentLbl.frame = CGRectMake(_titleLbl.right + _rightSpace, _topSpace, CGRectGetWidth(self.frame) - _titleLbl.right - _rightSpace - _leftSpace, _contentFont.pointSize) ;
    CGSize contentSize = [_contentLbl getLabelSizeHeight:kStringSpace onlyText:_currentSize];
    _contentLbl.frame = CGRectMake(_titleLbl.right + _rightSpace, _topSpace, CGRectGetWidth(self.frame) - _titleLbl.right - _rightSpace - _leftSpace, contentSize.height) ;
    if (_contentLbl.bottom  > _defaultHeight) {
        _currentHeight = _contentLbl.bottom + _topSpace ;
    }else{
        _currentHeight = _defaultHeight ;
    }
    
    //针对隐藏
    if (_isHidden) {
        if (_contentLbl.text.length == 0 ) {
            _currentHeight = 0 ;
            self.hidden = YES;
        }else{
            self.hidden = NO;
        }
    }
    //针对不隐藏
    else {
        _currentHeight = self.frame.size.height;
        self.hidden = NO;
    }
    
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), _currentHeight);
}

#pragma mark - *** 扩充 ***
/**
 *  扩充....
 *  为标题和内容赋值
 *  @param title   标题
 *  @param content 内容
 *  @param isHidden 是否隐藏
 */
- (void)assignmentOfTitle:(NSString *)title withContent:(NSString *)content isHidden:(BOOL)hidden
{
    _titleLbl.text = title;
    _contentLbl.text = content;
    _isHidden = hidden;
    [self layoutSubviews];
}

@end
