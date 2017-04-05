//
//  LxTextView.m
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import "CCCustomTextView.h"
#import "CCCategorHeader.h"
@implementation CCCustomTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  初始化
 */
- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.isSelectAll = YES;
    self.isSelect = YES;
    self.isCopy = YES;
    self.isCut = YES;
    self.isPaste = YES;
    self.isDelete = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged) name:UITextViewTextDidChangeNotification object:self];
    self.alwaysBounceVertical = YES;
}
/**
 *  复写方法，确定是否可以粘贴，剪切，删除
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if ([@"_showKeyboard:" isEqualToString:NSStringFromSelector(action)]) {
        return NO;
    }
    
    if (action == @selector(paste:)) {
        return self.isPaste;
    }
    else if (action == @selector(delete:)){
        return NO;
        
    }else if (action == @selector(cut:)){
        return self.isCut;
    }
    else if (action == @selector(selectAll:)){
        if (self.textViewClickSelectAllBlock) {
            self.textViewClickSelectAllBlock();
        }
        return NO;
    }
    else if (action == @selector(copy:)){
        return self.isCopy;
    }
    else if (action == @selector(select:)){
        return self.isSelect;
    }
    else{
        return NO;
    }
}

#pragma mark - placeholder
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    _placeholderColor = UIColorFromHex(0x999999);
    _placeholderFont = [UIFont systemFontOfSize:14.0];
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    if (!self.text.length) {
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        
        //文字颜色
        if (self.placeholderColor) {
            attrs[NSForegroundColorAttributeName] = self.placeholderColor;
        } else {
            attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        }
        //文字大小
        if (self.placeholderFont) {
            attrs[NSFontAttributeName] = self.placeholderFont;
        } else {
            attrs[NSFontAttributeName] = self.font;
        }
        
        //增加placeholder文字显示区域 by chenzl, fix me ^_^
        NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc]init];
        paragraph.alignment = self.placeAlignment;
        attrs[NSParagraphStyleAttributeName] = paragraph;
        
        CGFloat cubeX = 5;
        CGFloat cubeY = 7;
        CGFloat cubeW = self.bounds.size.width - cubeX;
        CGFloat cubeH = self.bounds.size.height - cubeY;
        CGRect cubeRect = CGRectMake(cubeX, cubeY, cubeW, cubeH);
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
            [self.placeholder drawInRect:cubeRect withAttributes:attrs];
        }
        else {
            NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
            [attriStr drawInRect:cubeRect];
        }
    }
}

// 通知调用方法
- (void)textViewChanged
{
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}
-(void)setPlaceholderOriginX:(CGFloat)placeholderOriginX{
    _placeholderOriginX = placeholderOriginX;
    [self setNeedsDisplay];
}

@end
