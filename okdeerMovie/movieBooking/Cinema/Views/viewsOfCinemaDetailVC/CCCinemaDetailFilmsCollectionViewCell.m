//
//  CCCinemaDetailFilmsCollectionViewCell.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsCollectionViewCell.h"


@interface CCCinemaDetailFilmsCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;



@end

@implementation CCCinemaDetailFilmsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    #warning 写死
    _imageView.image = [UIImage imageNamed:@"moviebooking_film_default"];
    _scoreBtn.hidden = YES;

}


- (void)setImage:(NSString *)image {
    _image = image;
#warning 设置默认图片
    [_imageView setImageWithString:_image withDefaultImage:[UIImage imageNamed:@"moviebooking_film_default"]];


}

- (void)setScore:(NSString *)score {
    _score = score;
    if (score.length) {
        [self.scoreBtn setTitle:_score forState:(UIControlStateNormal)];
        self.scoreBtn.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.scoreBtn.alpha = 0.8;
        }];
    }
    else {

        [UIView animateWithDuration:0.2 animations:^{
            self.scoreBtn.alpha = 0;
        } completion:^(BOOL finished) {
            self.scoreBtn.hidden = YES;
        }];
    }
}


@end
