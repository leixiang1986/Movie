//
//  CCUtility+Image.h
//  OkdeerPublic
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 okdeer. All rights reserved.
//
/**
 *  图片的
 */

#import "CCUtility.h"

#define kImageDataKey @"imageData"
#define kJpgKey @"JPG"

@interface CCUtility (Image)

/**
 *  图片处理  压缩
 */
+ (NSArray *)disposeImagesWithArray:(NSArray *)imageArray;
/**
 *  把图片缩小到最大宽度为640
 *
 *  @return  UIImage
 */
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)image;
/**
 *  把图片缩放到指定大小
 *
 *  @param targetSize  targetSize
 *
 *  @return  UIImage
 */
+ (UIImage *)imageByScalingAndCroppingToTargetSize:(CGSize)targetSize image:(UIImage *)image;
#ifdef __cplusplus
extern "C" {
#endif
/**
 *  读取bundle中的image
 *
 *  @param bundleName  bundle名称
 *  @param imageName  图片名称
 *  @param inDirectory 目录
 *  @return 图片Image
 */
UIImage * imageFromBundleName(NSString *bundleName ,NSString *inDirectory ,NSString *imageName);

/**
 *  读取bundle中的image的路径
 *
 *  @param bundleName  bundle名称
 *  @param imageName  图片名称
 *  @param inDirectory 目录
 *  @return 图片Image路径
 */
 NSString *imagePathBundleName(NSString *bundleName ,NSString *inDirectory ,NSString *imageName);
#ifdef __cplusplus
}
#endif
@end
