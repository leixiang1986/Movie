//
//  CCMyUserInforModel.h
//  OkdeerUser
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CCMyUserInforModelType) {
    CCMyUserInforModelTypeHeaderImage = 0,          //头像
    CCMyUserInforModelTypePhoneNum,                 //手机号码
    CCMyUserInforModelTypeNickName,                 //昵称
    CCMyUserInforModelTypeGender,                   //性别
    CCMyUserInforModelTypeBirthday,                 //生日
    CCMyUserInforModelTypeProfession,               //职业
    CCMyUserInforModelTypeHoby,                     //爱好
    CCMyUserInforModelTypeAffectionState,           //感情状态
    CCMyUserInforModelTypePersonalizedSignature     //个性签名
};

@class CCNameAndIdModel;

/**
 *  登录后获取的用户信息-内部
 */
@interface CCMyUserInforModel : NSObject

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
@property (nonatomic, copy) NSString *invitationCode;               /**< 邀请码 */


@property (nonatomic, copy) NSDictionary *parameters;           /**< 提交时的参数,属性setter方法中设置 */
@property (nonatomic,strong) NSArray <CCNameAndIdModel *>*genderArr;            /**< 性别选项数组 */
@property (nonatomic,strong) NSArray <CCNameAndIdModel *>*affectionStateArr;    /**< 感情状态选项数组 */
@property (nonatomic,strong) CCNameAndIdModel *selectedGenderModel;             /**< 选中的性别model */
@property (nonatomic,strong) CCNameAndIdModel *selectedAffectionStateModel;     /**< 选中的感情状态model */

/**
 *  单例获取
 */
+(instancetype)instance;

/**
 *  解析数据
 *
 *  @param dic 字典
 *
 *  @return 返回获取到单例，不是每次新的实例对象
 */
+ (instancetype)modelObjectWithDictionaryForUserInfor:(NSDictionary *)dic ;

/**
 *  保存用户信息到本地沙盒
 *
 *  @return 是否成功保存
 */
+ (BOOL)saveMyUserInfo;

/**
 *  退出登录清楚用户数据-用户信息
 */
- (void)cleanMyUserInfo;

/**
 *  得到第index个的title
 *
 *  @param index 第几个参数
 *
 *  @return 返回标题
 */
+ (NSString *)getTitleWithType:(CCMyUserInforModelType)type;

/**
 *  根据类型的到提交数据的key
 *
 *  @param type 类型
 *
 *  @return 返回key
 */
+ (NSString *)getKeyWithType:(CCMyUserInforModelType)type;

/**
 *  得到第index个的内容
 *
 *  @param index 第几个参数
 *
 *  @return 返回内容
 */
- (NSString *)getContentWithType:(CCMyUserInforModelType)type;

/**
 *  设置内容，根据类型
 *
 *  @param type 类型
 *
 *  @return
 */
- (void)setContentWithType:(CCMyUserInforModelType)type withContent:(NSString *)content;

@end
