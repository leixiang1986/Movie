//
//  CCCustomPointAddView.h
//  CloudCity
//
//  Created by Mac on 16/8/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCustomPointAddView : UIView


/**
 *  显示积分增加动效
 *
 *  @param point 积分
 */
- (void)showCustomPointAddView:(NSString *)point;
/**
 *  隐藏积分增加动效
 */
- (void)hideCustomPointAddView;


/**
 *  设置积分值
 */
@property (copy, nonatomic) NSString *pointVal;     /**< 积分值 */

@end
