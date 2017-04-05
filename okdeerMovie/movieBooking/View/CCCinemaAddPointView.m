//
//  CCCinemaAddPointView.m
//  okdeerMovie
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaAddPointView.h"

@implementation CCCinemaAddPointView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext(); //设置上下文
    /*画圆角矩形*/
    float fw = self.frame.size.width - 10;
    float fh = self.frame.size.height - 10;
    CGContextMoveToPoint(context, fw, fh-10);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-10, fh, 3);  // 右下角角度
    
    //中间切入一个小三角形
    CGContextAddLineToPoint(context, fw /2 + 10, fh);
    CGContextAddLineToPoint(context, fw /2 + 5, fh + 7);
    CGContextAddLineToPoint(context, fw /2 , fh);
    
    CGContextAddArcToPoint(context, 10, fh, 10, fh-10, 3); // 左下角角度
    CGContextAddArcToPoint(context, 10, 10, fw-10, 10, 3); // 左上角
    
    CGContextAddArcToPoint(context, fw, 10, fw, fh-10, 3); // 右上角
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
}

@end
