//
//  CCUserInforDatePickerView.h
//  CloudCity
//
//  Created by 雷祥 on 16/2/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCUserInforDatePickerView : UIView
@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, copy) NSString *formatterStr;         /**< 格式化字符串@"yyyy-MM-dd" */
@property (nonatomic, copy) void (^finishClickBlock)(CCUserInforDatePickerView *pickerView, NSString *dateStr);


-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame withDateStr:(NSString *)dateStr;

- (void)showInSuperView:(UIView *)superView;
- (void)showInSuperView:(UIView *)superView withDateStr:(NSString *)dateStr;


@end
