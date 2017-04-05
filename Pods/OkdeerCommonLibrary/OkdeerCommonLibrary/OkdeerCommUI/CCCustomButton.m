//
//  LxButton.m
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import "CCCustomButton.h"

@interface CCCustomButton ()
@property (nonatomic, strong) UIColor *norColor;
@property (nonatomic, strong) UIColor *selColor;
@property (nonatomic, strong) UIColor *disColor;
@end
@implementation CCCustomButton

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            self.norColor = color;
            if (self.norColor) {
                self.layer.borderColor = self.norColor.CGColor;
            }
            
            break;

        case UIControlStateSelected:
            self.selColor = color;
            break;
        case UIControlStateDisabled:
            self.disColor = color;
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self setButtonBorderColor];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self setButtonBorderColor];
}

- (void)setButtonBorderColor
{
    if (self.selected ) {
        
        if (self.selColor) {
            self.layer.borderColor = self.selColor.CGColor;
        }
    }
    else if (!self.enabled) {
        
        if (self.disColor) {
            self.layer.borderColor = self.disColor.CGColor;
        }
    }
    else {
        
        if (self.norColor) {
            
            self.layer.borderColor = self.norColor.CGColor;
        }
    }
}
- (void)setButtonClickBlock:(void (^)(CCCustomButton *))buttonClickBlock{
    _buttonClickBlock = nil ;
    _buttonClickBlock = buttonClickBlock ;
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  按钮点击
 */
- (void)buttonClick{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(self) ;
    }
}

@end
