//
//  UILabel+CCLabel.m
//  CloudCity
//
//  Created by 雷祥 on 15/11/10.
//  Copyright © 2015年 JuGuang. All rights reserved.
//  增加一个初始化的

#import "UILabel+CCLabel.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
#import "UIColor+CCStringToColor.h"
#import "OkdeerCategory.h"
const char kCenterLineLayer;

@interface UILabel ()

@property (nonatomic,strong) CALayer *centerLineLayer;       /**< 中间线的Layer */

@end

@implementation UILabel (CCLabel)

-(instancetype)initWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font textAligment:(NSTextAlignment)textAligment{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = textColor;
        self.font = font;
        self.textAlignment = textAligment;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame textColorStr:(NSString *)textColor fontInt:(int)fontSize textAligment:(NSTextAlignment)textAligment {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor stringToColor:textColor];
        self.font = [UIFont systemFontOfSize:fontSize];
        self.textAlignment = textAligment;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColorStr:(NSString *)textColor fontInt:(int)fontSize textAligment:(NSTextAlignment)textAligment {
    self = [self initWithFrame:frame textColorStr:textColor fontInt:fontSize textAligment:textAligment];
    self.text = text;
    return self;
}
/**
 处理文字超出最大行数 会显示类似查看更多的文字   exceedsDisplayText  (类似查看更多的文字)  maxNumber 最大的行数
 */
- (void)exceedsDisplayedText:(NSString *)exceedsDisplayText exceedColor:(UIColor *)exceedColor maxNumber:(NSInteger)maxNumber text:(NSString *)text
{
    self.numberOfLines = maxNumber;
    self.text = text;
   CGRect textFrame = [self textRectForBounds:CGRectMake(0, 0, self.width - 4, 1000000) limitedToNumberOfLines:maxNumber];
    self.height = CGRectGetHeight(textFrame);
    NSArray *textArray = [self getSeparatedLinesFromLabel:self size:self.size];
    if (textArray.count > maxNumber) {
       
        if (exceedColor) {
            NSMutableString *tempTextString = [[NSMutableString alloc] init];
            for (NSInteger i = 0 ; i < textArray.count; i ++ ) {
                if (i < maxNumber) {
                    NSString *string = textArray[i];
                    [tempTextString appendString:string];
                }
            }
            NSString *tempString = [NSString stringWithFormat:@"...%@",exceedsDisplayText] ;
            [tempTextString replaceCharactersInRange:NSMakeRange(tempTextString.length - exceedsDisplayText.length - 1, exceedsDisplayText.length + 1 ) withString:tempString];
            NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:tempTextString];
            [mutableAttString addAttributes:@{NSForegroundColorAttributeName:exceedColor} range:NSMakeRange(tempTextString.length - exceedsDisplayText.length, exceedsDisplayText.length)];
            self.attributedText = mutableAttString;
        }
    }
}

-(void)exceedsDisplayedText:(NSString *)exceedsDisplayText exceedColor:(UIColor *)exceedColor maxNumber:(NSInteger)maxNumber text:(NSString *)text withSize :(CGSize)labelSize {
    self.numberOfLines = maxNumber;
    NSMutableString *tempStr = [[NSMutableString alloc] initWithFormat:@"%@%@",text,exceedsDisplayText];
//    text = tempStr;
    self.text = tempStr;
    CGRect textFrame = [self textRectForBounds:CGRectMake(0, 0, labelSize.width , 1000000) limitedToNumberOfLines:maxNumber];
    self.width = labelSize.width;
    self.height = CGRectGetHeight(textFrame);
    NSArray *textArray = [self getSeparatedLinesFromLabel:self size:labelSize];
    if (textArray.count > maxNumber) {
        if (exceedColor) {
            NSMutableString *tempTextString = [[NSMutableString alloc] init];
            for (NSInteger i = 0 ; i < textArray.count; i ++ ) {
                if (i < maxNumber) {
                    NSString *string = textArray[i];
                    [tempTextString appendString:string];
                }
            }
            NSString *tempString = [NSString stringWithFormat:@"...%@",exceedsDisplayText] ;
            NSInteger location = tempTextString.length - tempString.length;
            NSInteger length = tempString.length  ;
            if (location < 0) {
                location = 0;
            }
            if (length < 0) {
                length = 0;
            }
            if (location + length > tempTextString.length) {
                return;
            }
            [tempTextString replaceCharactersInRange:NSMakeRange(location ,length ) withString:tempString];
            self.text = tempTextString;
            NSArray *stringArray = [self getSeparatedLinesFromLabel:self size:labelSize] ;
            if (stringArray.count > maxNumber) {
                [self exceedsDisplayedText:exceedsDisplayText exceedColor:exceedColor maxNumber:maxNumber text:tempTextString withSize:labelSize];
            }else{
                NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:tempTextString];
                [mutableAttString addAttributes:@{NSForegroundColorAttributeName:exceedColor} range:NSMakeRange(tempTextString.length - exceedsDisplayText.length, exceedsDisplayText.length)];
                self.attributedText = mutableAttString;
            }

        }
    }
    else {
        if (exceedColor) {
            NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:tempStr];
            [mutableAttString addAttributes:@{NSForegroundColorAttributeName:exceedColor} range:NSMakeRange(tempStr.length - exceedsDisplayText.length, exceedsDisplayText.length)];
            self.attributedText = mutableAttString;
        }
    }
}

/**
 *  获取行数
 */
- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label size:(CGSize)size
{
    NSString *text = [label text];
    UIFont   *font = [label font];
//    CGRect    rect = [label frame];
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
}
/**
 *  设置label上中间的线  lineColor 线的颜色  lineH 线的宽度 线的宽度跟Label同宽
 */
- (void)setCenterLine:(UIColor *)lineColor lineH:(CGFloat)lineH{
    [self setupCenterLineLayer:lineColor lineH:lineH];
}

- (void)setupCenterLineLayer:(UIColor *)lineColor lineH:(CGFloat)lineH{
    if (!self.centerLineLayer) {
        self.centerLineLayer = [CALayer layer];
        [self.layer addSublayer:self.centerLineLayer];
    }
    self.centerLineLayer.backgroundColor = lineColor.CGColor;
    self.centerLineLayer.frame = CGRectMake(0, (self.height - lineH) / 2, self.width, lineH);
    self.centerLineLayer.hidden = self.width > 0 ? NO : YES;
}
#pragma mark - //****************** property ******************//
- (void)setCenterLineLayer:(CALayer *)centerLineLayer{
    objc_setAssociatedObject(self, &kCenterLineLayer, centerLineLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CALayer *)centerLineLayer{
    return objc_getAssociatedObject(self, &kCenterLineLayer);
}
@end
