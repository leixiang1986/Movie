//
//  CCCustomActionTableViewCell.m
//  CloudCity
//
//  Created by 雷祥 on 16/1/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomActionTableViewCell.h"

@interface CCCustomActionTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,strong) CALayer *lineLayer;
@end

@implementation CCCustomActionTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.lineLayer = [self creatLineLayerToView:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _contentLabel.textColor = UIColorFromHex(COLOR_8CC63F);
    }
    else {
        _contentLabel.textColor = UIColorFromHex(COLOR_666666);
    }

    // Configure the view for the selected state
}

-(void)setHidenLine:(BOOL)hidenLine {
    _hidenLine = hidenLine;
    self.lineLayer.hidden = hidenLine;
}

-(void)setContent:(NSString *)content {
    _content = [content copy];
    _contentLabel.text = content;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(0, self.height - ScreenGridViewHeight, self.frame.size.width, ScreenGridViewHeight);
}



- (CALayer *)creatLineLayerToView:(UIView *)view {
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [UIColorFromHex(COLOR_E2E2E2) CGColor];
    lineLayer.frame = CGRectMake(0, view.height - ScreenGridViewHeight, self.frame.size.width, ScreenGridViewHeight);
    [view.layer addSublayer:lineLayer];
    return lineLayer;
}

@end
