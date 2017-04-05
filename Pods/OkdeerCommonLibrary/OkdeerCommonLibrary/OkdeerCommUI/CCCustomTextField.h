//
//  LxTextField.h
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CCCustomTextField : UITextField
//在initWithFrame：方法中设置了背景色为透明，无需再设置

@property (nonatomic,assign) BOOL isPaste;
@property (nonatomic,assign) BOOL isDelete;
@property (nonatomic,assign) BOOL isCut;
@property (nonatomic,assign) BOOL isCopy;
@property (nonatomic,assign) BOOL isSelectAll;
@property (nonatomic,assign) BOOL isSelect;


/**
 *  禁止复制粘贴等功能
 */
-(void)banAllCopyAndSelect;


/**
 *  初始化
 *
 *  @param frame     frame
 *  @param fontSize  字体大小
 *  @param textColor 颜色
 *  @param style     外形风格
 *
 *  @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor borderStyle:(UITextBorderStyle)style;

/**
 *  初始化
 *
 *  @param frame     frame
 *  @param fontSize  字体大小
 *  @param textColor 颜色
 *  @param style     外形风格
 *  @param placeHolder     默认值
 *
 *  @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor borderStyle:(UITextBorderStyle)style placeHolder:(NSString *)placeHolder;
//
///**
// *  初始化
// *
// *  @param frame     frame
// *  @param fontSize  字体大小
// *  @param HEXString 颜色16进制字符串
// *  @param style     外形风格
// *  @param placeHolder     默认值
// *
// *  @return 实例
// */
//-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColorHEXStr:(NSString *)HEXString borderStyle:(UITextBorderStyle)style placeHolder:(NSString *)placeHolder;

/**
 *  设置 多种颜色字体显示  多种字体大小显示
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright;
/**
 *  设置 多种颜色字体显示  多种字体大小显示  传的值有多长显多长的
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedWidthColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright;




@end
