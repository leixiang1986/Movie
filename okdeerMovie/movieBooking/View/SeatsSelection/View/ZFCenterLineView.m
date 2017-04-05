//
//  ZFCenterLineView.m
//  
//
//  Created by qq 316917975  on 16/1/28.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//

#import "ZFCenterLineView.h"
#import "UIView+Extension.h"
@interface ZFCenterLineView ()

@property (weak, nonatomic) UIButton *centerLineBtn;
@property (nonatomic, strong) UIView *centerLineV;

@end

@implementation ZFCenterLineView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initCenterLineBtn];
        
    }
    return self;
}
-(void)initCenterLineBtn{
    //moviebooking_screencenter@2x
    UIView *centerlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
    
    UIImageView *centerLineImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
    centerLineImgV.image = [UIImage imageNamed:@"moviebooking_screencenter"];
    [centerlineView addSubview:centerLineImgV];
    
    UILabel *centerlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
    centerlabel.text = @"银幕中央";
    centerlabel.textAlignment = NSTextAlignmentCenter;
    centerlabel.font = FONTDEFAULT(10);
    centerlabel.textColor = UIColorFromHex(COLOR_666666);
    [centerlineView addSubview:centerlabel];
    
    self.centerLineV = centerlineView;
    [self addSubview:self.centerLineV];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.centerLineV.centerX = self.width * 0.5;
    
//    self.centerLineBtn.width = 50;
//    self.centerLineBtn.height = 15;
//    self.centerLineBtn.y = -15;
//    self.centerLineBtn.centerX = self.width * 0.5;
}

//// --- 中线分割线
//-(void)setHeight:(CGFloat)height{
//    
//    [super setHeight:height];
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect {
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
//    CGFloat lengths[] = {6,3};
//    CGContextSetLineDash(context, 0, lengths,2);
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
//    CGContextStrokePath(context);
//}


@end
