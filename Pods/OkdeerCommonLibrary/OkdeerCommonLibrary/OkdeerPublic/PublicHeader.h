//
//  PublicHeader.h
//  PublicFrameworks
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#define kStatusBarHeight            ([UIApplication sharedApplication].statusBarFrame.size.height)    // 状态栏高度
#define kFullScreenWidth           ([UIScreen mainScreen].bounds.size.width)                          // 全屏的宽度
#define kFullScreenHeight          ( [UIScreen mainScreen].bounds.size.height)                        // 全屏的高度
#define kExceptStatusBarHeight     (kFullScreenHeight - kStatusBarHeight)                             // 除了状态栏的高度
#define kNavigationBarHeight        44.00f                                                            // 导航栏的高度
#define kTabbarHeight               49.00f                                                            // 状态栏高度
#define kStatusBarAndNavigationBarHeight   (kNavigationBarHeight + kStatusBarHeight)          /**< 导航栏和状态栏的高度*/

/**
 *  判断版本是否大于等于7/8的布尔变量
 */
#define iOS7UP  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS8UP  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS9UP  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define iOS10UP ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/**
 * 判断机器型号
 */
#define isPhone4 (([UIScreen mainScreen ].bounds.size.height == 480.0)?YES:NO)
#define isPhone5 (([UIScreen mainScreen ].bounds.size.height == 568.0)?YES:NO)
#define isPhone6 (([UIScreen mainScreen ].bounds.size.height == 667.0)?YES:NO)
#define isPhone6P (([UIScreen mainScreen ].bounds.size.height == 736.0)?YES:NO)



/**
 *  定义弱引用
 *
 *  @param weakSelf
 *
 *  @return
 */
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define STRONGSELF(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;
// 是否支持手势右滑返回
#define PopGestureRecognizerenabled(ret)   (self.navigationController.interactivePopGestureRecognizer.enabled = ret)




/**
 *  自定义打印，在debug时打印，发布时不打印
 */
#ifdef DEBUG
#define CCLog(fmt, ...) NSLog((@"[函数名:%s] " " [行号:%d] " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define CCLog(fmt, ...)
#endif


#undef IsClassTrue
#define IsClassTrue(objc,name)  ([CCUtility whetherIdIsClass:objc className:name])   // 判断是否属于某个对象
#undef SelectClassValue
#define SelectClassValue(objc,keyName) ([CCUtility selectValueToClass:objc varName:keyName])  // 获取某个类的属性值


#undef VariableClass
#define VariableClass(myClass,name)  ([CCUtility getVariableWithClass:myClass varName:name]) // 判断对象中有没属性
#undef DicGetValue
#define DicGetValue(dic,key)        ([CCUtility dictionaryToGetValue:dic keyName:key])  // 从字典获取对象
#undef DicGetValueIsClass
#define DicGetValueIsClass(dic,key,name) ([CCUtility dictionaryToGetValue:dic keyName:key isClass:name])   // 从字典获取对象 并且对象是否属于某个对象
#undef ArrayGetValue
#define ArrayGetValue(array,index)  ( [CCUtility arrayToGetValue:array indexInt:index])  // 从数组获取对象
#undef ArrayGetValueIsClass
#define ArrayGetValueIsClass(array,index,name) ([CCUtility arrayToGetValue:array indexInt:index isClass:name]) // 从数组获取对象  并且对象是否属于某个对象
#undef StringGetLength
#define StringGetLength(string)     ([CCUtility stringToGetLength:string])  // 获取字符串的长度
#undef ArrayGetCount
#define ArrayGetCount(array)      ([CCUtility arrayToGetCount:array])  // 获取数组的数量
#undef DicGetCount
#define DicGetCount(dic)          ([CCUtility dictionaryToGetCount:dic])  // 获取字典的数量
#undef GetStringToValue
#define GetStringToValue(objc)    ([CCUtility getStringFormDic:(objc)])  // 获取为字符串 不是为@""
#undef GetArrayToValue 
#define GetArrayToValue(objc)     ([CCUtility getArrayFormDic:(objc)])  // 获取为数组  不是为nil
#undef GetDicToValue
#define GetDicToValue(objc)        ([CCUtility getDicFormDic:(objc)])   // 获取字典  不是为nil
#undef ArraryToString
#define ArraryToString(array)    ([CCUtility arraryToString:(array)])   // 数组转换成json字符串
#undef DicToString
#define DicToString(dic)        ([CCUtility dictionaryToString:(dic)])   // 字典转为json字符串
#undef StringToJson
#define StringToJson(jsonString)    ([CCUtility stringToJson:(jsonString)])   //  转为json
#undef StringAppend
#define StringAppend(firstStr,secondStr)  ([NSString stringWithFormat:@"%@%@",firstStr,secondStr])  // 两个字符组装

/**
 *  国际化
 */
#undef LocalKey
#define LocalKey(key) [CCUtility CCLocalizedString:(key)]
// 拼接URL    version  不需加/
#undef AppendURL
#define AppendURL(prefix,className,version,path) ([NSString stringWithFormat:@"%@%@%@%@",prefix,className,(version.length ? [NSString stringWithFormat:@"/%@",version] : @""),path])

#define kCode                                   @"code"
#define kData                                   @"data"
#define kMessage                                @"message"
#define kString                                 @"NSString"                // 字符串
#define kArray                                  @"NSArray"                 // 数组
#define kDictionary                             @"NSDictionary"            // 字典
#define kAttributedString                       @"NSAttributedString"
#define kNumber                                 @"NSNumber"             
#define kQuestionMark                           @"?"                        // ？
#define kJoiner                                 @"&"                        // &

#define ScreenGridViewHeight    (1/[UIScreen mainScreen].scale)
#define kDefaultAlertTime 2.0



#endif /* PublicHeader_h */
