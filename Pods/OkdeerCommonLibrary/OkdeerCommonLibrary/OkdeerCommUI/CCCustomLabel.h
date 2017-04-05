//
//  LxLabel.h
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCCustomLabel ;

@protocol CustomLabelCopyableLabelDelegate <NSObject>

@optional
- (NSString *)stringToCopyForCopyableLabel:(CCCustomLabel *)copyableLabel;
- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(CCCustomLabel *)copyableLabel;

@end

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface CCCustomLabel : UILabel{
@private
    VerticalAlignment _verticalAlignment;
}
@property (nonatomic,assign) VerticalAlignment verticalAlignment;
//在initWithFrame：方法中设置了背景色为透明，无需再设置

@property (nonatomic,assign) CGRect contentFrame;   //内容范围

@property (nonatomic, assign) BOOL copyingEnabled; // Defaults to NO

@property (nonatomic, weak) id<CustomLabelCopyableLabelDelegate> copyableLabelDelegate;

@property (nonatomic, assign) UIMenuControllerArrowDirection copyMenuArrowDirection; // Defaults to UIMenuControllerArrowDefault

// You may want to add longPressGestureRecognizer to a container view
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;


-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor backColor:(UIColor *)backColor;   //传入颜色，字体大小
-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor backColor:(UIColor *)backColor withTextAlignment:(NSTextAlignment)textAlignment;

/**
 判断是否为适应宽度 还是高度   是  适应宽度   否  适应高度
 @parm isWidth  是  适应宽度   否  适应高度
 */
- (CGRect )calculate:(BOOL)isWidth;
/**
 *    isWidth 判断是否为适应宽度 还是高度   是  适应宽度   否  适应高度   只有isWidth为YES时  isheight  才有效
 *
 *  @param isWidth  是  适应宽度   否  适应高度
 *  @param isheight isheight  是 取计算出的高度   否  取self.frame.height
 *
 *  @return <#return value description#>
 */
- (CGRect)calculate:(BOOL)isWidth isHeight:(BOOL)isheight ;

/**
 *  设置 多种颜色字体显示  多种字体大小显示    从那个字开始
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright;
/**
 *  设置 多种颜色字体显示  多种字体大小显示  传的值有多长显多长的   根据传进来的字的长度显示
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedWidthColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright;

/**
 *  设置多种字对应不同的颜色  isAll 是 stringArray 查找到对应的字会替换成一样的字体大小和字体颜色  否 不会把所有相同的字替换成相同的颜色和字体大小
 *
 *  @param colorArray  颜色数组
 *  @param fontArray   字体数组
 *  @param stringArray 字数组
 *  @param isAll       查找字一样  是否替换成一样的字体颜色字体的大小
 */
- (void)setVariedColorArray:(NSArray *)colorArray fontArray:(NSArray *)fontArray string:(NSArray *)stringArray isAll:(BOOL)isAll ;

/**
 *  计算  行行之间的间距
 *
 *  @param lineSpace 间距
 *
 *  @return 返回字的大小
 */
- (CGSize)getLabelSizeHeight:(NSInteger)lineSpace ;
/**
 *  计算 字的高度  根据 单个字的高度设置的
 *
 *  @param lineSpace  lineSpace
 *  @param size  size
 *
 *  @return  CGSize
 */
- (CGSize)getLabelSizeHeight:(NSInteger)lineSpace onlyText:(CGSize)size;


@end
