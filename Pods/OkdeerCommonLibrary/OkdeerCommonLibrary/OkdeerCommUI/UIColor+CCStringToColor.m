//
//  UIColor+CCStringToColor.m
//  CloudCity
//
//  Created by JuGuang on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "UIColor+CCStringToColor.h"

@implementation UIColor (CCStringToColor)
//十六进制颜色  转换uicolor
+(UIColor *)stringToColor:(NSString *)str{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}
/**
 *  十六进制 转换成 UIColor   根据
 *
 *  @param str <#str description#>
 *  @param f   <#f description#>
 *
 *  @return <#return value description#>
 */
+(UIColor *)stringToColor:(NSString *)str alpha:(CGFloat)f{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:f];
    return color;
}
@end
