//
//  UILabel+CCLabel.h
//  CloudCity
//
//  Created by 雷祥 on 15/11/10.
//  Copyright © 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CCLabel)


-(instancetype)initWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font textAligment:(NSTextAlignment)textAligment;


/**
 *  初始化
 *
 *  @param frame        frame
 *  @param textColor    字体颜色
 *  @param fontSize     字体大小
 *  @param textAligment 位置
 *
 *  @return instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame textColorStr:(NSString *)textColor fontInt:(int)fontSize textAligment:(NSTextAlignment)textAligment;
/**
 *  初始化
 *
 *  @param frame        frame
 *  @param text         显示内容
 *  @param textColor    字体颜色
 *  @param fontSize     字体大小
 *  @param textAligment 位置
 *
 *  @return instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColorStr:(NSString *)textColor fontInt:(int)fontSize textAligment:(NSTextAlignment)textAligment;
/**
    处理文字超出最大行数 会显示类似查看更多的文字   exceedsDisplayText  (类似查看更多的文字)  maxNumber 最大的行数
 */
- (void)exceedsDisplayedText:(NSString *)exceedsDisplayText exceedColor:(UIColor *)exceedColor maxNumber:(NSInteger)maxNumber text:(NSString *)text;

/**
 处理文字超出最大行数 会显示类似查看更多的文字   exceedsDisplayText  (类似查看更多的文字)  maxNumber 最大的行数
 */
- (void)exceedsDisplayedText:(NSString *)exceedsDisplayText exceedColor:(UIColor *)exceedColor maxNumber:(NSInteger)maxNumber text:(NSString *)text withSize:(CGSize)labelSize;  //在用xib时，取自身的size可能会出错
/**
 *  设置label上中间的线  lineColor 线的颜色  lineH 线的宽度 线的宽度跟Label同宽
 */
- (void)setCenterLine:(UIColor *)lineColor lineH:(CGFloat)lineH;


@end
