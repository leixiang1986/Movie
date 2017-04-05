//
//  CCFilmSelectedSeatView.m
//  okdeerMovie
//
//  Created by Mac on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmSelectedSeatView.h"
#import "CCFilmSeatView.h"

@implementation CCFilmSelectedSeatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // --- 提示语句
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 8, 100, 15)];
        label.text = @"已选座位";
        label.textColor = UIColorFromHex(COLOR_333333);
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.font = FONTDEFAULT(12);
        [self addSubview:label];

        // -- 初始化已选座位
        [self initSelectedView];
    }
    return self;
}

- (void)initSelectedView
{
    for (int index = 0; index < 3; index ++) {
        CCFilmSeatView *seatView = [[CCFilmSeatView alloc] initWithFrame:CGRectMake(12+index*(58+10), 30, 58, 35)];
        [self addSubview:seatView];
    }
}

@end
