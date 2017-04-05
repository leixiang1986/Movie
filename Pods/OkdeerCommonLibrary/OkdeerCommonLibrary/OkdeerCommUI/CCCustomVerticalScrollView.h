//
//  CCCustomVerticalScrollView.h
//  CloudCity
//
//  Created by 雷祥 on 15/2/28.
//  Copyright (c) 2015年 聚光. All rights reserved.
//


#import "CCCycleScrollView.h"
/**
 *  带左右view的纵向滚动的View
 */
@interface CCCustomVerticalScrollView : UIView
@property (nonatomic,strong) CCCycleScrollView *scrollView;   //中间滚动的View
@property (nonatomic,strong) UIView *leftView;  //左边的View   由外部传入
@property (nonatomic,strong) UIView *rightView; //右边的View  由外部传入
@property (nonatomic,assign) CGFloat animationTime; //滚动的间隔时间,默认为3s
@property (nonatomic,strong) NSArray *viewArr;      //传入view的数组
@property (nonatomic,copy) void(^tapIndex)(NSInteger index);  //点击了第几个view，从0开始
@end
