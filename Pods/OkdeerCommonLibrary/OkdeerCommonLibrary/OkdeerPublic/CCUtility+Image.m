//
//  CCUtility+Image.m
//  OkdeerPublic
//
//  Created by Mac on 16/9/8.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCUtility+Image.h"
#import "PublicHeader.h"

#define ORIGINAL_MAX_WIDTH 640
#define LEN_100 100 * 1000.0
#define LEN_150 150 * 1000.0
#define LEN_300 300 * 1000.0
#define LEN_500 500 * 1000.0

@implementation CCUtility (Image)

+ (UIImage *)imageByScalingToMaxSize:(UIImage *)image{
    if (image.size.width < ORIGINAL_MAX_WIDTH) return image;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (image.size.width > image.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = image.size.width * (ORIGINAL_MAX_WIDTH / image.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = image.size.height * (ORIGINAL_MAX_WIDTH / image.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingToTargetSize:targetSize image:image];
}

/**
 *  把图片缩放到指定大小
 *
 *  @param targetSize
 *
 *  @return
 */
+ (UIImage *)imageByScalingAndCroppingToTargetSize:(CGSize)targetSize image:(UIImage *)image{
    UIImage *newImage = nil;
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [image drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  图片处理  压缩
 */
+ (NSArray *)disposeImagesWithArray:(NSArray *)imageArray
{
    NSMutableArray *fileDataMArray = [NSMutableArray array];
    
    for (UIImage *image in imageArray) {
        CGFloat quality = [self compressionQuality:image];
        UIImage *newImage = nil;
        NSMutableDictionary *fileDataMDictionary = [NSMutableDictionary dictionary];
        
        if (quality < 0.4) {
            CGSize size = CGSizeMake(800, 800 * (image.size.height/image.size.width));
            newImage = [self scaleToSize:image size:size];
        }
        else {
            newImage = image;
        }
        
        NSData *imageData = [self compressedData:quality image:newImage];
        BOOL isJPG = NO;
        if (imageData) {
            
            isJPG = YES;
        } else {
            isJPG = NO;
            imageData = UIImagePNGRepresentation(image);
            
        }
        if (!imageData) {
            
        }
        [fileDataMDictionary setObject:[NSNumber numberWithBool:isJPG] forKey:kJpgKey];
        if (imageData) {
            [fileDataMDictionary setObject:imageData forKey:kImageDataKey];
        }
        
        
        [fileDataMArray addObject:[fileDataMDictionary copy]];
    }
    return [fileDataMArray copy];
}
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
+ (NSData *)compressedData:(CGFloat)compressionQuality image:(UIImage *)image
{
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);
    return UIImageJPEGRepresentation(image, compressionQuality);
}
+ (CGFloat)compressionQuality:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (!data) {
        data = UIImagePNGRepresentation(image);
    }
    
    NSUInteger dataLength = [data length];
    
    if(dataLength > LEN_100) {
        if (dataLength > LEN_500) {
            return 0.3;
        } else if (dataLength > LEN_300) {
            return  0.45;
        } else if (dataLength > LEN_150){
            return  0.65;
        } else {
            return 0.9;
        }
    } else {
        return 1.0;
    }
}
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
UIImage * imageFromBundleName(NSString *bundleName ,NSString *inDirectory ,NSString *imageName)
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
    //没有找到bundle
    if (!bundle) {
        if (imageName.length) {
            return [UIImage imageNamed:imageName];
        }
        return nil;
    }
    
    UIImage *image = nil;
    
    NSString *imageBundleName = [NSString stringWithFormat:@"%@.bundle%@/%@",bundleName,(inDirectory.length > 0 ? [NSString stringWithFormat:@"/%@",inDirectory] : @""),imageName];
    if (imageBundleName.length){
        image = [UIImage imageNamed:imageBundleName];
    }
     NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:inDirectory];
    if (!image){
        //图片路径是nil
        if (!imagePath.length) {
            if (imageName.length) {
                image = [UIImage imageNamed:imageName];
            }
        }
    }
    if(!image){
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}

/**
 *  读取bundle中的image的路径
 *
 *  @param bundleName  bundle名称
 *  @param imageName  图片名称
 *  @param inDirectory 目录
 *  @return 图片Image路径
 */
extern  NSString *imagePathBundleName(NSString *bundleName ,NSString *inDirectory ,NSString *imageName)
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
    //没有找到bundle
    if (!bundle) {
        if (imageName.length) {
            return imageName;
        }
        return @"";
    }
    
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:inDirectory];
    //图片路径是nil
    if (!imagePath.length) {
        if (imageName.length) {
            return imageName;
        }
        return @"";
    }
    return imagePath;
}
#ifdef __cplusplus
}
#endif
@end
