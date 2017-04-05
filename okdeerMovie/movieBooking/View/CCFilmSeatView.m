//
//  CCFilmSeatView.m
//  okdeerMovie
//
//  Created by Mac on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmSeatView.h"

@interface CCFilmSeatView ()

@property (nonatomic, strong) UILabel *seatlabel;   /**< 座位 */
@property (nonatomic, strong) UILabel *pricelabel;  /**< 价格 */

@end

@implementation CCFilmSeatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3.f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = UIColorFromHex(COLOR_8CC63F);
        
        [self addSubview:self.seatlabel];
        [self addSubview:self.pricelabel];
    }
    return self;
}

#pragma mark - /*** 懒加载数据 ***/
// --- 座位
- (UILabel *)seatlabel
{
    if (!_seatlabel) {
        _seatlabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 4, self.frame.size.width - 6, 13)];
        _seatlabel.textAlignment = NSTextAlignmentCenter;
        _seatlabel.font = FONTDEFAULT(12);
        _seatlabel.textColor = UIColorFromHex(COLOR_FFFFFF);
        _seatlabel.text = @"6排5座";
    }
    return _seatlabel;
}

// --- 价格
- (UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 20, self.frame.size.width - 6, 13)];
        _pricelabel.textAlignment = NSTextAlignmentCenter;
        _pricelabel.font = FONTDEFAULT(12);
        _pricelabel.textColor = UIColorFromHex(COLOR_FFFFFF);
        _pricelabel.text = @"300";
    }
    return _pricelabel;
}

@end
