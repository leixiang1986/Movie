//
//  UITextField+CCExtame.m
//  CloudCity
//
//  Created by Mac on 15/11/17.
//  Copyright © 2015年 JuGuang. All rights reserved.
//

#import "UITextField+CCExtame.h"
#import "OkdeerCategory.h"

@implementation UITextField (CCExtame)
/**
 *  设置提示语的字体颜色
 */
- (void)setupPlaceholder:(UIColor *)color placeholder:(NSString *)placeholder
{
    if (!color) {
        // 没有设置为默认
        color = UIColorFromHex(COLOR_EDEDED);
    }
    if (!placeholder) {
        placeholder = @""; 
    }
    
    // 设置提醒文字
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = UIColorFromHex(COLOR_CCCCCC);
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attrs];
}

/**
 *  设置textField 左边的控件  设置为一个透明的
 */
- (void)setupLeftView:(CGFloat)width
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways ;
}
/**
 *  设置textField 右边的控件  设置为一个透明的
 */
- (void)setupRightView:(CGFloat)width
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways ;
}

- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;

    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;

    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range  // 备注：UITextField必须为第一响应者才有效
{
    UITextPosition* beginning = self.beginningOfDocument;

    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];

    [self setSelectedTextRange:selectionRange];
}


@end
