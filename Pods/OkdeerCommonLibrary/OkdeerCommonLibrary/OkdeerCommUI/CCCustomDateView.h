//
//  CCCustomDateView.h
//  ThumbLife
//
//  Created by JuGuang on 14-8-4.
//  Copyright (c) 2014年 聚光电子科技. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义日期选择界面
 */
@interface CCCustomDateView : UIView{
    void (^cd)(NSDate *date);
}
/**
 点击取消或完成按钮 回调
 
 @param com 返回传时间
 */
- (void)setblock:(void (^)(NSDate *date))com;
/**
 设置最大旳天数
 
 @param day 天数
 */
- (void)setmaximundate:(NSInteger)day;
/**
 设置最小旳时间
 */
- (void)serpcikdate;

@end
@interface CCPropertyServiceTimePickerSelectView : UIView
@property (nonatomic,strong) NSArray *titles;                                   /**< 标题数组 */
@property (nonatomic,copy) void (^clickBlock)(NSInteger index,NSString *title); /**< 点击事件的block */

@end