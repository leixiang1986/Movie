//
//  CCCycleScrollView.h
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NSTimer+Addition.h"

@class CCSMPageControl ;
typedef enum {
    Vertical = 0,
    Horizontal = 1,
    
} ScroDirection;

@interface CCCycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
@property (nonatomic ,strong) CCSMPageControl *pageControl;
@property (nonatomic ,assign) BOOL isPage;
@property (nonatomic ,assign) ScroDirection direction;
@property (nonatomic , assign) NSTimeInterval animationDuration;
@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic ,assign) BOOL can_not_Scroll;   //是否不可以滚动
@property (nonatomic , assign, readonly) NSInteger currentPageIndex;

/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction;
//设置方法
- (void)setWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction;


-(id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction withPage:(CCSMPageControl *)pageControl;
//设置方法
- (void)setWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction withPage:(CCSMPageControl *)pageControl;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 *  停止timer
 */
- (void)free;

@end