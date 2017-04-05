//
//  CCFilmOrderDetailView.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFilmOrderDetailModel.h"
//订单详情控制器对应的view
@interface CCFilmOrderDetailView : UIView
@property (nonatomic, strong) CCFilmOrderDetailModel *model;
@property (nonatomic, copy) void (^phoneClick)(CCFilmOrderDetailView *view,NSString *phoneNum);

/**
 *  隐藏提示信息，隐藏默认显示tipsLabel，如果不需要调用这个方法
 */
- (void)hideTipsLabel;

/**
 *  显示提示信息,默认为显示，如果调用了hiteTipsLabel
 */
- (void)showTipsLabel;

/**
 *   取票码的显示，默认显示，如果掉用了隐藏的信息,没有掉用隐藏方法不用使用本方法
 */
- (void)showObtainBackView;

/**
 *   取票码的隐藏方法,默认是显示，如果需要隐藏，掉用本方法
 */
- (void)hideObtainBackView;
@end
