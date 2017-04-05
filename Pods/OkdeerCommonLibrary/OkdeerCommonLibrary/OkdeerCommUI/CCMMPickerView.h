//
//  CCMMPickerView.h
//  CloudProperty
//
//  Created by Mac on 15/6/12.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCMMPickerView : UIView

//关闭View
+ (void)dismissWithCompletion: (void(^)(NSString *))completion;

//显示数据,只显示一维数据
+ (void)showPickerViewInView: (UIView *)view
                withSource: (NSArray *)sourceArray
                 completion: (void(^)(NSString *selectedString, NSInteger row))completion;

//更变数据源
+ (void)changeWithSourceArray: (NSArray *)sourceArray;

@end
