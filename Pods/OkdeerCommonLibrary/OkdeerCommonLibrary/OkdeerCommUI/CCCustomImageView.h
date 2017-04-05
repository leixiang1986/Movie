//
//  LxImageView.h
//  CloudMall
//
//  Created by 雷祥 on 14-11-5.
//  Copyright (c) 2014年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCustomImageView : UIImageView
 

@property (nonatomic, assign) BOOL isChangeColor; // 是否根据颜色改变图片的颜色
@property (nonatomic, strong) UIColor *changeColor ; // 改变颜色
@property (nonatomic, assign) CGFloat imageAlpha ;  // 图片的透明度
@property (nonatomic, assign) CGBlendMode blendMode ;// 颜色的样式
@property (nonatomic, assign) BOOL hideMongoliaLayer;   /**< 是否隐藏蒙层, YES - 隐藏蒙层, NO - 显示蒙层*/

@end
