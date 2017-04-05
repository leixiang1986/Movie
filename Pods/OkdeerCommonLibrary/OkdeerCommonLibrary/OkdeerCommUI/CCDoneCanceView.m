//
//  CCDoneCanceView.m
//  CloudCity
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 huangshp. All rights reserved.
//

#import "CCDoneCanceView.h"
#import "CCCustomButton.h"
#import "UIHeader.h"
#import "OkdeerCommUIHeader.h"

@interface CCDoneCanceView ()

@property (nonatomic,strong) CCCustomButton *canceBtn;                  /**< 取消按钮 */
@property (nonatomic,strong) CCCustomButton *doneBtn;                   /**< 确认按钮 */
@property (nonatomic,strong) CALayer *buttonLineLayer;                   /**< 按钮之间的分割线*/
@property (nonatomic,copy) ButtonClickVoidBlock doneBlock;               /**< 完成 block */
@property (nonatomic,copy) ButtonClickVoidBlock canceBlock;              /**< 取消block */
@property (nonatomic,strong) CALayer * lineLayer;                        /**< 分割线*/

@end

@implementation CCDoneCanceView
- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupViewFrame]; 
}

#pragma mark - //****************** 事件 action ******************//
/**
 *  点击事件的回调
 */
- (void)doneBlock:(ButtonClickVoidBlock)doneBlock canceBlock:(ButtonClickVoidBlock)canceBlock{
    _doneBlock = doneBlock ;
    _canceBlock = canceBlock;
}
/**
 *  设置view 的位置
 */
- (void)setupViewFrame{
    self.canceBtn.frame = CGRectMake(0,0,kUIFullWidth / 2.0f ,self.height);
    self.doneBtn.frame = CGRectMake(self.canceBtn.right,self.canceBtn.top,self.canceBtn.width,self.canceBtn.height);
    self.buttonLineLayer.frame = CGRectMake(self.canceBtn.right, 0, 1, self.canceBtn.height);
    self.lineLayer.frame = CGRectMake(0, 0, self.width, 1);
}

#pragma mark - //****************** getter ******************//
- (CCCustomButton *)canceBtn{
    if (!_canceBtn) {
        _canceBtn = [CCCustomButton buttonWithType:UIButtonTypeCustom];
        [_canceBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_canceBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateNormal];
        _canceBtn.titleLabel.font = FONTDEFAULT(18);
        _canceBtn.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelef = self;
        _canceBtn.buttonClickBlock = ^(CCCustomButton *button){
            __strong typeof(self) strongSelf = weakSelef;
            if (strongSelf && strongSelf.canceBlock) {
                strongSelf.canceBlock();
            }
        };
        [self addSubview:_canceBtn];
    }
    return _canceBtn;
}
- (CCCustomButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [CCCustomButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitleColor:UIColorFromHex(0x8CC63F) forState:UIControlStateNormal];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = FONTDEFAULT(18);
        _doneBtn.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelef = self;
        _doneBtn.buttonClickBlock = ^(CCCustomButton *button){
            __strong typeof(self) strongSelf = weakSelef;
            if (strongSelf && strongSelf.doneBlock) {
                strongSelf.doneBlock();
            }
        };
        [self addSubview:_doneBtn];
    }
    return _doneBtn;
}
- (CALayer *)buttonLineLayer{
    if (!_buttonLineLayer) {
        _buttonLineLayer = [CALayer layer];
        _buttonLineLayer.backgroundColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
        [self.layer addSublayer:_buttonLineLayer];
    }
    return _buttonLineLayer;
}
- (CALayer *)lineLayer{
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
        _lineLayer.backgroundColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
        [self.layer addSublayer:_lineLayer];
    }
    return _lineLayer ;
}

@end
