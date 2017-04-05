//
//  CCFilmOrderListCell.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmOrderListCell.h"

#define kUpLineDistanceToTop 35
#define kUnderLineDistanceToBottom 35

@interface CCFilmOrderListCell ()
@property (nonatomic, strong) CALayer *upLine;
@property (nonatomic, strong) CALayer *underLine;

@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatsLabel;

@end


@implementation CCFilmOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)setModel:(CCFilmOrderListModel *)model {
    _model = model;
    self.cinemaNameLabel.text = _model.cinemaName;
    [self setupOrderStateByType:_model.orderState];
    self.filmNameLabel.text = _model.filmName;
    self.timeLabel.text = _model.time;
    self.roomLabel.text = _model.room;
    self.seatsLabel.text = _model.seats;
    self.priceLabel.text = _model.price;
}

#pragma mark - 业务相关

- (void)setupOrderStateByType:(NSString *)type {
#warning 测试  没有类型判断
    if ([type isEqualToString:@""]) {   //出票中
        self.orderStateLabel.textColor = UIColorFromHex(0xff5a00);
        self.orderStateLabel.text = @"出票中";
    }
    else if ([type isEqualToString:@""]){   //出票成功
        self.orderStateLabel.textColor = UIColorFromHex(COLOR_8CC63F);
        self.orderStateLabel.text = @"出票成功";
    }
    else if ([type isEqualToString:@""]) {  //出票失败
        self.orderStateLabel.textColor = UIColorFromHex(COLOR_FF3333);
        self.orderStateLabel.text = @"出票失败";
    }
}


#pragma mark - UI设置
- (CALayer *)upLine {
    if (!_upLine) {
        _upLine = [CALayer layer];
        _upLine.frame = CGRectMake(0, kUpLineDistanceToTop, self.width, ScreenGridViewHeight);
        _upLine.backgroundColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
    }

    return _upLine;
}

- (CALayer *)underLine {
    if (!_underLine) {
        _underLine = [CALayer layer];
        _underLine.frame = CGRectMake(0, self.height - kUnderLineDistanceToBottom, self.width, ScreenGridViewHeight);
        _underLine.backgroundColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
    }

    return _underLine;
}


- (void)setFrame:(CGRect)frame {
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 10);
    [super setFrame:frame];

}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer addSublayer:self.upLine];
    [self.layer addSublayer:self.underLine];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
