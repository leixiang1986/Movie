//
//  CCCustomPlaceholderTextView.m
//  TestViewDemo
//
//  Created by huangshupeng on 16/7/17.
//  Copyright © 2016年 huangshupeng. All rights reserved.
//

#import "CCCustomPlaceholderTextView.h"

#define kSpace              12

@interface CCCustomPlaceholderTextView ()<UITextViewDelegate>

@property (nonatomic,strong) UITextView *placeholderTextView;   /**< 提示文字的textView */

@end

@implementation CCCustomPlaceholderTextView

#pragma mark - //****************** delegate/dataSource ******************//
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.placeholderTextView == textView) {
        return NO;
    }
    return YES;
}
#pragma mark - //****************** 通知 ******************//
- (void)textViewTextDidChange:(NSNotification *)objc{
    if ([objc.object isKindOfClass:[self class]]) {
        UITextView *textView = (UITextView *)objc.object;
        if (textView == self){
            [self dealTextLength:textView];
        }
        
    }
}
/**
 *  处理self的text 是否达到最大的长度
 */
- (void)dealTextLength:(UITextView *)textView{
    if (self.maxLength > 0 && textView.text.length > self.maxLength && textView.markedTextRange == nil) {
        textView.text = [textView.text substringToIndex:self.maxLength];
    }
    self.placeholderTextView.hidden = textView.text.length > 0 ? YES : NO;
    [self dealTextHeight];
}
/**
 *  处理字的高度
 */
- (void)dealTextHeight{
    CGRect placeholderFrame = [self.placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font ? self.font : [UIFont systemFontOfSize:16]} context:nil];
    if (self.isMaskText) {
        CGRect textFrame = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font ? self.font : [UIFont systemFontOfSize:16]} context:nil];
        CGFloat textHeight = CGRectGetHeight(textFrame);
        textHeight = textHeight > self.defaultHeight ? textHeight + kSpace: self.defaultHeight;
        if (textHeight < CGRectGetHeight(placeholderFrame)) {
            textHeight = CGRectGetHeight(placeholderFrame) + kSpace ;
        }
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), textHeight);
        if (self.textHeightChangeBlock) {
            self.textHeightChangeBlock(self);
        }
        
    }else{
        if (_defaultHeight <= self.font.pointSize) {
            self.defaultHeight = self.font.pointSize + kSpace;
        }
        if (_defaultHeight < CGRectGetHeight(placeholderFrame)) {
            self.defaultHeight = CGRectGetHeight(placeholderFrame) + kSpace  ;
        }
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), _defaultHeight);
    }
}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self dealTextHeight];
//}

#pragma mark - //****************** setter ******************//
- (void)setPlaceholder:(NSString *)placeholder{
    self.placeholderTextView.text = placeholder;
    [self dealTextLength:self];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderTextView.font = font;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    [super setTextAlignment:textAlignment];
    self.placeholderTextView.textAlignment = textAlignment;
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    _placeholderFont = placeholderFont;
    self.placeholderTextView.font = _placeholderFont;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderTextView.textColor = _placeholderColor;
}
- (void)setText:(NSString *)text{
    [super setText:text];
     [self dealTextLength:self];
}
- (void)setDefaultHeight:(CGFloat)defaultHeight{
    _defaultHeight = defaultHeight;
    [self dealTextHeight];
}

- (void)setFrame:(CGRect)frame{
    if (CGRectGetHeight(frame) <= 0) {
        frame.size.height = _defaultHeight;
    }
    [super setFrame:frame];
    
}

#pragma makr ------- getter ---------
- (UITextView *)placeholderTextView{
    if (!_placeholderTextView) {
        _placeholderTextView = [[UITextView alloc] init];
        _placeholderTextView.delegate = self;
        _placeholderTextView.backgroundColor = [UIColor clearColor];
        _placeholderTextView.textColor = [UIColor colorWithRed:(153.0/ 255.0f) green:(153.0/ 255.0f) blue:(153.0/ 255.0f) alpha:1];
        [self insertSubview:_placeholderTextView atIndex:0];
        [self addPlaceholderConstraint];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return _placeholderTextView;
}
/**
 *  为placeholderTextView  设置Layout
 */
- (void)addPlaceholderConstraint{
    _placeholderTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_placeholderTextView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_placeholderTextView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_placeholderTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_placeholderTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_placeholderTextView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_placeholderTextView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
