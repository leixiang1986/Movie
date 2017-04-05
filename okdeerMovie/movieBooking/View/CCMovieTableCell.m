//
//  CCMovieTableCell.m
//  okdeerMovie
//
//  Created by Mac on 16/12/7.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCMovieTableCell.h"

@interface CCMovieTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *cinemaTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leastPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *newerImageView;
@property (weak, nonatomic) IBOutlet UIView *favourableView;        //优惠的底部图片view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *favourableViewHeightConstraint;                                //优惠的底部view高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loverWidthConstraint;  //情侣的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loverRightConstraint;  //情侣的右侧约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newerWidthConstraint;  // 新人的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstraint;



@end


@implementation CCMovieTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineHeightConstraint.constant = ScreenGridViewHeight;
}






#pragma mark - /**********优惠显示设置************/
#pragma mark /**********单个的隐藏显示**********/
// 设置整个优惠信息是否显示
- (void)hideFavourate:(BOOL)hide {
    if (hide) {
        self.favourableView.hidden = YES;
        self.favourableViewHeightConstraint.constant = 0;
    }
    else {
        self.favourableView.hidden = NO;
        self.favourableViewHeightConstraint.constant = 30;
    }
}
// 是否隐藏情侣的优惠
- (void)hideLover:(BOOL)hide {
    if (hide) {
        self.loverImageView.hidden = YES;
        self.loverWidthConstraint.constant = 0;
        self.loverRightConstraint.constant = 0;
    }
    else {
        self.loverImageView.hidden = NO;
        self.loverWidthConstraint.constant = 47;
        self.loverRightConstraint.constant = 10;

    }
}

// 是否显示新人优惠
- (void)hideNewer:(BOOL)hide {
    if (hide) {
        self.newerImageView.hidden = YES;
        self.newerWidthConstraint.constant = 0;
    }
    else {
        self.newerImageView.hidden = NO;
        self.newerWidthConstraint.constant = 56;
    }
}

#pragma mark /******逻辑设置******/
//设置只有情侣的优惠显示
- (void)setupLoverFavourable {
    [self hideFavourate:NO];
    [self hideLover:NO];
    [self hideNewer:YES];
}

//设置只有新人特惠的显示
- (void)setupNewerFavourable {
    [self hideLover:YES];
    [self hideNewer:NO];
}

//新人特惠和情侣
- (void)setupLoverAndNewerFavourable {
    [self hideLover:NO];
    [self hideNewer:NO];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
