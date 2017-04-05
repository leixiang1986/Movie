//
//  UITextField+CCExtame.h
//  CloudCity
//
//  Created by Mac on 15/11/17.
//  Copyright © 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CCExtame)
/**
 *  设置提示语的字体颜色
 */
- (void)setupPlaceholder:(UIColor *)color placeholder:(NSString *)placeholder ;
/**
 *  设置textField 左边的控件  设置为一个透明的
 */
- (void)setupLeftView:(CGFloat)width;
/**
 *  设置textField 右边的控件  设置为一个透明的
 */
- (void)setupRightView:(CGFloat)width;

/**
 *  得到选中的范围
 *
 *  @return  NSRange
 */
- (NSRange)selectedRange;

/**
 *  设置选中的范围
 *
 *  @param range    range
 */
- (void)setSelectedRange:(NSRange)range;
@end
