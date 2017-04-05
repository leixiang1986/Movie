//
//  LxLabel.m
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import "CCCustomLabel.h"
#import "UIHeader.h"
@implementation CCCustomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.verticalAlignment = VerticalAlignmentMiddle;
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        [self setup];
    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor backColor:(UIColor *)backColor{
    self = [self initWithFrame:frame withFontSize:fontSize withTextColor:textColor backColor:backColor withTextAlignment:0];
    return self;
}

/**
 *  //传入颜色，字体大小
 *
 *  @param frame         大小
 *  @param fontSize      字体大小
 *  @param textColor     字的颜色
 *  @param textAlignment 字的位置
 *
 *  @return  instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor backColor:(UIColor *)backColor withTextAlignment:(NSTextAlignment)textAlignment{
    self = [self initWithFrame:frame];
    if (self) {
        if (fontSize > 0) {
            self.font = [UIFont systemFontOfSize:fontSize];
        }
        
        if (textColor) {
            self.textColor = textColor;
        }
        
        if (backColor) {
            self.backgroundColor = backColor;
        }
        
        self.textAlignment = textAlignment;
        
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}


- (void)setup
{
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self addGestureRecognizer:_longPressGestureRecognizer];
    
    _copyMenuArrowDirection = UIMenuControllerArrowDefault;
    
    _copyingEnabled = NO;
    self.userInteractionEnabled = _copyingEnabled;
}


- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

/**
 判断是否为适应宽度 还是高度   是  适应宽度   否  适应高度
 @parm isWidth  是  适应宽度   否  适应高度
 */
- (CGRect )calculate:(BOOL)isWidth{

    
    CGRect oldframe = [self calculate:isWidth isHeight:NO] ;

    
    return oldframe;
}


/**
 *    isWidth 判断是否为适应宽度 还是高度   是  适应宽度   否  适应高度   只有isWidth为YES时  isheight  才有效
 *
 *  @param isWidth  是  适应宽度   否  适应高度
 *  @param isheight isheight  是 取计算出的高度   否  取self.frame.height
 *
 *  @return <#return value description#>
 */
- (CGRect)calculate:(BOOL)isWidth isHeight:(BOOL)isheight{
    CGSize contsize ;
    if (isWidth) {
        contsize = CGSizeMake(20000, self.frame.size.height) ;
    }else{
        contsize = CGSizeMake(self.frame.size.width, 20000) ;
    }
    
    CGRect oldframe = self.frame ;
    CGSize size = [self.text calculateheight:self.font andcontSize:contsize] ;
    if (isWidth) {
        oldframe.size.width = size.width ;
        if (isheight) {
            oldframe.size.height = size.height ;
        }
    }else{
        oldframe.size.height = size.height ;
    }
    
    return oldframe;
}


/**
 *  设置 多种颜色字体显示  多种字体大小显示
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright{
    
    if (self.text.length > 0 ) {
        NSMutableAttributedString *mutabPriceName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.text]];
     
        if (self.attributedText.length != 0) {
            [mutabPriceName deleteCharactersInRange:NSMakeRange(0, self.text.length)];
            [mutabPriceName appendAttributedString:self.attributedText];
        }
        NSRange rang = [self.text rangeOfString:equalString];
        if (rang.location != NSNotFound) {
            if (isright) {
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentRight;//设置对齐方式
                
                [mutabPriceName setAttributes:@{NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.text.length)];
            }
            if (font) {
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:NSMakeRange(rang.location, self.text.length - rang.location)];
            }else{
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(rang.location, self.text.length - rang.location)];
            }
            self.attributedText = mutabPriceName ;
        }
    }
}

/**
 *  设置 多种颜色字体显示  多种字体大小显示  传的值有多长显多长的
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedWidthColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright{
   
    if (self.text.length > 0 ) {
        NSMutableAttributedString *mutabPriceName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.text]];
        if (self.attributedText.length != 0) {
            [mutabPriceName deleteCharactersInRange:NSMakeRange(0, self.text.length)];
            [mutabPriceName appendAttributedString:self.attributedText];
        }
        
        NSRange rang = [self.text rangeOfString:equalString];
        if (rang.location != NSNotFound) {
            if (isright) {
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentRight;//设置对齐方式
                
                [mutabPriceName setAttributes:@{NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.text.length)];
            }
            if (font) {
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}
                                        range:NSMakeRange(rang.location, equalString.length)];
            }else{
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(rang.location,equalString.length)];
            }
            
            self.attributedText = mutabPriceName ;
            
        }
        
    }
}

/**
 *  设置多种字对应不同的颜色  isAll 查找字一样  是否替换成一样的字体颜色字体的大小
 *
 *  @param colorArray  颜色数组
 *  @param fontArray   字体数组
 *  @param stringArray 字数组
 *  @param isAll       查找字一样  是否替换成一样的字体颜色字体的大小
 */
- (void)setVariedColorArray:(NSArray *)colorArray fontArray:(NSArray *)fontArray string:(NSArray *)stringArray isAll:(BOOL)isAll{
    if (self.text.length > 0 ) {
        // 去掉 stringArray  空字符串
        NSMutableArray *tempStringArray = [[NSMutableArray alloc] init];
        NSMutableArray *tempColorArray = [[NSMutableArray alloc] init] ;
        NSMutableArray *tempFontArray = [[NSMutableArray alloc] init];
        for (NSInteger  i = 0 ; i < stringArray.count; i ++ ) {
            NSString *tempstr = [stringArray objectAtIndex:i] ;
            if (tempstr.length != 0 ) {
                // 字符串不为空  存放到临时的数组
                [tempStringArray addObject:tempstr];
                UIColor *tempColor = self.textColor ;  // 默认的字体颜色为self 的字体颜色
                UIFont *tempFont = self.font ;         // 默认的字体大小为self 的字体大小
                if (i < colorArray.count) {
                    
                    tempColor = colorArray[i];
                }
                [tempColorArray addObject:tempColor];
                if (i < fontArray.count) {
                    tempFont = fontArray[i];
                }
                [tempFontArray addObject:tempFont];
            }
        }
        stringArray = [tempStringArray copy];
        colorArray  = [tempColorArray copy] ;
        fontArray   = [tempFontArray copy] ;
        // 是否大于0
        if(stringArray.count > 0 ){
            // 将label上的字存放到临时的变量中
            NSString *tempString = self.text ;
            // 取出 stringArray 数组第一个字符串
            NSString *muArrayStr = stringArray[0] ;
            // 匹配到的字符串的下表位置 数组
            NSMutableArray *locationMArray = [[NSMutableArray alloc] init];
            // 匹配是否存在
            NSRange range = [tempString rangeOfString:muArrayStr];
            int count = 0 ;  // 循环的次数
            NSInteger strLength = 0 ;  // 上一个 muArrayStr 的长度
            
            if(range.length>0)
            {
                while (range.length > 0 ) {
                    // 匹配到字符串的开始位置
                    NSInteger startIndex = range.location + range.length;
                    // 取出数组最后一个值
                    NSInteger lastCount = [[locationMArray lastObject] integerValue];
                        // 取到的值 加上一个匹配字符串的长度
                        lastCount = lastCount + strLength;
                    // 加到字符串中
                    [locationMArray  addObject:[NSString stringWithFormat:@"%lu",(long)(range.location  + lastCount)]] ;
                    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
                    
                    UIColor *color = self.textColor ;
                    UIFont *font = self.font ;
                    if (count < colorArray.count) {
                        color = (UIColor *)[colorArray objectAtIndex:count];
                    }else{
                        if (isAll) {
                            color = (UIColor *)[colorArray firstObject] ;
                        }
                    }
                    if (count < fontArray.count) {
                        font = [fontArray objectAtIndex:count] ;
                    }else{
                        if (isAll) {
                            font = (UIFont *)[fontArray firstObject];
                        }
                    }
                    NSRange tempRang = NSMakeRange([[locationMArray lastObject] integerValue],muArrayStr.length) ;
                    [mutableString addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:tempRang];
                    
                    self.attributedText = mutableString ;
                    count ++ ;
                    strLength = muArrayStr.length ;
                    // 取出下个要匹配的字符串
                    if (count < stringArray.count) {
                        muArrayStr = stringArray[count] ;
                    }
                    // 除掉上个匹配到的字符串的剩下的长度
                    NSInteger endIndex = tempString.length -startIndex;
                    // 取出 剩下的字符串
                    tempString= [tempString substringWithRange:NSMakeRange(startIndex, endIndex)];
                    
                    range = [tempString rangeOfString:muArrayStr];

                }
            } 
          
        }
    }
}

/**
 *  复写字的范围
 *
 *  @param requestedRect  requestedRect
 */
-(void)drawTextInRect:(CGRect)requestedRect {
    if (self.contentFrame.size.width == 0 || self.contentFrame.size.height == 0) {
        CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
        [super drawTextInRect:actualRect];
    }
    else{
        CGRect actualRect = [self textRectForBounds:self.contentFrame limitedToNumberOfLines:self.numberOfLines];
        [super drawTextInRect:actualRect];
    }
}


/**
 *  复写设置内容的范围
 *
 *  @param contentFrame  contentFrame
 */
-(void)setContentFrame:(CGRect)contentFrame{
    _contentFrame = contentFrame;
    [self drawRect:_contentFrame];
}


/**
 *  计算  行行之间的间距
 *
 *  @param lineSpace 间距
 *
 *  @return 返回字的大小
 */
- (CGSize)getLabelSizeHeight:(NSInteger)lineSpace {
    if (self.text.length != 0 ) {
        NSMutableAttributedString * attributedString1 ;
        if (self.attributedText.length) {
            attributedString1 = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        }else{
            attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.text];
        }
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:lineSpace];
        /**
         *  设置根据你设置的左右对齐设置, 默认是左对齐.fix by chenzl
         */
        [paragraphStyle1 setAlignment:self.textAlignment];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.text length])];
        [self setAttributedText:attributedString1];
        
        //调节高度
        CGSize size = CGSizeMake(self.frame.size.width, 500000);
        CGSize labelSize = [self sizeThatFits:size];
        return labelSize ;
    }else{
        return CGSizeZero; 
    }
    
}
/**
 *  计算 字的高度  根据 单个字的高度设置的
 *
 *  @param lineSpace lineSpace
 *  @param size size
 *
 *  @return CGSize
 */
- (CGSize)getLabelSizeHeight:(NSInteger)lineSpace onlyText:(CGSize)size{
    if (self.text.length > 0 ) {
        CGSize currsize = [self getLabelSizeHeight:lineSpace] ;
        
        NSInteger currInt = (int)currsize.height ;
        NSInteger sizeInt = (int)size.height ;
        if ((currInt - lineSpace) / sizeInt == 1 && (currInt - lineSpace) % sizeInt == 0) {
            currsize = [self getLabelSizeHeight:0];
        }
        return currsize;
    }else{
        return CGSizeZero;
    }
   
}



#pragma mark - Public

- (void)setCopyingEnabled:(BOOL)copyingEnabled
{
    if (_copyingEnabled != copyingEnabled)
    {
        [self willChangeValueForKey:@"copyingEnabled"];
        _copyingEnabled = copyingEnabled;
        [self didChangeValueForKey:@"copyingEnabled"];
        
        self.userInteractionEnabled = copyingEnabled;
        self.longPressGestureRecognizer.enabled = copyingEnabled;
    }
}

#pragma mark - Callbacks

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer == self.longPressGestureRecognizer)
    {
        if (!_copyingEnabled) {
            return ;
        }
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
            [self becomeFirstResponder];
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            if ([self.copyableLabelDelegate respondsToSelector:@selector(copyMenuTargetRectInCopyableLabelCoordinates:)])
            {
                [copyMenu setTargetRect:[self.copyableLabelDelegate copyMenuTargetRectInCopyableLabelCoordinates:self] inView:self];
            }
            else
            {
                [copyMenu setTargetRect:self.bounds inView:self];
            }
            copyMenu.arrowDirection = self.copyMenuArrowDirection;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    if (action == @selector(copy:))
    {
        if (self.copyingEnabled)
        {
            retValue = YES;
        }
    }
    else
    {
        // Pass the canPerformAction:withSender: message to the superclass
        // and possibly up the responder chain.
        retValue = [super canPerformAction:action withSender:sender];
    }
    
    return retValue;
}

- (void)copy:(id)sender
{
    if (self.copyingEnabled)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSString *stringToCopy;
        if ([self.copyableLabelDelegate respondsToSelector:@selector(stringToCopyForCopyableLabel:)])
        {
            stringToCopy = [self.copyableLabelDelegate stringToCopyForCopyableLabel:self];
        }
        else
        {
            stringToCopy = self.text;
        }
        
        [pasteboard setString:stringToCopy];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
