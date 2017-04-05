//
//  CCCinemaDetailMsgDashBorderView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailMsgDashBorderView.h"


@interface CCCinemaDetailMsgDashBorderView ()
@property (nonatomic, strong) CAShapeLayer *border;
@end

@implementation CCCinemaDetailMsgDashBorderView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addBorderLayer];

}

- (void)addBorderLayer {
    if (_border) {
        [_border removeFromSuperlayer];
    }

    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
    border.fillColor = UIColorFromHex(COLOR_F5F6F8).CGColor;
    border.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(ScreenGridViewHeight, ScreenGridViewHeight, self.width - 2 * ScreenGridViewHeight, self.height - 2 * ScreenGridViewHeight) cornerRadius:self.layer.cornerRadius].CGPath;
    ;
    border.frame = self.bounds;
    border.lineWidth = ScreenGridViewHeight;
//    border.lineCap = @"round";
    border.lineDashPattern = @[@4, @4];

    _border = border;
    [self.layer insertSublayer:border atIndex:0];
}
@end
