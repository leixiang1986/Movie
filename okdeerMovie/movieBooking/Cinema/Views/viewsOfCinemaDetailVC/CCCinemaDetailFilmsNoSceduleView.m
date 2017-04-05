//
//  CCCinemaDetailFilmsNoSceduleView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsNoSceduleView.h"

@interface CCCinemaDetailFilmsNoSceduleView ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation CCCinemaDetailFilmsNoSceduleView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.button setSystemCorneradius:3 withColor:UIColorFromHex(COLOR_8CC63F) withBorderWidth:ScreenGridViewHeight * 2];
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.label.text = content;
}

- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    if (btnTitle) {
        [self.button setTitle:btnTitle forState:(UIControlStateNormal)];
    }
}

- (IBAction)btnClick:(id)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(self);
    }
}


@end
