//
//  CCCommonMyUserInfoModel.h
//  OkdeerUser
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  登录后获取的用户信息
 */
@interface CCCommonMyUserInfoModel : NSObject

@property (nonatomic,copy) NSString *phone;              /**< 手机号码 */
@property (nonatomic, copy) NSString *loginName;                     /**< 登录名,必填 */
@property (nonatomic,copy) NSString *nickName;              /**< 昵称 */
@property (nonatomic, copy) NSString *realName;              /**< 真实姓名 */
@property (nonatomic, copy) NSString *userId;                     /**< 主键ID,必填 */
@property (nonatomic, copy) NSString *phoneMac;                     /**< 手机MAC */
@property (nonatomic,copy) NSString *picUrl;               /**< 头像链接 */
@property (nonatomic,copy) NSString *serviceUrl;            /**< 头像服务器url */
@property (nonatomic,strong) UIImage *headerImage;          /**< 头像图片 */
@property (nonatomic,copy) NSString *gender;                /**< 性别(代号),1男，2女 */
@property (nonatomic,copy) NSString *birthday;              /**< 生日 */
@property (nonatomic,copy) NSString *profession;            /**< 职业 */
@property (nonatomic,copy) NSString *interest;                 /**< 爱好 */
@property (nonatomic, copy) NSString *email;                     /**< 邮箱 */
@property (nonatomic,copy) NSString *maritalStatus;        /**< 情感状态(代号),0保密，1单身，2热恋中，3已婚 */
@property (nonatomic,copy) NSString *sign;                           /**< 个性签名 */
@property (nonatomic, copy) NSString *status;                     /**< */
@property (nonatomic, copy) NSString *descriptionStr;                     /**< 备注说明 */
@property (nonatomic, copy) NSString *createTime;                     /**< 创建时间,必填 */
@property (nonatomic, copy) NSString *updateTime;                     /**< 最后更新时间,必填 */
@property (nonatomic, copy) NSString *sysNotice;                     /**< 系统通知 */
@property (nonatomic, copy) NSString *propNotice;                     /**< 物业通知 */
@property (nonatomic, copy) NSString *isLoginPassword;          /**< 是否已设置密码0=无,必填 */

/**
 *   获取用户信息
 */
+ (instancetype)userInfo;

@end
