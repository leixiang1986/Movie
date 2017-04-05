//
//  CCDoneCanceView.h
//  CloudCity
//
//  Created by Mac on 16/7/14.
//  Copyright © 2016年 huangshp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickVoidBlock)(void);                                /**< 按钮点击回调（没有带参数） */
@interface CCDoneCanceView : UIView
/**
 *  点击事件的回调
 */
- (void)doneBlock:(ButtonClickVoidBlock)doneBlock canceBlock:(ButtonClickVoidBlock)canceBlock;

@end
