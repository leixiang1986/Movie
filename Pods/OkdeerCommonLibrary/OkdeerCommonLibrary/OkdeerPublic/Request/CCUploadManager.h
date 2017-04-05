//
//  CCUploadManager.h
//  QiNiuDemo
//
//  Created by huangshupeng on 16/3/21.
//  Copyright © 2016年 huangshupeng. All rights reserved.
//
/**
 *  上传图片的类
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,UploadModuleType) {
    UploadModuleTypeAtBrand,       /**< 品牌 */
    UploadModuleTypeAtGoods,       /**< 商品 */
    UploadModuleTypeAtStore,       /**< 店铺 */
    UploadModuleTypeAtProperty,    /**< 物业 */
    UploadModuleTypeAtOperate,     /**< <#parm#>*/
    UploadModuleTypeAtAdvert,      /**< 广告 */
    UploadModuleTypeAtOrder,       /**< 订单 */
    UploadModuleTypeAtMyinfo,       /**< 头像*/
    UploadModuleTypeAtPropertyservice, /**< 物业服务 */
 
};   /**< 上传的模块*/

typedef void(^UploadSuccessBlock)(NSArray *imageKeyArray);   /**< 上传图片成功 */
typedef void(^UploadFailureBlock)(NSString *messagge,NSArray *successKeyArray,NSArray *failurImageArray);  /**< 上传图片失败 */

@interface CCUploadManager : NSObject


+ (instancetype)instance;
/**
 *  上传多张图片  imageArray  对象是 uiimage 
 */
- (void)uploadImages:(NSArray *)imageArray moduleType:(UploadModuleType)moduleType success:(UploadSuccessBlock)successBlock failure:(UploadFailureBlock)failureBlock;
/**
 *  取消请求
 */
- (void)canceRequest;

@end

@interface CCUploadKeyModel : NSObject

@property (nonatomic,copy) NSString *keyName;  /**< 上传图片文件名 */
@property (nonatomic,strong) UIImage *uploadImage;   /**< 上传图片的文件 */
@property (nonatomic,strong) NSData *imageData;      /**< 图片二进制 */
@end
