//
//  CCCustomDateView.m
//  ThumbLife
//
//  Created by JuGuang on 14-8-4.
//  Copyright (c) 2014年 聚光电子科技. All rights reserved.
//

#import "CCCustomDateView.h"
#import <UIKit/UIKit.h>
#import "CCCustomDateAndTime.h"
#import <QuartzCore/QuartzCore.h>
#import "OkdeerCommUIHeader.h"
#import "CCCategorHeader.h"
#import "UIView+CCView.h"
@implementation CCCustomDateView{
    UIDatePicker *datepicker;                //时间控件
    CCCustomDateAndTime *dateAndTime;        // 获取时间样式
    UILabel *timelbl;                     //显示时间
    UITapGestureRecognizer *tap;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //CGRect bound = [[UIScreen mainScreen] bounds];
        dateAndTime = [CCCustomDateAndTime shareDateAndTime];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        CGFloat contentViewHeight = 315;
        // 创建  存放 确定取消按钮区域
        UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - contentViewHeight, kUIFullWidth, contentViewHeight)];
        contentview.backgroundColor = [UIColor whiteColor];
        contentview.layer.borderWidth = 0.5;
        contentview.layer.borderColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
        contentview.layer.masksToBounds = YES;
        [self addSubview:contentview];
        //初始化日期选择器
        datepicker = [[UIDatePicker alloc] init];
        //这句不起作用
        //datepicker.frame = CGRectMake(0, contentview.height - 260 ,kFullScreenWidth, 260);
        datepicker.minimumDate = [NSDate date];//设置最小日期
        datepicker.backgroundColor = [UIColor whiteColor];
        datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置 日期地区  中国
        datepicker.datePickerMode = UIDatePickerModeDateAndTime;//设置日期与时间
        [datepicker addTarget:self action:@selector(datechange:) forControlEvents:UIControlEventValueChanged];
        [contentview addSubview:datepicker];
    
        //重新设置frame
        datepicker.frame = CGRectMake(0, 0, kUIFullWidth, datepicker.frame.size.height);
        contentview.frame = CGRectMake(0, kUIFullHeight - (datepicker.frame.size.height + 59), kUIFullWidth, datepicker.frame.size.height + 59);

        //取消确定的view
        CCPropertyServiceTimePickerSelectView *selectView = [[CCPropertyServiceTimePickerSelectView alloc] initWithFrame:CGRectMake(0, datepicker.bottom, contentview.width, 59)];
        __weak typeof(self) weakSelf = self;
        selectView.clickBlock = ^ (NSInteger index,NSString *title) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf clickIndex:index];
        };
        [contentview addSubview:selectView];

        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentview.width, 1)];
        hLine.backgroundColor = UIColorFromHex(COLOR_E2E2E2);
        [selectView addSubview:hLine];

        //点击事件
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

/**
 设置最小时间   当分钟在0-30之间   最小时间为 当前的时  和分钟为30
 当分钟大于30  最小时间为当前的时加1 分钟为0
 */
- (void)serpcikdate{
    datepicker.minimumDate = [dateAndTime datestringtodate:[dateAndTime datetostring]];
    
}
//设置最多的天数
- (void)setmaximundate:(NSInteger)day{
    datepicker.maximumDate = [NSDate dateWithTimeInterval:30*24*60*60 sinceDate:[NSDate date]];
    datepicker.minimumDate = [NSDate date];
    //datepicker.maximumDate = [dateAndTime setmaxiDay:day];
}

- (void)setblock:(void (^)(NSDate *))com{
    cd = com;
}

//点击取消或完成
- (void)clickIndex:(NSInteger)index{
    if (index == 0) {
        if (cd) {
            cd(nil);
        }
    }
    else if (index == 1) {
        if (cd) {
            cd([datepicker date]);
        }
    }
}



/**
 UIDatePicker 触发旳事件
 
 @param date 选中旳时间
 */
- (void)datechange:(UIDatePicker *)date{
    timelbl.text = [NSString stringWithFormat:@"%@:%@",@"当前预约时间",[dateAndTime datetostring:[date date]]];
}
- (void)tapClick:(UITapGestureRecognizer *)sender{
    if (cd) {
        cd(nil);
    }
}
- (void)dealloc
{
    [self removeGestureRecognizer:tap];
    cd = nil ;
}


@end



NSInteger const kBaseTag = 100;

@interface CCPropertyServiceTimePickerSelectView ()
@property (nonatomic,weak) UIView *vLine;           /**< 竖分割线 */


@end

@implementation CCPropertyServiceTimePickerSelectView

/**
 *  初始化方法
 *
 *  @param frame  frame
 *
 *  @return 返回实例
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * titles = @[@"取消",@"确定"];
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            if (i == 0) {
                [btn setTitleColor:UIColorFromHex(0x666666) forState:(UIControlStateNormal)];
            }
            else {
                [btn setTitleColor:UIColorFromHex(0x8CC63F) forState:(UIControlStateNormal)];
            }
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            btn.tag = kBaseTag + i;
            [self addSubview:btn];
        }
        
        UIView *vLine = [[UIView alloc] init];
        vLine.backgroundColor = UIColorFromHex(COLOR_E2E2E2);
        [self addSubview:vLine];
        _vLine = vLine;
    }
    
    return self;
}

/**
 *  点击事件
 *
 *  @param sender sender
 */
- (void)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag - kBaseTag;
    if (self.clickBlock) {
        self.clickBlock(index,btn.currentTitle);
    }
}

/**
 *  布局子view
 */
-(void)layoutSubviews {
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        if ([subView isMemberOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            NSInteger index = btn.tag - kBaseTag;
            btn.frame = CGRectMake(index *self.width / 2 , 0, self.width / 2, self.height);
        }
        else if (subView == _vLine ) {
            subView.frame =CGRectMake(self.width / 2, 0, 1, self.height);
        }
    }
}

@end
