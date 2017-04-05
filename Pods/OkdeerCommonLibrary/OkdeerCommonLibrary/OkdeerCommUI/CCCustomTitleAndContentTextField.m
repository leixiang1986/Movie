//
//  CustomTitleAndContentView.m
//  CloudCity
//
//  Created by 雷祥 on 15/2/4.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import "CCCustomTitleAndContentTextField.h"
#import "UIHeader.h"

@implementation CCCustomTitleAndContentTextField

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[CCCustomLabel alloc] initWithFrame:CGRectZero];
        self.contentTextField = [[CCCustomTextField alloc] initWithFrame:CGRectZero];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentTextField];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withFont:(UIFont *)font withTextColor:(UIColor *)textColor withTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder{
    self = [self initWithFrame:frame];
    if (self) {
        self.titleLabel.font = font;
        self.titleLabel.verticalAlignment = VerticalAlignmentMiddle;
        self.contentTextField.font = font;
        self.titleLabel.textColor = textColor;
        self.contentTextField.textColor = textColor;
        self.titleLabel.text = title;
        if (placeHolder && placeHolder.length > 0) {
            self.contentTextField.placeholder = placeHolder;
        }
        
    }
    return self;
}

-(void)layoutSubviews{
    CGSize titleSize = [self.titleLabel.text calculateheight:self.titleLabel.font andcontSize:CGSizeMake(180 , self.frame.size.height) ];
    self.titleLabel.frame = CGRectMake(20, 0, titleSize.width, self.frame.size.height);
    self.contentTextField.frame = CGRectMake(self.titleLabel.right + 5, 0, self.frame.size.width - self.titleLabel.right - 25, self.frame.size.height);
}


@end
