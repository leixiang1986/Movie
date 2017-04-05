//
//  UIButton+TitleAndImageDispaly.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,UIButtonDispalyType) {
    UIButtonDispalyTypeHorizontalTitleLeft_ImageRight,
    UIButtonDispalyTypeHorizontalImageLeft_TitleRight,
    UIButtonDispalyTypeVerticalTitleUp_ImageBottom,
    UIButtonDispalyTypeVerticalTitleBottom_ImageUp
};

@interface UIButton (TitleAndImageDispaly)
@property (nonatomic, assign) CGFloat space;                    //间距
@property (nonatomic, assign) UIButtonDispalyType displayType;  //布局类型
@end
