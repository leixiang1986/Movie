//
//  CCUtility+Object.h
//  PublicFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//
// 获取object
#import "CCUtility.h"

typedef NS_ENUM(NSUInteger,ImageContentMode) {
    ImageContentModeDefault,   //限定缩略图的长边最多为<LongEdge>，短边最多为<ShortEdge>，进行等比缩放，不裁剪。如果只指定 w 参数则表示限定长边（短边自适应），只指定 h 参数则表示限定短边（长边自适应）。
    ImageContentModeGeometric, //限定缩略图的宽最少为<Width>，高最少为<Height>，进行等比缩放，居中裁剪。转后的缩略图通常恰好是 <Width>x<Height> 的大小（有一个边缩放的时候会因为超出矩形框而被裁剪掉多余部分）。如果只指定 w 参数或只指定 h 参数，代表限定为长宽相等的正方图  裁剪正中部分，等比缩小生成WxH缩略图
    ImageContentModeOf2,      //    /2/w/<Width>/h/<Height>	限定缩略图的宽最多为<Width>，高最多为<Height>，进行等比缩放，不裁剪。如果只指定 w 参数则表示限定宽（长自适应），只指定 h 参数则表示限定长（宽自适应）。它和模式0类似，区别只是限定宽和高，不是限定长边和短边。从应用场景来说，模式0适合移动设备上做缩略图，模式2适合PC上做缩略图。
    ImageContentModeOf3,     //限定缩略图的宽最少为<Width>，高最少为<Height>，进行等比缩放，不裁剪。如果只指定 w 参数或只指定 h 参数，代表长宽限定为同样的值。你可以理解为模式1是模式3的结果再做居中裁剪得到的。
    ImageContentModeOf4,       //限定缩略图的长边最少为<LongEdge>，短边最少为<ShortEdge>，进行等比缩放，不裁剪。如果只指定 w 参数或只指定 h 参数，表示长边短边限定为同样的值。这个模式很适合在手持设备做图片的全屏查看（把这里的长边短边分别设为手机屏幕的分辨率即可），生成的图片尺寸刚好充满整个屏幕（某一个边可能会超出屏幕）
    ImageContentModeOf5,   //限定缩略图的长边最少为<LongEdge>，短边最少为<ShortEdge>，进行等比缩放，居中裁剪。如果只指定 w 参数或只指定 h 参数，表示长边短边限定为同样的值。同上模式4，但超出限定的矩形部分会被裁剪。
};

@interface CCUtility (Object)

/**
	判断对象中有没这个属性
 */
+ (BOOL)getVariableWithClass:(Class) myClass varName:(NSString *)name;

/**
 *  拷贝共同的属性到另一个实例
 *
 *  @param objc    被拷贝的对象
 *  @param another 得到属性的对象
 */
+ (void)copyCommenPropertyOfObject:(NSObject *)objc toAnother:(NSObject *)another;

/**
 *  获取一个实体类中key对应的value
 *
 *  @param objc Name
 *  @param name    keyName
 *
 *  @return 对应的值
 */
+ (id)selectValueToClass:(NSObject *)objc varName:(NSString *)name ;
/**
 *  判断 对象是否属于某个对象
 */
+ (BOOL)whetherIdIsClass:(id)objc className:(NSString *)name;

/**
 *  根据key 获取对应的对象  若 这个对象不是NSDictionary 对象 返回值nil
 */
+ (id )dictionaryToGetValue:(id)dic keyName:(NSString *)key;
/**
 *  根据key 获取对应的对象  并且对象是否属于某个对象className   不是  返回nil
 */
+ (id)dictionaryToGetValue:(id)dic keyName:(NSString *)key isClass:(NSString *)className;
/**
 *  根据 index  获取数组对应的值  包括判断 有没越界
 */
+ (id)arrayToGetValue:(id)array indexInt:(NSInteger)index;
/**
 *  根据 index  获取数组对应的值  包括判断 有没越界  并且判断对象是否属于某个对象className  不是  返回nil
 */
+ (id)arrayToGetValue:(id)array indexInt:(NSInteger)index isClass:(NSString *)className;

/**
 *  获取字符串的长度
 */
+ (NSInteger)stringToGetLength:(id)string;
/**
 *  获取数组的数量
 */
+ (NSInteger)arrayToGetCount:(id)array;
/**
 *  获取字典的数量
 */
+ (NSInteger)dictionaryToGetCount:(id)dic;
/**
 *  数组转换成json字符串
 */
+ (NSString *)arraryToString:(NSArray *)array;
/**
 *  字典转为字符串的字典
 */
+ (NSString *)dictionaryToString:(NSDictionary *)dic;
/**
 *  转换为json
 */
+ (NSDictionary *)stringToJson:(id)jsonString;
/**
 *   判断是否为字符串  不是转换成字符串  去掉空的对象
 *
 *  @param dicResult 值
 *
 *  @return  NSString
 */
+(NSString *)getStringFormDic:(id)dicResult;
/**
 *  判断是否为数组  不是转换成数组  去掉空的对象
 *
 *  @param dicResult  dicResult
 *
 *  @return  NSArray
 */
+(NSArray *)getArrayFormDic:(id)dicResult;
/**
 *  判断是否为字典  不是转换成字典  去掉空的对象
 *
 *  @param dicResult  dicResult
 *
 *  @return  NSDictionary
 */
+(NSDictionary *)getDicFormDic:(id)dicResult;

/**
 *  字符串转换为价格  不四舍五入的  截取多余的字符串 不够在后面补0   digit 保留小数后几位
 */
+ (NSString *)stringChangeToPrice:(NSString *)string digit:(NSInteger)digit;

/**
 *  计算总价 商品 -,保留两位小数.
 *
 *  @param totalprice 输入参数总价 double
 *
 *  @return 返回计算后结果,保留2位小数
 */
+ (NSString *)calculateTotalPriceWithDouble:(double)totalprice;

/**
 *  读取通讯录,之后电话号码处理 +86 开头, 111-1111-1111
 *
 *  @param phoneNumber 通讯录中的电话号码
 *
 *  @return 返回处理好的电话号码
 */
+ (NSString *)handleABPhoneNumber:(NSString *)phoneNumber;

/**
 *  拼接完整的七牛链接
 *
 *  @param imageName         图片名称
 *  @param imagePrefix      图片前缀
 *  @param height           高度
 *  @param width            宽度
 *  @param imageContentMode 图片模式
 *
 *  @return 图片URL
 */
+ (NSString *)obtinCompleteUrl:(NSString *)imageName imagePrefix:(NSString *)imagePrefix height:(NSString *)height width :(NSString *)width imageContentMode:(ImageContentMode)imageContentMode;
/**
 * 实现两个方法的交换
 */
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
