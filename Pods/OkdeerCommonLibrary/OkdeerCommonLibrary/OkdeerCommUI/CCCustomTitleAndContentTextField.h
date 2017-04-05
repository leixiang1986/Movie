//
//  CustomTitleAndContentView.h
//  CloudCity
//
//  Created by 雷祥 on 15/2/4.
//  Copyright (c) 2015年 聚光. All rights reserved.
//


#import "CCCustomLabel.h"
#import "CCCustomTextField.h"

@interface CCCustomTitleAndContentTextField : UIView
@property (nonatomic,strong) CCCustomLabel *titleLabel;
@property (nonatomic,strong) CCCustomTextField *contentTextField;

-(instancetype)initWithFrame:(CGRect)frame withFont:(UIFont *)font withTextColor:(UIColor *)textColor withTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder;





@end
