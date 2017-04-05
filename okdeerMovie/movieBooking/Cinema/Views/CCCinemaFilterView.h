//
//  CCCinemaFilterView.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,CCCinemaFilterViewSelectType) {
    CCCinemaFilterViewSelectTypeNone    = -1,   //unSelectedIndex在第一次选中的回调中是没有的
    CCCinemaFilterViewSelectTypeLeft    = 0,
    CCCinemaFilterViewSelectTypeRight   = 1,
};

@interface CCCinemaFilterView : UIView
@property (assign, nonatomic,readonly) CCCinemaFilterViewSelectType selectedIndex;
@property (assign, nonatomic,readonly) CCCinemaFilterViewSelectType oldSelectedIndex;
@property (nonatomic, copy) NSString *leftBtnTitle;
@property (nonatomic, copy) NSString *rightBtnTitle;
@property (nonatomic, copy) void(^selectBlock)(CCCinemaFilterView *view,CCCinemaFilterViewSelectType selectIndex,CCCinemaFilterViewSelectType oldSelectedIndex);    /**< 点击selectIndex ，是选中还是取消选中selected */
//设置选中或非选中
- (void)setSelect:(BOOL)select atIndex:(CCCinemaFilterViewSelectType)selectIndex;
@end
