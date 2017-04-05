//
//  CCUtility+Object.m
//  PublicFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCUtility+Object.h"
#import "PublicHeader.h"
#import <objc/runtime.h>
@implementation CCUtility (Object)
/**
	判断对象中有没这个属性
 */
+ (BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name{
    unsigned int outCount, i;
    
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        Ivar property = ivars[i];
        
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        
        if ([keyName isEqualToString:name]) {
            
            return YES;
        }
    }
    return NO;
    
}
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
+  (NSArray *) allPropertyNames:(NSObject *)objc{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([objc class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    
    return allNames;
}

/**
 *  拷贝共同的属性到另一个实例
 *
 *  @param objc    被拷贝的对象
 *  @param another 得到属性的对象
 */
+ (void)copyCommenPropertyOfObject:(NSObject *)objc toAnother:(NSObject *)another {
    if (objc && another) {
        NSArray *objectPropertyNames =[self allPropertyNames:objc];
        for (NSInteger i = 0; i < objectPropertyNames.count; i++) {
            id objectPropertyName = objectPropertyNames[i];
            NSArray *anotherPropertyNames =[self allPropertyNames:another];
            if ([anotherPropertyNames containsObject:objectPropertyName]) {
                id objcProperty = [self selectValueToClass:objc varName:objectPropertyName];
                if (objcProperty) {
                    if ([another respondsToSelector:[self creatSetterWithPropertyName:objectPropertyName]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                        [another performSelector:[self creatSetterWithPropertyName:objectPropertyName] withObject:objcProperty];
#pragma clang diagnostic pop
                    }
                }
            }
        }
    }
}

#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回

/**
 *  创建setter方法
 *
 *  @param propertyName 方法名
 *
 *  @return 方法
 */
+ (SEL)creatSetterWithPropertyName:(NSString *)propertyName {
    if (propertyName.length == 0) {
        return nil;
    }

    return NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]);
}

+ (SEL) creatGetterWithPropertyName: (NSString *) propertyName{
    
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}
/**
 *  获取一个实体类中key对应的value
 *
 *  @param myClass class Name
 *  @param name    keyName
 *
 *  @return 对应的值
 */
+ (id)selectValueToClass:(NSObject *)objc varName:(NSString *)name{
    
    id value = nil;
    if ([objc isKindOfClass:[NSObject class]]) {
        //获取实体类的属性名
        NSArray *array=[self allPropertyNames:objc];
        if ([array containsObject:name]) {
            NSInteger index = [array indexOfObject:name];
            if (index < array.count) {
                //获取get方法
                SEL getSel = [self creatGetterWithPropertyName:array[index]];
                if ([objc respondsToSelector:getSel]){
                    //获得类和方法的签名
                    NSMethodSignature *signature = [objc methodSignatureForSelector:getSel];
                    //从签名获得调用对象
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                    //设置target
                    [invocation setTarget:objc];
                    //设置selector
                    [invocation setSelector:getSel];
                    //接收返回的值
                    NSObject *__unsafe_unretained returnValue = nil;
                    //调用
                    [invocation invoke];
                    //接收返回值
                    [invocation getReturnValue:&returnValue];
                    value = returnValue;
                }
            }
        }
    }
    return value;
}
/**
 *  判断 对象是否属于某个对象
 */
+ (BOOL)whetherIdIsClass:(id)objc className:(NSString *)name
{
    BOOL ret = NO;
    if (name.length) {
        Class myClass = NSClassFromString(name);
        if (!myClass) {
            ret = NO;
        }else{
            ret = [objc isKindOfClass:myClass] ? YES : NO;
        }
    }else{
        ret = NO;
    }
    return ret;
}

/**
 *  根据key 获取对应的对象  若 这个对象不是NSDictionary 对象 返回值nil
 */
+ (id )dictionaryToGetValue:(id)dic keyName:(NSString *)key
{
    
    if ([self whetherIdIsClass:dic className:kDictionary]) {
        NSDictionary *objc = (NSDictionary *)dic;
        if ([self whetherIdIsClass:objc[key] className:kString]) {
            return [CCUtility getStringFormDic:objc[key]];
        }
        else if ([self whetherIdIsClass:objc[key] className:kNumber]){
            return [CCUtility getStringFormDic:objc[key]];
        }
        id obj = objc[key];
        if ([obj isKindOfClass:[NSNull class]]) {
            return nil;
        }
        return objc[key];
    }else{
        return nil;
    }
}
/**
 *  根据key 获取对应的对象  并且对象是否属于某个对象className   不是  返回nil
 */
+ (id)dictionaryToGetValue:(id)dic keyName:(NSString *)key isClass:(NSString *)className
{
    
    id item = [self dictionaryToGetValue:dic keyName:key];
    if ([self whetherIdIsClass:item className:className]) {
        return item;
    }else{
        if ([className isEqualToString:kString] || [className isEqualToString:kNumber]) {
            return @"";
        }
        return nil;
    }
}

/**
 *  根据 index  获取数组对应的值  包括判断 有没越界
 */
+ (id)arrayToGetValue:(id)array indexInt:(NSInteger)index
{
    id item = nil;
    if ([self whetherIdIsClass:array className:kArray]) {
        NSArray *tempArray = (NSArray *)array;
        if (index < tempArray.count) {
            item = [tempArray objectAtIndex:index];
        }else {
            item = nil;
        }
    }else{
        item = nil;
    }
    return item;
}

/**
 *  根据 index  获取数组对应的值  包括判断 有没越界  并且判断对象是否属于某个对象 不是  返回nil
 */
+ (id)arrayToGetValue:(id)array indexInt:(NSInteger)index isClass:(NSString *)className
{
    id item = [self arrayToGetValue:array indexInt:index];
    if ([self whetherIdIsClass:item className:className]) {
        return item;
    }else{
        return nil;
    }
}

/**
 *  获取字符串的长度
 */
+ (NSInteger)stringToGetLength:(id)string
{
    NSInteger length = 0 ;
    if ([self whetherIdIsClass:string className:kString]) {
        NSString *tempString = (NSString *)string;
        length = tempString.length;
    }else{
        length = 0 ;
    }
    return length;
}
/**
 *  获取数组的数量
 */
+ (NSInteger)arrayToGetCount:(id)array
{
    NSInteger count = 0 ;
    if ([self whetherIdIsClass:array className:kArray]) {
        NSArray *tempArray = (NSArray *)array;
        count = tempArray.count;
    }else{
        count = 0 ;
    }
    return count;
}
/**
 *  获取字典的数量
 */
+ (NSInteger)dictionaryToGetCount:(id)dic
{
    NSInteger count = 0 ;
    if ([self whetherIdIsClass:dic className:kDictionary]) {
        NSDictionary *objc = (NSDictionary *)dic;
        count = objc.count;
    }
    return count;
    
}
/**
 *  数组转换成json字符串
 */
+ (NSString *)arraryToString:(NSArray *)array{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return @"";
    }
    
}
/**
 *  字典转为字符串的字典
 */
+ (NSString *)dictionaryToString:(NSDictionary *)dic {
    if (dic == nil) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSLog(@"Successfully serialized the dictionary into data.");
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
      
        return jsonString;
    }else{
        return @"";
    }
}

/**
 *  转换为json
 */
+ (NSDictionary *)stringToJson:(id)jsonString{
    NSDictionary *parmDic;
    if (![jsonString isKindOfClass:[NSDictionary class]] && [jsonString isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)jsonString;
        parmDic = [CCUtility requestReturnTypeOfDictionary:[string dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        parmDic = jsonString;
    }
    if (![parmDic isKindOfClass:[NSDictionary class]]) {
        parmDic = @{};
    }
    return parmDic;
}
/**
 *   判断是否为字符串  不是转换成字符串  去掉空的对象
 *
 *  @param dicResult 值
 *
 *  @return
 */
+(NSString *)getStringFormDic:(id)dicResult{
    if (dicResult) {
        if (![dicResult isKindOfClass:[NSNull class]] && ![dicResult isEqual:nil] && ![dicResult isEqual:[NSNull null]]) {
            NSString *result = @"";
            result = [NSString stringWithFormat:@"%@",dicResult];
            if (result && result.length > 0) {
                if ([result isEqualToString:@"(null)"] || [result isEqualToString:@"<null>"]) {
                    return @"";
                }
                else{
                    return result;
                }
            }
            else{
                return @"";
            }
        }
        else{
            return @"";
        }
    }  
    else{
        return @"";
    }
}
/**
 *  判断是否为数组  不是转换成数组  去掉空的对象
 *
 *  @param dicResult
 *
 *  @return
 */
+(NSArray *)getArrayFormDic:(id)dicResult{
    if (dicResult && [dicResult isKindOfClass:[NSArray class]]) {
        NSArray *resultArr = dicResult;
        if (resultArr && resultArr.count > 0) {
            return resultArr;
        }
        else{
            return nil;
        }
    }
    else{
        return nil;
    }
    
}

/**
 *  判断是否为字典  不是转换成字典  去掉空的对象
 *
 *  @param dicResult
 *
 *  @return
 */

+(NSDictionary *)getDicFormDic:(id)dicResult{
    
    if (dicResult && [dicResult isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultDic = dicResult;
        if (resultDic && resultDic.allKeys.count > 0) {
            return resultDic;
        }
        else{
            return nil;
        }
    }
    else{
        return nil;
    }
}

/**
 *  字符串转换为价格  不四舍五入的  截取多余的字符串 不够在后面补0   digit 保留小数后几位
 */
+ (NSString *)stringChangeToPrice:(NSString *)string digit:(NSInteger)digit{
    string = [CCUtility getStringFormDic:string];
    NSMutableString *price = [[NSMutableString alloc] init];
    if (StringGetLength(string)) {
        NSRange range = [string rangeOfString:@"."];
        if (range.location == NSNotFound) {
            [price appendString:string];
            if (digit > 0 ) {
                [price appendString:[self appDecimalString:@"" digit:digit]];
            }
        }else{
            NSArray *stringArray = [string componentsSeparatedByString:@"."];
            [price appendString:[CCUtility getStringFormDic:[stringArray firstObject]]];
            [price appendString:[self appDecimalString: ArrayGetValueIsClass(stringArray, 1, kString) digit:digit]];
        }
    }else{
        [price appendString:@"0"];
        [price appendString:[self appDecimalString:@"" digit:digit]];
    }
    return price;
}
/**
 *  处理小数点后的数据
 */
+ (NSString *)appDecimalString:(NSString *)string digit:(NSInteger)digit{
    NSMutableString *price = [[NSMutableString alloc] init];
    if (digit > 0 ) {
        [price appendString:@"."];
        if (StringGetLength(string) > digit) {
            string = [string substringToIndex:digit];
            [price appendString:string];
        }else{
            [price appendString:string];
            for (NSInteger i = string.length; i < digit; i ++ ) {
                [price appendString:@"0"];
            }
        }
    }
    return price;
}

/**
 *  计算总价 商品 -,保留两位小数.
 *
 *  @param totalprice 输入参数总价 double
 *
 *  @return 返回计算后结果,保留2位小数
 */
+ (NSString *)calculateTotalPriceWithDouble:(double)totalprice
{
    /**
     *  修正计算价格bug,使用%0.2f会自动四舍五入 bug 5550
     */
    NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler
                                         decimalNumberHandlerWithRoundingMode:NSRoundDown
                                         scale:2
                                         raiseOnExactness:NO
                                         raiseOnOverflow:NO
                                         raiseOnUnderflow:NO
                                         raiseOnDivideByZero:YES];
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",totalprice]];
    NSDecimalNumber *tal = [NSDecimalNumber decimalNumberWithString:@"1.0"];
    NSDecimalNumber *calcPrice = [total decimalNumberByMultiplyingBy:tal withBehavior:roundDown];
    NSString *totalStr = [NSString stringWithFormat:@"%@", calcPrice];
    NSRange rang = [self RangeOfString:totalStr searchStr:@"."];
    if (rang.location ==  NSNotFound) {
        totalStr  = [NSString stringWithFormat:@"%@.00",totalStr];
    }
    else {
        /**
         *  3.2.2 小数点后只有一位,补齐两位
         */
        NSArray *sepArray = [totalStr componentsSeparatedByString:@"."];
        if ([sepArray count] > 1) {
            NSString *decimalStr = [sepArray objectAtIndex:1];
            if ([decimalStr length] == 1) {
                totalStr = [NSString stringWithFormat:@"%@0",totalStr];
            }
        }
    }
    
    return totalStr;
}

/**
 *  判断查找字符串中是否包含字符串
 *  - 解决 被查找字符串是nil的情况,range.location 会是0(NSNotFound不是0),
 *  @param searchString 查找的字符串
 *  @return NSRange
 */
+ (NSRange)RangeOfString:(NSString *)ContainStr searchStr:(NSString *)searchString
{
    //如果被查找的字符串是nil, 返回的range.location 会是0. 会干扰后面对于NSNotFound的判断.
    if (!ContainStr || ContainStr.length <= 0) {
        return NSMakeRange(NSNotFound, 0);
    }
    //如果查找的字符串是nil值, 会导致程序崩溃.
    if (!searchString || [searchString length] <= 0) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    return [ContainStr rangeOfString:searchString];
}

/**
 *  读取通讯录,之后电话号码处理 +86 开头, 111-1111-1111
 *
 *  @param 通讯录中的电话号码
 *
 *  @return 返回处理好的电话号码
 */
+ (NSString *)handleABPhoneNumber:(NSString *)phoneNumber
{
    NSString *phoneNum;
    //+86 开头
    if ([phoneNumber hasPrefix:@"+86"] && [phoneNumber length] > 4) {
        phoneNum = [phoneNumber substringFromIndex:4];
    }
    else {
        phoneNum = phoneNumber;
    }
    //111-1111-1111
    NSArray *phoneArray = [phoneNum componentsSeparatedByString:@"-"];
    if ([phoneArray count]) {
        phoneNum = [phoneArray componentsJoinedByString:@""];
    }
    
    return phoneNum;
}

/**
 *  拼接完整的链接  拼接七牛的链接
 */
+ (NSString *)obtinCompleteUrl:(NSString *)imageName imagePrefix:(NSString *)imagePrefix height:(NSString *)height width :(NSString *)width imageContentMode:(ImageContentMode)imageContentMode
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    if (StringGetLength(imagePrefix)) {
        [urlString appendString:imagePrefix];
    }
    if (StringGetLength(imageName)) {
        [urlString appendString:imageName];
    }
    
    if (StringGetLength(height) || StringGetLength(width)) {
        NSRange range = [urlString rangeOfString:kQuestionMark];
        if (range.location == NSNotFound) {
            [urlString appendString:kQuestionMark];
        }else{
            [urlString appendString:kJoiner];
        }
        
        [urlString appendString:@"imageView2"];
        [urlString appendString:[self obtainImageContentMode:imageContentMode]];
        // 拼接宽度
        if (StringGetLength(width)) {
            NSString *wString = @"/w/";
            NSRange wRange = [urlString rangeOfString:wString];
            if (wRange.location == NSNotFound) {
                  [urlString appendFormat:@"%@%@",wString,[self convertToIntegerStr: width]];
            }
        }
        // 拼接高度
        if (StringGetLength(height)) {
            NSString *hString = @"/h/";
            NSRange hRange = [urlString rangeOfString:hString];
            if (hRange.location == NSNotFound) {
                [urlString appendFormat:@"%@%@",hString,[self convertToIntegerStr:height]];
            }
        }
    }
    
    return urlString;
}

+ (NSString *)convertToIntegerStr:(NSString *)str {
    NSInteger strValue = str.integerValue;
    return  [NSString stringWithFormat:@"%li", (long)strValue];
}

/**
 *  根据 imageContentMode 获取对应的模型
 */
+ (NSString *)obtainImageContentMode:(ImageContentMode)imageContentMode
{
    NSString *contentMode = @"";
    switch (imageContentMode) {
        case ImageContentModeDefault: {
            contentMode = @"/0";
            break;
        }
        case ImageContentModeGeometric: {
            contentMode = @"/1";
            break;
        }
        case ImageContentModeOf2: {
            contentMode = @"/2";
            break;
        }
        case ImageContentModeOf3: {
            contentMode = @"/3";
            break;
        }
        case ImageContentModeOf4: {
            contentMode = @"/4";
            break;
        }
        case ImageContentModeOf5: {
            contentMode = @"/5";
            break;
        }
    }
    return contentMode;
}
/**
 * 实现两个方法的交换
 */
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
