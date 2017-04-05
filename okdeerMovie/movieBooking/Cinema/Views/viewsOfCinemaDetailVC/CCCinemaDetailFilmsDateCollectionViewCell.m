//
//  CCCinemaDetailFilmsDateCollectionViewCell.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsDateCollectionViewCell.h"

@interface CCCinemaDetailFilmsDateCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation CCCinemaDetailFilmsDateCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUnSelectedUI];
    self.lineView.backgroundColor = UIColorFromHex(COLOR_E2E2E2);
    self.lineViewHeightConstraint.constant = ScreenGridViewHeight;
}


- (void)setDate:(NSString *)date select:(BOOL)select {
    self.label.text = date;
    self.selected = select;
}

//设置选中的UI状态
- (void)setupSelectedUI {
    self.label.textColor = UIColorFromHex(COLOR_8CC63F);

}

//设置非选中的UI状态
- (void)setupUnSelectedUI {
    self.label.textColor = UIColorFromHex(COLOR_666666);

}

// 复写选中方法
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self setupSelectedUI];
    }
    else {
        [self setupUnSelectedUI];
    }
}

@end
