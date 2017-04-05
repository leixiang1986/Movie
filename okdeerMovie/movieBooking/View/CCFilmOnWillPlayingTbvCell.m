//
//  CCFilmOnWillPlayingTbvCell.m
//  okdeerMovie
//
//  Created by Mac on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmOnWillPlayingTbvCell.h"
#import "CCFilmPlayingListModel.h"

@interface CCFilmOnWillPlayingTbvCell ()
@property (weak, nonatomic) IBOutlet UILabel *movieGradelabel;

@property (weak, nonatomic) IBOutlet UIImageView *movieIconImgV;    /**< 电影logo */
@property (weak, nonatomic) IBOutlet UIButton *movieBuyBtn;     /**< 购买 预售按钮 */
@property (weak, nonatomic) IBOutlet UILabel *movieNamelabel;       /**< 电影名称 */
@property (weak, nonatomic) IBOutlet UILabel *movieTypelabel;       /**< 电影类型 */
@property (weak, nonatomic) IBOutlet UILabel *movieDescrilabel;     /**< 电影描述 */
@property (weak, nonatomic) IBOutlet UILabel *movieTimelabel;       /**< 电影播放时间 */
@property (weak, nonatomic) IBOutlet UILabel *moviePlayTimelabel;       /**< 电影上映时间 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *movieDesTrailContraints;   /**< 电影描述距右边约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *movieTimeConstraint;   /**< 电影时间距右边约束 */

@end

@implementation CCFilmOnWillPlayingTbvCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _movieIconImgV.backgroundColor = UIColorFromHex(COLOR_FF3333);
    _movieBuyBtn.layer.cornerRadius = 3.0f;
    _movieBuyBtn.layer.masksToBounds = YES;
    _movieBuyBtn.layer.borderWidth = 1.f;
    _movieNamelabel.textColor = UIColorFromHex(COLOR_333333);
    _movieDescrilabel.textColor = UIColorFromHex(COLOR_666666);
    _movieTimelabel.textColor = UIColorFromHex(COLOR_666666);
    _moviePlayTimelabel.textColor = UIColorFromHex(0xff5a0b);
    _movieGradelabel.layer.cornerRadius = _movieGradelabel.width/2;
    _movieGradelabel.layer.masksToBounds = YES;
    _movieGradelabel.backgroundColor = UIColorFromHex(COLOR_8CC63F);
    _movieGradelabel.textColor = UIColorFromHex(COLOR_FFFFFF);
    
    _movieTypelabel.layer.masksToBounds = YES;
    _movieTypelabel.layer.cornerRadius = 3.f;
    _movieTypelabel.backgroundColor = UIColorFromHex(COLOR_0099FF);
    _movieTypelabel.textColor = UIColorFromHex(COLOR_FFFFFF);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - /*** 设置数据 ***/
- (void)setListModel:(CCFilmPlayingListModel *)listModel
{
    _listModel = listModel;
    _movieNamelabel.text = @"致青春致青春致青春致青春致青春致青春致青春";
    _movieTypelabel.text = @"3D";
    _movieDescrilabel.text = @"爱情故事爱情故事爱情故事爱情故事故事爱情故事故事爱情故事";
    _movieTimelabel.text = @"120分钟|爱情";
    _moviePlayTimelabel.text = @"2016-12-12 上映";
    _movieGradelabel.text = @"8.7";
    
    _movieBuyBtn.layer.borderColor = UIColorFromHex(COLOR_8CC63F).CGColor;
    [_movieBuyBtn setTitleColor:UIColorFromHex(COLOR_8CC63F) forState:UIControlStateNormal];
    
    // --- 假如要显示 购买/预售按钮
    _movieDesTrailContraints.constant = 62;
    _movieTimeConstraint.constant = 62;
}

#pragma mark - /*** 点击购买/预售按钮 ***/
- (IBAction)movieBuyBtnClicked:(id)sender
{
    if (self.filmBuyBtnClciked) {
        self.filmBuyBtnClciked(self);
    }
}

@end
