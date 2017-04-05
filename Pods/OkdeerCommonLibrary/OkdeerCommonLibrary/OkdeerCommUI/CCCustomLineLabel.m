//
//  CCCustomLineLabel.m
//  CloudCity
//
//  Created by Mac on 15/7/2.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "CCCustomLineLabel.h"
#import "UIHeader.h"
@implementation CCCustomLineLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.strikeThroughColor = UIColorFromHex(0x999999);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    
    CGSize textSize = [[self text] calculateheight:[self font]];
    CGFloat strikeWidth = textSize.width;
    
    CGRect lineRect;
    // 画线居中
    lineRect = CGRectMake(0, rect.size.height/2, strikeWidth, 1);
    // 画线居下
    //lineRect = CGRectMake(firstTextWidth, rect.size.height/2 + textSize.height/2, strikeWidth-firstTextWidth, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*设置划线颜色*/
    CGContextSetFillColorWithColor(context, [self strikeThroughColor].CGColor);
    CGContextFillRect(context, lineRect);
}

@end
