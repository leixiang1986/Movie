//
//  CCCinemaDetailMsgSeatCollectionCell.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailMsgSeatCollectionCell.h"
#import "CCCinemaDetailMsgDashBorderView.h"

@interface CCCinemaDetailMsgSeatCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet CCCinemaDetailMsgDashBorderView *backView;
@property (nonatomic, assign) BOOL drawed;
@end


@implementation CCCinemaDetailMsgSeatCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

//    [self.backView ];


}

- (void)layoutSubviews {
    [super layoutSubviews];
//    if (!_drawed) {
//        [self addBorderLayer];
//    }
    self.backView.layer.cornerRadius = self.backView.height / 2;
    [self bringSubviewToFront:self.contentLabel];
}

- (void)addBorderLayer {
    _drawed = YES;
    CCLog(@"%@====draw",self);
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor redColor].CGColor;

//    border.fillColor = UIColorFromHex(COLOR_F5F6F8).CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.height, self.height) cornerRadius:self.bounds.size.height / 2].CGPath;
    ;

    border.frame = self.bounds;

    border.lineWidth = ScreenGridViewHeight * 2;

    border.lineCap = @"round";

    border.lineDashPattern = @[@8, @8];

    [self.backView.layer insertSublayer:border atIndex:0];
}



@end
