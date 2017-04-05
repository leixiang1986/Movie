//
//  UIImageView+CCImageView.h
//  CloudCity
//
//  Created by JuGuang on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CCImageView)

/**
 *  传入string，不论是http还是本地图片名字，得到显示图片
 *
 *  @param string 本地或网络图片链接
 */
-(void)setImageWithString:(NSString *)string withDefaultImage:(UIImage *)defaultImage;

 

@end
