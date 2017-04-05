//
//  UIButton+Extension.m
//  CloudCity
//
//  Created by Mac on 15/6/30.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "UIButton+Extension.h"
#import "NSString+CCExtame.h"
#import "OkdeerCategory.h"
@implementation UIButton(Extension)


//对btn上面图片进行全局化，不被拉伸压缩
- (void)imgModeScaleAspectFill{
    self.imageView.contentMode =  UIViewContentModeCenter;
    self.imageView.clipsToBounds  = YES;
    self.imageView.contentMode =  UIViewContentModeScaleAspectFill;
}

//btn设置默认和高亮状态下的图片
- (void)setStateNormalImage:(UIImage *)nImg highlightedImage:(UIImage *)hImg{

    [self setImage:nImg forState:UIControlStateNormal];
    [self setImage:hImg forState:UIControlStateHighlighted];

}
/**
 *  初始化一个按钮 没有边框的 背景颜色是蓝色的  椭圆
 */
+ (UIButton *)buttonTitle:(NSString *)title target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
//    button.titleLabel.font = FONTDEFAULT(14);
    CGFloat width = [title calculateheight:button.titleLabel.font ].width + 8;
    button.frame = CGRectMake(0, 0, width + 16, 30);
    if (title.length == 0 ) {
        button.backgroundColor = [UIColor clearColor];
    }else{
//       button.backgroundColor = UIColorFromHex(COLOR_8CC63F);
    }
    button.layer.cornerRadius = button.height / 2 ;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 *  创建一个button 按钮size为 25*25 实际图片大小为17.5*17.5 UI要求
 *
 */
+ (UIButton *)buttonMustItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, CGSizeMake(30, 30)};// 图片
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0,0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button; 
}

/**
 *  创建一个BarButtonItem按照指定的大小
 *
 *  @param image     正常下的图片
 *  @param highImage 高亮下的图片
 *  @param target
 *  @param action    回调
 *
 */
+ (instancetype)buttonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage size:(CGSize)size target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, size};// 图片
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
