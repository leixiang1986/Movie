//
//  FastGiveActiviceView.h   文字左右轮播的
//  CloudCity
//
//  Created by JuGuang on 15/3/5.
//  Copyright (c) 2015年 聚光. All rights reserved.
//
// 跑马灯

#import "CCCustomLabel.h"


@interface CCAroundCarouselView : UIView

@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) CCCustomLabel * activitLabel_ ;      //活动的
@property (nonatomic, assign, readonly) BOOL isRunning;           //是都在滚动

@property (nonatomic, strong) UIColor *nameColor ;  // 文字的颜色
@property (nonatomic,assign) CGFloat leftSpace;       /**< 左边的间距  默认为 5 */
@property (nonatomic,assign) CGFloat rightSpace;        /**< 右边的间距 默认为 5*/
/**
 *  开始计时
 */
- (void)startTimer;
/**
 *  停止计时
 */
- (void)stopTimer;



@end
