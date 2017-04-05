//
//  UIImageView+CCImageView.m
//  CloudCity
//
//  Created by JuGuang on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "UIImageView+CCImageView.h"
#import "UIImageView+WebCache.h"
#import "NSString+CCExtame.h"
@implementation UIImageView (CCImageView)

/**
 *  传入string，不论是http还是本地图片名字，得到显示图片
 *
 *  @param string 本地或网络图片链接
 */
-(void)setImageWithString:(NSString *)string withDefaultImage:(UIImage *)defaultImage{
    
    
    if ([string isHttpString]) {
        
        [self sd_setImageWithURL:[NSURL URLWithString:[NSString concatenatedCoding:string]] placeholderImage:defaultImage];
    }
    else{
        if (string.length > 0) {
            [self setImage:[UIImage imageNamed:string]];
            if (!self.image) {
                [self setImage:defaultImage];
            }
        }
        else{
            [self setImage:defaultImage];
        }
    }
}




@end
