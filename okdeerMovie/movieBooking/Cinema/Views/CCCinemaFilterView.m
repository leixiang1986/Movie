//
//  CCCinemaFilterView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaFilterView.h"

@interface CCCinemaFilterView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation CCCinemaFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineHeightConstraint.constant = ScreenGridViewHeight;
    [_leftBtn setTitle:@"区域" forState:(UIControlStateNormal)];
    [_rightBtn setTitle:@"离我最近" forState:(UIControlStateNormal)];
    [_leftBtn setTitleColor:UIColorFromHex(COLOR_999999) forState:(UIControlStateNormal)];
    [_leftBtn setTitleColor:UIColorFromHex(COLOR_8CC63F) forState:(UIControlStateSelected)];
    [_leftBtn setTitleColor:UIColorFromHex(COLOR_8CC63F) forState:(UIControlStateDisabled)];
    [_rightBtn setTitleColor:UIColorFromHex(COLOR_999999) forState:(UIControlStateNormal)];
    [_rightBtn setTitleColor:UIColorFromHex(COLOR_8CC63F) forState:(UIControlStateSelected)];
    [_rightBtn setTitleColor:UIColorFromHex(COLOR_8CC63F) forState:(UIControlStateDisabled)];

    [_leftBtn setImage:[UIImage imageNamed:@"moviebooking_arrow_select"] forState:(UIControlStateSelected)];
    [_leftBtn setImage:[UIImage imageNamed:@"moviebooking_arrow_default"] forState:(UIControlStateNormal)];
    
    [_rightBtn setImage:[UIImage imageNamed:@"moviebooking_arrow_select"] forState:(UIControlStateSelected)];
    [_rightBtn setImage:[UIImage imageNamed:@"moviebooking_arrow_default"] forState:(UIControlStateNormal)];
    [_leftBtn setImage:[[UIImage imageNamed:@"moviebooking_arrow_select"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateDisabled)];
    [_rightBtn setImage:[[UIImage imageNamed:@"moviebooking_arrow_select"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateDisabled)];
    _oldSelectedIndex = CCCinemaFilterViewSelectTypeNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupBtnTitleAndImageDisplay:_leftBtn];
    [self setupBtnTitleAndImageDisplay:_rightBtn];
}

//设置按钮的布局
- (void)setupBtnTitleAndImageDisplay:(UIButton *)btn {
    CGFloat space = 10;
    CGFloat imageViewWidth = CGRectGetWidth(btn.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(btn.titleLabel.frame);

    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0,0 + labelWidth + space,0,0 - labelWidth + space / 2 );
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsMake(0,0 - imageViewWidth - space / 2,0, 0 + imageViewWidth + space / 2);
    btn.imageEdgeInsets = imageEdgeInsets;
    btn.titleEdgeInsets = titleEdgeInsets;
}

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle {
    _leftBtnTitle = leftBtnTitle;
    if (_leftBtnTitle) {
        [_leftBtn setTitle:_leftBtnTitle forState:(UIControlStateNormal)];
    }
    [self setupBtnTitleAndImageDisplay:_leftBtn];
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle {
    _rightBtnTitle = rightBtnTitle;
    if (_rightBtnTitle) {
        [_rightBtn setTitle:_rightBtnTitle forState:(UIControlStateNormal)];
    }
    [self setupBtnTitleAndImageDisplay:_rightBtn];
}


- (IBAction)leftBtnClick:(id)sender {

    [self setupLeftClickBtnUI];
    _selectedIndex = CCCinemaFilterViewSelectTypeLeft;
    if (self.selectBlock) {
        self.selectBlock(self,CCCinemaFilterViewSelectTypeLeft,_oldSelectedIndex);
    }
    if (_oldSelectedIndex == CCCinemaFilterViewSelectTypeLeft) {
        _oldSelectedIndex = CCCinemaFilterViewSelectTypeNone;
    }
    else {
        _oldSelectedIndex = CCCinemaFilterViewSelectTypeLeft;
    }
}

- (IBAction)rightBtnClick:(id)sender {

    [self setupRightClickBtnUI];
    _selectedIndex = CCCinemaFilterViewSelectTypeRight;
    if (self.selectBlock) {
        self.selectBlock(self,CCCinemaFilterViewSelectTypeRight,_oldSelectedIndex);
    }
    if (_oldSelectedIndex == CCCinemaFilterViewSelectTypeRight) {
        _oldSelectedIndex = CCCinemaFilterViewSelectTypeNone;
    }
    else {
        _oldSelectedIndex = CCCinemaFilterViewSelectTypeRight;
    }
}

//设置选中或非选中
- (void)setSelect:(BOOL)select atIndex:(CCCinemaFilterViewSelectType)selectIndex {
    if (selectIndex == CCCinemaFilterViewSelectTypeLeft) {
        self.leftBtn.selected = !select;
        [self setupLeftClickBtnUI];
    }
    else if (selectIndex == CCCinemaFilterViewSelectTypeRight) {
        self.rightBtn.selected = !select;
        [self setupRightClickBtnUI];
    }

    if (select) {
        _selectedIndex = selectIndex;
    }
    else {
        _oldSelectedIndex = CCCinemaFilterViewSelectTypeNone;
    }

}

// 设置左侧筛选按钮点击的UI
- (void)setupLeftClickBtnUI {
    self.leftBtn.userInteractionEnabled = NO;
    self.rightBtn.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.leftBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        if (self.rightBtn.selected) { //点击左侧按钮，右侧是选中的，则右侧动画变为非选中
            self.rightBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }

    } completion:^(BOOL finished) {
        self.leftBtn.selected = !self.leftBtn.selected;
        self.rightBtn.selected = NO;
        self.rightBtn.imageView.transform = CGAffineTransformIdentity;
        self.leftBtn.imageView.transform = CGAffineTransformIdentity;
        self.leftBtn.userInteractionEnabled = YES;
        self.rightBtn.userInteractionEnabled = YES;
    }];
}


// 设置右侧筛选按钮点击的UI
- (void)setupRightClickBtnUI {
    self.leftBtn.userInteractionEnabled = NO;
    self.rightBtn.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.rightBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        if (self.leftBtn.selected) { //点击右侧按钮，左侧是选中的，则左侧动画变为非选中
            self.leftBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    } completion:^(BOOL finished) {
        self.leftBtn.selected = NO;
        self.rightBtn.selected = !self.rightBtn.selected;
        self.leftBtn.imageView.transform = CGAffineTransformIdentity;
        self.rightBtn.imageView.transform = CGAffineTransformIdentity;
        self.leftBtn.userInteractionEnabled = YES;
        self.rightBtn.userInteractionEnabled = YES;
    }];
}


@end
