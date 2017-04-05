//
//  CCCinemaFilterTableView.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCinemaFilterTableView : UIView
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) void (^selectIndexBlock)(CCCinemaFilterTableView *filtergTableView,NSInteger index);

//显示到父视图，edgeInsets为相对父视图的约束缩进
- (void)showOnView:(UIView *)superView withDataSource:(NSArray *)dataSource withConstraintEdgeInsets:(UIEdgeInsets)edgeInsets;

//从父视图上隐藏
- (void)hideFromSuperView;
@end
