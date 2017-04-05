//
//  CCFilmOrderDetailView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmOrderDetailView.h"


@interface CCFilmOrderDetailView ()
//电影票信息
@property (weak, nonatomic) IBOutlet UILabel *filmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIView *tipsBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateBottomConstraint; //默认权限250
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipsBottomConstraint;  //默认权限1000



//取票信息
@property (weak, nonatomic) IBOutlet UIView *obtainBackView;
@property (weak, nonatomic) IBOutlet UILabel *obtainCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *obtainTipsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filmMsgBackViewToPhoneConstraint;  /**< 电影信息背景view到电话顶部的约束 默认为250 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *obtainCodeBackViewToPhoneConstraint;   /**< 取票码到手机号的约束 默认为1000 */

//订单信息
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;           /**< 电话号码 */
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;         /**< 订单id */
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;      /**< 订单总额 */
@property (weak, nonatomic) IBOutlet UILabel *orderPreferentialLabel;   /**< 优惠 */
@property (weak, nonatomic) IBOutlet UILabel *orderPayLabel;      /**< 应付 */


//影院信息
@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end


@implementation CCFilmOrderDetailView



#pragma mark - 数据显示相关
/**
 *  设置model
 */
- (void)setModel:(CCFilmOrderDetailModel *)model {
    _model = model;
    [self setupDataWithModel];
}

/**
 *  根据model，显示数据
 */
- (void)setupDataWithModel {
    _filmNameLabel.text = _model.filmName;
    _roomLabel.text = _model.room;
    _timeLabel.text = _model.time;
    _seatsLabel.text = _model.seats;
    [self setupOrderState]; /**< 订单状态 */
    
    
}

/**
 * 设置取票码显示数据
 */
- (void)setupObtainCodeData {
    //取票码信息
    self.obtainCodeLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",_model.obtainCode,_model.obtainOrderId,_model.obtainThirdId];
    //取票码提示信息
    if (!_model.obtainTips.length) {
        return;
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_model.obtainTips attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : UIColorFromHex(COLOR_666666)}];
    if (_model.obtainCode.length) {
        self.obtainTipsLabel.attributedText = attStr;
        return;
    }

    NSRange range = [_model.obtainTips rangeOfString:_model.obtainCode];
    if (range.length == NSNotFound) {
        return;
    }

    [attStr addAttributes:@{NSForegroundColorAttributeName : UIColorFromHex(COLOR_8CC63F)} range:range];
    self.obtainTipsLabel.attributedText = attStr;
}


#pragma mark - 设置订单状态相关
/**
 * 设置订单状态
 */
- (void)setupOrderState{
    switch (_model.state.type) {
        case CCFilmOrderTypeFail:       /**< 失败已退款 */
            [self setupOrderStateTypeOfFail];
            break;

        case CCFilmOrderTypeRefunding:  /**< 失败退款中 */
            [self setupOrderStateTypeOfRefunding];
            break;

        case CCFilmOrderTypeIssuing:    /**< 正在出票 */
            [self setupOrderStateTypeOfIssuing];
            break;

        case CCFilmOrderTypeSucceed:    /**< 出票成功 */
            [self setupOrderStateTypeOfSucceed];

            break;

        default:
            break;
    }

}

/**
 * 设置出票失败，正在退款的界面
 */
- (void)setupOrderStateTypeOfRefunding {
    if (!_model.state.stateName.length) {
        return;
    }
    NSString *state = _model.state.stateName;
    if (_model.state.note.length) {
        state = [NSString stringWithFormat:@"%@(%@)",_model.state.stateName,_model.state.note];
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:state attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : UIColorFromHex(COLOR_333333)}];
    if (_model.state.note.length) {
        NSRange range = [state rangeOfString:_model.state.note];
        if (range.location != NSNotFound) {
            [attStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : UIColorFromHex(COLOR_FF3300)} range:range];
        }
    }

    self.stateLabel.attributedText = attStr;

    [self showTipsLabel];
    [self hideObtainBackView];

}

/**
 *  设置出票失败已退款的界面
 */
- (void)setupOrderStateTypeOfFail {
    if (!_model.state.stateName.length) {
        return;
    }

    self.stateLabel.text = _model.state.stateName;

    [self showTipsLabel];
    [self hideObtainBackView];

}

/**
 *  设置出票中的界面
 */
- (void)setupOrderStateTypeOfIssuing {
    if (!_model.state.stateName.length) {
        return;
    }

    NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:_model.state.stateName attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : UIColorFromHex(0xff5a00)}];
    self.stateLabel.attributedText = attriStr;

    [self showTipsLabel];
    [self hideObtainBackView];
}

/**
 *  设置出票成功界面
 */
- (void)setupOrderStateTypeOfSucceed {
    if (!_model.state.stateName.length) {
        return;
    }

    NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:_model.state.stateName attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : UIColorFromHex(COLOR_8CC63F)}];
    self.stateLabel.attributedText = attriStr;
    [self showObtainBackView];
    [self hideTipsLabel];
}


#pragma mark - action
/**
 *  影院电话点击事件
 */
- (IBAction)phoneClick:(id)sender {
    CCLog(@"拨打电话");

}


#pragma mark - 提示信息的隐藏显示

/**
 *  隐藏提示信息，隐藏默认显示tipsLabel，如果不需要调用这个方法
 */
- (void)hideTipsLabel {
    self.stateBottomConstraint.priority = UILayoutPriorityRequired - 1;
    self.tipsBottomConstraint.priority = 100;

    self.tipsBackView.hidden = YES;
}

/**
 *  显示提示信息,默认为显示，如果调用了hiteTipsLabel
 */
- (void)showTipsLabel {
    self.stateBottomConstraint.priority = 100;
    self.tipsBottomConstraint.priority = UILayoutPriorityRequired - 1;
    self.tipsBackView.hidden = NO;
}



#pragma mark - 取票信息的显示与隐藏
/**
 *   取票码的显示，默认显示，如果掉用了隐藏的信息,没有掉用隐藏方法不用使用本方法
 */
- (void)showObtainBackView {
    self.filmMsgBackViewToPhoneConstraint.priority = 100;
    self.obtainCodeBackViewToPhoneConstraint.priority = UILayoutPriorityRequired - 1;
    self.obtainBackView.hidden = NO;
}

/**
 *   取票码的隐藏方法,默认是显示，如果需要隐藏，掉用本方法
 */
- (void)hideObtainBackView {
    self.filmMsgBackViewToPhoneConstraint.priority = UILayoutPriorityRequired - 1;
    self.obtainCodeBackViewToPhoneConstraint.priority = 100;
    self.obtainBackView.hidden = YES;
}



@end
