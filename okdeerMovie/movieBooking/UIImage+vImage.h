//
//  UIImage+vImage.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/20.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (vImage)
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
