//
//  CCAddressBookHelp.h
//  TestViewDemo
//
//  Created by huangshupeng on 16/7/28.
//  Copyright © 2016年 huangshupeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCAddressBookModel;

FOUNDATION_EXPORT NSString *const kAddressBookDataChangeNotificationName;         /**< 通讯录数据发生变化的通知*/

@interface CCAddressBookHelp : NSObject

+ (instancetype)instance;
/**
 *  通过手机号码查找联系人
 */
- (CCAddressBookModel *)selectPersonForPhone:(NSString *)phone;
/**
 *  更新通讯录数据
 */
- (void)updateAddressBook;
/**
 * 获取通讯录数据  数组元素为CCAddressBookModel
 */
- (NSArray *)selectFromAddressBookData;

@end

@interface CCAddressBookModel : NSObject

@property NSInteger sectionNumber;
@property NSInteger recordID;
@property (nonatomic, retain) NSString *identifier;    /**< 唯一标识 */
@property (nonatomic, retain) NSString *name;          /**< 姓名 */
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, strong) NSArray *telArray;     /**< 电话号码数组*/

@end
