//
//  NSAttributedString+CCAttributed.h
//  CloudCity
//
//  Created by Mac on 16/1/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *AttributedString ;
UIKIT_EXTERN NSString *AttributedSize;

@interface NSAttributedString (CCAttributed)
/**
 *  计算text的 NSAttributedString 设置行距 的高度  size 最大的范围  lineSpace 字的行距  alignment 对齐方式  font 字体大小  text 字
 */
+ (NSDictionary *)calculateAttributedSize:(CGSize)size lineSpace:(NSInteger)lineSpace alignment:(NSTextAlignment)alignment font:(UIFont *)font text:(NSString *)text;
/**
 *  计算AttributedString 的字的宽高度
 */
- (CGSize )calculateAttributedOfAttToSize:(CGSize)size;

@end
