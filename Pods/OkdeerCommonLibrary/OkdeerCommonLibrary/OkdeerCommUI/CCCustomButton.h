//
//  LxButton.h
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCustomButton : UIButton
@property (nonatomic,copy)void (^buttonClickBlock) (CCCustomButton *button) ; // 初始化button的点击事件

/**
 *  设置边框颜色
 *
 *  @param state 只有选中\正常\不可用状态
 */
- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state;

@end
