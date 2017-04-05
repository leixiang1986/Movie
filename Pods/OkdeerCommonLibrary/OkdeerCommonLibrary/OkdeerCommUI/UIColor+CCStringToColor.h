//
//  UIColor+CCStringToColor.h
//  CloudCity
//
//  Created by JuGuang on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//
/**
 *  颜色
 */
#import <UIKit/UIKit.h>

@interface UIColor (CCStringToColor)
//十六进制颜色  转换uicolor
+ (UIColor *)stringToColor:(NSString *)str;
+ (UIColor *)stringToColor:(NSString *)str alpha:(CGFloat)f;  //颜色透明度
@end
