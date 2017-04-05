//
//  UIImage+CCImage.h
//  CategoryFrameworks
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kImageDataKey @"imageData"
#define kJpgKey @"JPG"

@interface UIImage (CCImage)

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color ;

/**
 *  将图片保存到系统里的相簿里
 *
 *  @param image      图片对象
 *  @param photoName 相册的名字    不填  默认
 */
- (void)saveImage:(UIImage*)image photoName:(NSString *)photoName ;

/**
 *  根据颜色值改变图片的颜色
 *
 *  @param tintColor 颜色值
 *  @param blendMode 、
 *  @param alpha     透明度
 *
 *  @return 图片对象
 */

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode) blendMode alpha :(CGFloat)alpha;

/**
 *  根据颜色值 设置圆角 生成图片
 */
+ (UIImage *)imageColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 *  设置颜色的图片  设置大小
 *
 *  @param color        color
 *  @param size         size
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)resizeImage:(NSString *)imageName viewframe:(CGRect)viewframe resizeframe:(CGRect)sizeframe;

/**
 *  把图片缩小到最大宽度为640
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingToMaxSize;

/**
 *  把图片缩放到指定大小
 *
 *  @param targetSize   targetSize
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingAndCroppingToTargetSize:(CGSize)targetSize;

/**
 *  图片处理  压缩
 */
+ (NSArray *)disposeImagesWithArray:(NSArray *)imageArray;

@end
