//
//  CCCinemaDetailScaduleFilmsCell.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailScaduleFilmsCell.h"

@interface CCCinemaDetailScaduleFilmsCell ()
@property (weak, nonatomic) IBOutlet UILabel *startLabel;       /**< 开始时间 */
@property (weak, nonatomic) IBOutlet UILabel *endLabel;         /**< 散场时间 */
@property (weak, nonatomic) IBOutlet UILabel *filmTypeLabel;    /**< 国语3D */
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLabel;    /**< IMAX厅 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;       /**< 价格label */
@property (weak, nonatomic) IBOutlet UILabel *activeLabel;      /**< 活动或旧价格label */
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;          /**< 购买btn */

@end

@implementation CCCinemaDetailScaduleFilmsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.buyBtn setTitleColor:UIColorFromHex(COLOR_666666) forState:(UIControlStateDisabled)];
    [self.buyBtn setTitle:@"停止售票" forState:(UIControlStateDisabled)];
    [self.buyBtn setTitle:@"选座购买" forState:(UIControlStateNormal)];
    [self.buyBtn setTitleColor:UIColorFromHex(COLOR_8CC63F) forState:(UIControlStateNormal)];
}

//刷新数据，更新显示
- (void)setModel:(CCCinemaDetailFilmsListModel *)model {
    _model = model;
    self.startLabel.text = _model.startTime;
    self.endLabel.text = _model.endTime;
    self.filmTypeLabel.text = _model.filmType;
    self.roomTypeLabel.text = _model.roomType;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];

    //显示优惠信息还是原价
    self.activeLabel.hidden = NO;
    if (_model.preferentialMsg.length) {
        self.activeLabel.text = _model.preferentialMsg;
    }
    else if (_model.oldPrice.length) {
        [self setupOldPrice:_model.oldPrice];
    }
    else {
        self.activeLabel.hidden = YES;
    }
    //是否可以购买
    [self setBuyBtnUIByCanBuy:_model.canBuy];

}


- (IBAction)buyClick:(id)sender {
    if (self.buyClickBlock) {
        self.buyClickBlock(self);
    }
}



#pragma mark - private method
// 设置购买按钮的UI通过是否可以购买
- (void)setBuyBtnUIByCanBuy:(BOOL)canBy{
    if (canBy) {
        [self.buyBtn setSystemCorneradius:3 withColor:UIColorFromHex(COLOR_8CC63F) withBorderWidth:2];
        [self.buyBtn setBackgroundColor:UIColorFromHex(COLOR_E5E5E5)];
        self.buyBtn.enabled = YES;
    }
    else {
        [self.buyBtn setSystemCorneradius:3 withColor:nil withBorderWidth:0];
        [self.buyBtn setBackgroundColor:[UIColor whiteColor]];
        self.buyBtn.enabled = NO;
    }
}

//设置原价的UI
- (void)setupOldPrice:(NSString *)price {
//    UILabel * strikeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 10, 50, 30))];
    NSString *textStr = [NSString stringWithFormat:@"¥%@",price];

    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:UIColorFromHex(COLOR_666666),NSFontAttributeName : [UIFont systemFontOfSize:14]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];

    // 赋值
    self.activeLabel.attributedText = attribtStr;
}

////设置优惠信息
//- (void)setupPreferentialMsg:(NSString *)msg {
//    self.activeLabel.text = msg;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
