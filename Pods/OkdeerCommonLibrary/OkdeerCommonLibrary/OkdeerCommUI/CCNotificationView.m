//
//  CCNotificationView.m
//  CloudMall
//
//  Created by 雷祥 on 15/11/25.
//  Copyright © 2015年 CloudCity. All rights reserved.
//

#import "CCNotificationView.h"
#import "OkdeerCategory.h"
#import "OkdeerCommUIHeader.h"

@interface CCNotificationView ()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,assign) BOOL timingStart;  //是否重新定时，在第一条没有隐藏时，第二条出现，就重新进入下一个定时周期自动隐藏
@end

@implementation CCNotificationView
static CCNotificationView *notificationView;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationView = [[CCNotificationView alloc] initWithFrame:CGRectZero];
    });

    return notificationView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, -64, kUIFullWidth, 64);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 15, 15)];
        [iconImageView setCorneradius:2 withColor:nil withBorderWidth:0];
        iconImageView.image = self.iconImage;
        self.iconImageView = iconImageView;
        [self addSubview:iconImageView];


        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + 8, _iconImageView.top, 100, 15)];
        titleLabel.text = self.titleString;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];


        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right, titleLabel.top, 40, titleLabel.height)];
        timeLabel.text = @"现在";
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];

        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom , kUIFullWidth - titleLabel.left - 12, 35)];
        contentLabel.numberOfLines = 12;
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.font = [UIFont systemFontOfSize:13];
        self.contentLabel = contentLabel;
        [self addSubview:contentLabel];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
 
    }
    return self;
}

-(void)setMessage:(NSString *)message {
    _message = message;
    self.contentLabel.text = message;
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage ;
    self.iconImageView.image = iconImage;
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.titleLabel.text = _titleString;
}

// 点击事件
- (void)tapClick:(UITapGestureRecognizer *)tap {
    [self hide];
    if (self.tapBlock) {
        self.tapBlock();
    }
}

//显示
-(void)show {
    _timingStart = NO;

    //定时隐藏
    [self timingHide];
    [self.superview bringSubviewToFront:self];
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelAlert;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, kUIFullWidth, 64);
    }];
}

//定时隐藏
- (void)timingHide {
    [UIDevice currentDevice] ;
    if (_timingStart) {
        [self hide];
    }
    if (!_timingStart) {
        [self performSelector:@selector(timingHide) withObject:nil afterDelay:4];
    }
    _timingStart = YES;
}

//直接隐藏
- (void)hide {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom = 0;
    } completion:^(BOOL finished) {
 
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal;
    }];
}

@end
