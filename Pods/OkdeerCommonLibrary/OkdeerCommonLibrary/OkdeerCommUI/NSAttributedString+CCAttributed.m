//
//  NSAttributedString+CCAttributed.m
//  CloudCity
//
//  Created by Mac on 16/1/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "NSAttributedString+CCAttributed.h"
#import <CoreText/CoreText.h>

NSString *AttributedString = @"AttributedString";
NSString *AttributedSize = @"AttributedSize";

@implementation NSAttributedString (CCAttributed)

/**
 *  计算text的 NSAttributedString 的高度  size 最大的范围  lineSpace 字的行距  alignment 对齐方式  font 字体大小  text 字
 */
+ (NSDictionary *)calculateAttributedSize:(CGSize)size lineSpace:(NSInteger)lineSpace alignment:(NSTextAlignment)alignment font:(UIFont *)font text:(NSString *)text
{
    NSDictionary *attriDic ;
    
    NSDictionary *numDic = [self calculateSize:size lineSpace:lineSpace alignment:alignment font:font text:@"1"];
    CGSize numSize = CGSizeFromString(numDic[AttributedSize]);
    
    attriDic = [self calculateSize:size lineSpace:lineSpace alignment:alignment font:font text:text];
    
    CGSize textSize = CGSizeFromString(attriDic[AttributedSize]);
    NSInteger currInt = (int)textSize.height ;
    NSInteger sizeInt = (int)numSize.height ;
    
    if ((currInt - lineSpace ) / sizeInt == 1 && (currInt - lineSpace) % sizeInt == 0) {
        attriDic = [self calculateSize:size lineSpace:0 alignment:alignment font:font text:text];
    }
    
    return attriDic;
}

+ (NSDictionary *)calculateSize:(CGSize)size lineSpace:(NSInteger)lineSpace alignment:(NSTextAlignment)alignment font:(UIFont *)font text:(NSString *)text
{
    NSMutableDictionary *attriDic = [[NSMutableDictionary alloc] init];;
    
     NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpace];
    
    /**
     *  设置根据你设置的左右对齐设置, 默认是左对齐.fix by chenzl
     */
    [paragraphStyle1 setAlignment:alignment];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    if (font) {
        [attributedString1 addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, [text length])];
    }
    CGRect frame = [attributedString1 boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    [attriDic setObject:(attributedString1.length ? attributedString1 : [[NSAttributedString alloc] init]) forKey:AttributedString];
    NSString *sizeString =  NSStringFromCGSize(frame.size);
    [attriDic setObject:(sizeString.length ? sizeString : @"") forKey:AttributedSize];
    return attriDic;
}
/**
 *  计算AttributedString 的字的宽高度
 */
- (CGSize )calculateAttributedOfAttToSize:(CGSize)size {
    if (self && self.length) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) self);   //string 为要计算高度的
        CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,size, NULL);
        CFRelease(framesetter);
        return suggestedSize;
    }else{
        return CGSizeZero;
    }
}

@end
