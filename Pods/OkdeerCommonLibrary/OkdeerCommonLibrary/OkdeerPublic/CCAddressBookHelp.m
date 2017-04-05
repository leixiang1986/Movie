//
//  CCAddressBookHelp.m
//  TestViewDemo
//
//  Created by huangshupeng on 16/7/28.
//  Copyright © 2016年 huangshupeng. All rights reserved.
//

#import "CCAddressBookHelp.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@import Contacts;

NSString *const kAddressBookDataChangeNotificationName = @"AddressBookDataChangeNotification";         /**< 通讯录数据发生变化的通知*/
static CCAddressBookHelp *addressBookHelp = nil;

@interface CCAddressBookHelp ()

@property (nonatomic,strong) NSMutableArray *addressBookTemp;;         /**< 通讯录好友数组 */

@end

@implementation CCAddressBookHelp

- (instancetype)init
{
    self = [super init];
    if (self) {
        _addressBookTemp = [NSMutableArray array];
        [self obtainAddressBook];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 监听 通讯录变化的通知
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
                // IOS9.0以上 使用通知的方法
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressBookDidChange:) name:CNContactStoreDidChangeNotification object:nil];
            }else{
                // IOS9.0以下 使用AddressBook回调的方法
                ABAddressBookRef addresBook = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRegisterExternalChangeCallback(addresBook, addressBookChanged,nil);
            }
        });
        
    }
    return self;
}
//监听通讯录变化
void addressBookChanged(ABAddressBookRef addressBook, CFDictionaryRef info, void *context)
{
    [addressBookHelp updateAddressBook];
    [addressBookHelp sendAddressBookDataChangeNotification];
}

/**
 * 通讯录发生变化的通知
 */
- (void)addressBookDidChange:(NSNotification*)notification{
    [self updateAddressBook];
    [self sendAddressBookDataChangeNotification];
}

+ (instancetype)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addressBookHelp = [[CCAddressBookHelp alloc] init];
    });
    return addressBookHelp;
}
/**
 *  获取通讯录数据
 */
- (void)obtainAddressBook{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        [self addContacts];
    }else{
        [self addAddressBook];
    }
}
/**
 *  iOS9.0 获取通讯录的方法
 */
- (void)addContacts{
    [_addressBookTemp removeAllObjects];
    CNAuthorizationStatus authorization = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] ;
    // 创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    if (authorization == CNAuthorizationStatusNotDetermined) {
        //首次访问通讯录会调用
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) { if (error) return; if (granted) {//允许
            NSLog(@"授权访问通讯录");
            
        }else{//拒绝
            NSLog(@"拒绝访问通讯录");//访问通讯录
        } }]; }
    else if(authorization == CNAuthorizationStatusAuthorized){
        NSLog(@"授权访问通讯录");
        
    } else{ //无权限访问
        NSLog(@"拒绝访问通讯录");
    }
    
    // 定义所有打算获取的属性对应的key值，此处获取姓名，手机号，头像
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey,CNContactEmailAddressesKey];
    // 创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    // 5.遍历所有的联系人并把遍历到的联系人添加到contactarray
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        //新建一个addressBook model类
        CCAddressBookModel *addressBook = [[CCAddressBookModel alloc] init];
        addressBook.name = [NSString stringWithFormat:@"%@%@",contact.familyName.length ? contact.familyName : @"",contact.givenName.length ? contact.givenName : @""];
        addressBook.identifier = contact.identifier;
        addressBook.email = (contact.emailAddresses.lastObject.value) ;
        
        if (contact.phoneNumbers.count > 1) {
            NSMutableArray *telArray = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < contact.phoneNumbers.count; i ++ ) {
                NSString *phoneNum = (contact.phoneNumbers[i].value).stringValue;
                phoneNum = [self dealPhoneNumber:phoneNum];
                if (phoneNum && [phoneNum isKindOfClass:[NSString class]]  && phoneNum.length) {
                    [telArray addObject:phoneNum];
                }
            }
            addressBook.telArray = telArray;
        }else{
            NSString *phoneNum = (contact.phoneNumbers.lastObject.value).stringValue;
            addressBook.tel = [self dealPhoneNumber:phoneNum];
        }
        [_addressBookTemp addObject:addressBook];
    }
     ];
    
}
/**
 *  处理电话号码 只保留数字
 */
- (NSString *)dealPhoneNumber:(NSString *)phoneNum{
    if ([phoneNum isEqualToString:@"(null)"] || !phoneNum || ![phoneNum isKindOfClass:[NSString class]]) {
        phoneNum=@"";
    }else{
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-"withString:@""];
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    phoneNum = [self retentionIntString:phoneNum];
    return phoneNum;
}
/**
 *  保留数字  剔除所有非数字的字符串
 */
- (NSString *)retentionIntString:(NSString *)oldString{
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                   invertedSet];
    NSString *newString = [[oldString componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    return newString;
}
/**
 *  获取iOS9.0 以下通讯录的方法
 */
- (void)addAddressBook{
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        CCAddressBookModel *addressBook = [[CCAddressBookModel alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            if (valuesCount >  1) {
                NSMutableArray *telArray = [[NSMutableArray alloc] init];
                for (NSInteger k = 0; k < valuesCount; k++) {
                    CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                    switch (j) {
                        case 0: {// Phone number
                            NSString *phoneNum = (__bridge NSString*)value;
                            phoneNum = [self dealPhoneNumber:phoneNum];
                            if (phoneNum && [phoneNum isKindOfClass:[NSString class]]  && phoneNum.length) {
                                [telArray addObject:phoneNum];
                            }
                            break;
                        }
                        case 1: {// Email
                            addressBook.email = (__bridge NSString*)value;
                            break;
                        }
                    }
                    CFRelease(value);
                }
                switch (j) {
                    case 0:
                        addressBook.telArray = telArray;
                        break;
                        
                    default:
                        break;
                }
                
            }else{
                NSString *phoneNum = (__bridge NSString*)ABMultiValueCopyValueAtIndex(valuesRef, 0);
                addressBook.tel = [self dealPhoneNumber:phoneNum];
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [_addressBookTemp addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}

/**
 *  通过手机号码查找联系人
 */
- (CCAddressBookModel *)selectPersonForPhone:(NSString *)phone{
    CCAddressBookModel *addressBookModel = nil;
    if ([phone isKindOfClass:[NSString class]] && phone.length > 0 ) {
        for (CCAddressBookModel *model in _addressBookTemp) {
            if ( [model isKindOfClass:[CCAddressBookModel class]] && model.tel.length > 0 && [model.tel rangeOfString:phone].location != NSNotFound) {
                if (model.telArray.count > 0) {
                    BOOL exist = NO;
                    for (NSString *phoneNum in model.telArray) {
                        if ([phoneNum isKindOfClass:[NSString class]] && phoneNum.length > 0 && [phoneNum rangeOfString:phone].location != NSNotFound) {
                            addressBookModel = model;
                            exist = YES;
                            break;
                        }
                    }
                    if (exist) {
                        break;
                    }
                }else if (model.tel.length > 0 && [model.tel rangeOfString:phone].location != NSNotFound){
                    addressBookModel = model;
                    break;
                }
                
                
            }
        }
    }
    return addressBookModel;
}
/**
 *  更新通讯录数据
 */
- (void)updateAddressBook{
    [self obtainAddressBook];
}
/**
 * 获取通讯录数据  数组元素为CCAddressBookModel
 */
- (NSArray *)selectFromAddressBookData{
    return _addressBookTemp;
}

#pragma mark - //****************** 通知 ******************//
/**
 * 发送通讯录数据变化的通知
 */
- (void)sendAddressBookDataChangeNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddressBookDataChangeNotificationName object:nil];
}

@end

@interface CCAddressBookModel ()

@end

@implementation CCAddressBookModel



@end
