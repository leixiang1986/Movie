//
//  CCUserInforDatePickerView.m
//  CloudCity
//
//  Created by 雷祥 on 16/2/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCUserInforDatePickerView.h"

@interface CCUserInforDatePickerView ()
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end

@implementation CCUserInforDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat viewH = 40;
        CGFloat pickerHeight = 216;
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - (pickerHeight + viewH), kFullScreenWidth, viewH)];
        view.layer.borderColor = UIColorFromHex(COLOR_E2E2E2).CGColor;
        view.layer.borderWidth = 0.5 ;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];

        CGFloat buttonW = 100;
        UIButton *ensureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ensureButton.frame = CGRectMake(kFullScreenWidth - buttonW, 0, buttonW, view.height) ;
        [ensureButton setTitleColor:UIColorFromHex(COLOR_333333) forState:UIControlStateNormal];
        [ensureButton setTitle:[CCUtility CCLocalizedString:@"Utility_done"] forState:UIControlStateNormal];
        [ensureButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:ensureButton];
        [self addSubview:view];
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.frame.size.height - pickerHeight, kFullScreenWidth, pickerHeight)];

        datePicker.backgroundColor = [UIColor whiteColor];
        [self addSubview:datePicker];

        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minuteInterval = 5;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[CCUtility CCLocalizedString:@"Utility_locale"]];//设置为中文显示
        datePicker.locale = locale;

        _formatterStr = @"yyyy-MM-dd";
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:_formatterStr];
//        NSCalendar *caledar = [NSCalendar currentCalendar];
//        datePicker.calendar = caledar;
        NSDate* minDate = [_formatter dateFromString:@"1920-01-01"];
        NSDate* maxDate = [NSDate date];

        datePicker.minimumDate = minDate;
        datePicker.maximumDate = maxDate;
        [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:(UIControlEventValueChanged)];
        _datePicker = datePicker;

        UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDatePick)];
        [self addGestureRecognizer:dateTap];
        self.hidden = YES;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withDateStr:(NSString *)dateStr {
    self = [self initWithFrame:frame];
    if (self) {
        if (dateStr.length) {
            _datePicker.date = [_formatter dateFromString:dateStr];
        }
        else {
            _datePicker.date = [NSDate date];
        }
    }
    return self;
}

/**
 *  外部传入日期格式化字符串
 *
 *  @param formatterStr
 */
- (void)setFormatterStr:(NSString *)formatterStr {
    if (formatterStr.length && ![formatterStr isEqualToString:_formatterStr]) {
        _formatterStr = formatterStr;
        [_formatter setDateFormat:_formatterStr];
    }
}

/**
 *  点击确定，回调出日期字符串
 */
- (void)btnClick {
    if (self.finishClickBlock) {
        self.finishClickBlock(self,_dateStr);
    }
    [self hideDatePick];
}


/**
 *  日期改变后会走的方法
 */
-(void)dateChange:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:_formatterStr];
    _dateStr = [formatter stringFromDate:date];
}

/**
 *  隐藏
 */
- (void)hideDatePick {
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, self.superview.height, self.superview.width, self.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
        }
    }];
}


/**
 *  显示
 *
 *  @param superView 父控件
 */
- (void)showInSuperView:(UIView *)superView {
    [self showInSuperView:superView withDateStr:nil];
}

-(void)showInSuperView:(UIView *)superView withDateStr:(NSString *)dateStr {
    if (superView) {
        if (superView != self.superview) {
            [superView addSubview:self];
        }
        self.hidden = NO;
        self.frame = CGRectMake(0, superView.height, superView.width, self.height);
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(0, superView.height - self.height, superView.width, self.height);
        }];
        if (dateStr.length) {
            _datePicker.date = [_formatter dateFromString:dateStr];
        }
        else {
            _datePicker.date = [NSDate date];
        }
    }
}



@end
