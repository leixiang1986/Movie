//
//  CCCustomSegmentedControl.m
//  CloudCity
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomSegmentedControl.h"
#import "UIHeader.h"
@implementation CCCustomSegmentedControl

- (instancetype)initWithItems:(NSArray *)items{
    self = [super initWithItems:items];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}
/**
 *  设置默认值
 */
- (void)setDefaultValue{
    /*
     这个是设置按下按钮时的颜色
     */
    self.tintColor = UIColorFromHex(0x8CC63F);
    self.selectedSegmentIndex = 0;//默认选中的按钮索引
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName,UIColorFromHex(0x8CC63F), NSForegroundColorAttributeName, nil, nil];
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:UIColorFromHex(0x8CC63F) forKey:NSForegroundColorAttributeName];
    
    [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
}
@end
