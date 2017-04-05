//
//  CCUtility.m
//  CloudCity
//
//  Created by JuGuang on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "CCUtility.h"
#import "PublicHeader.h"
#include <sys/xattr.h>
#import "CommonCrypto/CommonDigest.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>
#import <Photos/Photos.h>

@implementation CCUtility


/**
 *  判断该路径下是否有文件
 *
 *  @param path
 *
 *  @return 返回布尔值
 */
+(BOOL)isExistFileForPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}
/**
 *  得到系统的缓存路径
 *
 *  @return 缓存路径
 */
+ (NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
/**
 *  得到根目录
 *
 *  @return
 */
+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  获取Caches文件夹
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCachePath{
    NSString *deletedDirectory = [NSString stringWithFormat:@"%@/Library/Caches", NSHomeDirectory()];
    return deletedDirectory;
}
/**
 *  删除缓存文件夹
 *
 *  @return
 */
+ (void)deleteFilesInCacheDirectory{    //删除缓存文件夹的可删除文件夹
    [[NSFileManager defaultManager] removeItemAtPath:[self getCachePath] error:nil];
}
/**
 *  清除文件夹下所有的文件及文件夹
 *
 *  @param directory 所要删除的文件夹目录
 */
+(void)deleteFilesInDirectory:(NSString *)directory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
    }
}
/**
 *  防止上传到icloud
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL bundleIdentifier:(NSString *)bundleIdentifier
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = [bundleIdentifier UTF8String];
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}
/**
 *  获取启动图路径
 *
 *  @return
 */
+(NSString *)getLaunchImagePath{
    NSString *launchImageDirectoryPath = [NSString stringWithFormat:@"%@/launchImagePath", [self getDocumentBaseDirectory]];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:launchImageDirectoryPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        existed = [fileManager createDirectoryAtPath:launchImageDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        return [launchImageDirectoryPath stringByAppendingString:@"/launchImage"];
    }
    else{
        return nil;
    }
}

/**
 *  删除启动图文件夹
 *
 *  @return
 */
+(BOOL)deleteLaunchImageDirectoryPath{
    return [[NSFileManager defaultManager] removeItemAtPath:[self getLaunchImagePath] error:nil];
}
/**
 *  获取旧的数据库路径
 *
 *  @return
 */
+(NSString *)getDataBaseOldPath{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path ;
    if (array.count != 0) {
        path = array [0];
    }
    NSString *dbFilePath ;
    if (path.length != 0 ) {
        dbFilePath = [path stringByAppendingPathComponent:@"dataBase.db"] ;
    }
    return dbFilePath ;
}
/**
 *  创建document文件夹下的不删除的base文件夹
 *
 *  @return
 */
+(NSString *)getDocumentBaseDirectory{
    NSString *documentBaseDirectory = [NSString stringWithFormat:@"%@/Documents/CloudCityBase", NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:documentBaseDirectory isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:documentBaseDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentBaseDirectory;
}
/**
 *  创建文件夹
 *
 *  @param rootPath      路径，必须是文件夹路径
 *  @param directoryName 路径下面的文件夹名字
 *
 *  @return 返回整个文件夹的路径
 */
+(NSString *)creatDirectoryRootPath:(NSString *)rootPath andDirectoryName:(NSString *)directoryName{
    
    NSString *directoryPath = [NSString stringWithFormat:@"%@/%@", rootPath,directoryName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
       [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directoryPath;
}


/**
 *  获取录音的文件夹
 *
 *  @return 
 */
+(NSString *)getRecordDirectory{
    NSString *path = [NSString stringWithFormat:@"%@/Record",[self getCachePath]];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

/**
 *  删除文件或文件夹
 *
 *  @param filePath 需要删除的路径
 *
 *  @return
 */
+(BOOL)deleteFile:(NSString *)filePath{
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}


/**
 * 网络请求 返回是Dictionary  对象
 *
 *  @param response
 *
 *  @return
 */
+ (NSDictionary *)requestReturnTypeOfDictionary:(id)response{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    return dic ;
}

/**
 * 网络请求 返回是Array  对象
 *
 *  @param response
 *
 *  @return
 */
+ (NSArray *)requestReturnTypeOfArray:(id)response {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    return array ;
}
/**
 * 网络请求  判断返回是否为空和是否错误的
 *
 *  @param response
 *
 *  @return
 */
+ (BOOL)requestResponseObjectIsTrue:(id)respone{
    BOOL ret = NO ;
    if (respone && ![respone isKindOfClass:[NSError class]]) {
        ret = YES;
    }else{
        ret = NO ;
    }
    return ret ;
}

/**
 *  拨打电话
 *
 *  @param view     当前的控制器的view
 *  @param phoneNum 手机号
 */
+(void)phoneCall:(UIView *)view num:(NSString *)phoneNum
{
    UIWebView*callWebview =[[UIWebView alloc] init] ;
    
    NSURL *telurl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telurl]];
    [view addSubview:callWebview];
}
/**
 *  移除文件
 */
+(void)removeForder:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL result = [fileManager removeItemAtPath:filePath error:nil];
        if (result) {
        }
    }
}
+(BOOL)isFileExist:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

/**
 *  判断是否是第一次运行（下载或更新）
 */
+(BOOL)dateUped:(BOOL)save code:(NSString *)code{
    NSString *verTionStr = code;
    NSString *loginedVertionStr = [NSString stringWithFormat:@"logined%@",verTionStr];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault boolForKey:loginedVertionStr]) {
        return NO;
    }
    else{
        if (save) {     //以版本字段为key，保存布尔值YES，标示已经更新过
            [userDefault setBool:YES forKey:loginedVertionStr];
        }
        return YES;
    }
}

/**
 *  强制隐藏键盘方法
 */
+ (void)hideKeyboard{
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    return ;
}
/*
 *  判断有没开启相机权限
 *
 *  @return yes 为开启中  no 没有开启
 */
+ (BOOL)isAuthorizationStatusTypeCamera:(BOOL)isAlert{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
     BOOL isAuthor = YES;
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        isAuthor = NO;
    }
    if (isAlert && !isAuthor) {
        NSDictionary *dicInfo = [CCUtility dictionaryFromInfoPlist];
        NSString *name = @"";
        if ([dicInfo isKindOfClass:[NSDictionary class]]) {
            name = dicInfo[@"CFBundleDisplayName"];
        }
        if (!name) {
            name = @"";
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您没开启相机功能 请在设置->隐私->相机->%@ 设置为打开状态",name] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
    
    return isAuthor;
}

/*!
 *  判断有没开启相册权限
 *
 *  @return yes 为开启中  no 没有开启
 */
+ (BOOL)isAuthorizationStatusTypePhotoLibrary:(BOOL)isAlert{
    BOOL isAuthor = YES;
    
    if (iOS8UP) {
         PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
            // 无权限
            isAuthor = NO;
        }
    }else{
         ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
        {
            // 无权限
           isAuthor = NO;
        }
    }
   
    if (isAlert && !isAuthor) {
        NSDictionary *dicInfo = [CCUtility dictionaryFromInfoPlist];
        NSString *name = @"";
        if ([dicInfo isKindOfClass:[NSDictionary class]]) {
            name = dicInfo[@"CFBundleDisplayName"];
        }
        if (!name) {
            name = @"";
        }
 
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您没开启照片功能 请在设置->隐私->照片->%@ 设置为打开状态",name] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
    return isAuthor;
}
//获取键盘高度
+ (CGFloat)getKeyboardHeight:(NSNotification *)object{

    NSDictionary *info = [object userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    return keyboardSize.height ;
}
/**
 *  增加截取小数点, 只舍不入.
 *  @price 输入数, @position 截取位数
 */
+ (NSString *)notRounding:(float)price afterPoint:(int)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


#pragma mark - 发现当前语言并非项目支持的语言时，统一访问指定的资源文件，返回默认的资源
/**
 *  根据key 获取不同语言对应的词语
 *
 *  @param translation_key key
 *
 *  @return
 */
#define CURR_LANG    ([[NSLocale preferredLanguages] objectAtIndex:0])
+ (NSString *)CCLocalizedString:(NSString *)translation_key {
    
    NSString * s = NSLocalizedString(translation_key, nil);
    // 判断当前的语言是不是项目支持的语言
    /*
     iOS9 变成了en-US 和 zh-Hans-US, 香港 zh-HK
     iOS8 及以下 还是en 和 zh-Hans
     */
    // 若不是 取值为中文简体的语言对应的文字
    if (![CURR_LANG hasPrefix:@"en"] && ![CURR_LANG hasPrefix:@"zh-Hans"]) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    }else if ([s isEqualToString:translation_key]){
        // 判断根据key 获取出来的国际化是否跟key一样
        // 是 取值为中文简体的语言对应的文字
        NSString * path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    }
    return s;
}



/**
 *  从ABRecordRef信息中获取电话号码 ;
 *
 *  @param person
 *
 *  @return
 */
+ (NSString *)phoneNumFormABRecordRef:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    ABMultiValueRef valuesRef =ABRecordCopyValue(person, kABPersonPhoneProperty);
    //查找这条记录中的名字
    NSString *firstName =CFBridgingRelease(ABRecordCopyValue(person,kABPersonFirstNameProperty));
    firstName = firstName != nil? firstName:@"";
    //查找这条记录中的姓氏
    NSString *lastName =CFBridgingRelease(ABRecordCopyValue(person,kABPersonLastNameProperty));
    lastName = lastName != nil? lastName:@"";
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",lastName,firstName]);
    //     CFRelease(person);
    CFIndex index =ABMultiValueGetIndexForIdentifier(valuesRef,identifier);

    CFStringRef value =ABMultiValueCopyValueAtIndex(valuesRef,index);

    NSString *phoneNum=[NSString stringWithFormat:@"%@",(__bridge NSString*)value];
    if ([phoneNum isEqualToString:@"(null)"]) {
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
+ (NSString *)retentionIntString:(NSString *)number{
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]
                                   invertedSet];
    NSString *newString = [[number componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    return newString;
}

/**
 *  获取info.plist的字典
 *
 *  @return 返回字典
 */
+ (NSDictionary *)dictionaryFromInfoPlist {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent: @"Info.plist"];
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    return infoDic;
}
/**
 *  获取随机的32位
 */
+ (NSString *)obtainRandom32 {
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < 4; i++){
        [str appendString:[NSString stringWithFormat:@"%lu", (unsigned long)(10000000 + (arc4random() % 90000000))]];
    }
    return str;
}

/**
 *  判断是否开启系统通知
 */
+ (BOOL)isAllowedNotification{
    if (iOS8UP) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}
/**
 *  链接拼接keyValue
 */
+ (NSString *)stringUrlAppendToken:(NSString *)url key:(NSString *)key value:(NSString *)value{
    
    NSRange rang = [url rangeOfString:kQuestionMark];
    if (rang.location == NSNotFound) {
        url = [NSString stringWithFormat:@"%@%@%@=%@",url,kQuestionMark,key,value];
    }else{
        url = [NSString stringWithFormat:@"%@%@%@=%@",url,kJoiner,key,value];
    }
    return url;
}
/**
 *  获取时间戳  毫秒
 *
 *  @return 毫秒
 */
+ (NSString *)obtainTimeInterval{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeInterval = [NSString stringWithFormat:@"%f",interval];
    NSInteger maxLength = 13;
    if (timeInterval.length > maxLength) {
        timeInterval = [timeInterval substringToIndex:maxLength];
    }
    
    return timeInterval;
}
/**
 *  链接编码 不对＃进行编码
 */
+ (NSString *)concatenatedCoding:(NSString *)urlPath
{
    NSCharacterSet *uRLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"+<>[\\]^`{|}"] invertedSet];
    urlPath = [urlPath stringByAddingPercentEncodingWithAllowedCharacters:uRLCombinedCharacterSet];
    return urlPath;
}
/**
 *  对特殊编码的编码
 */
+ (NSString *)concatenatedKey:(NSString *)key{
    NSCharacterSet *uRLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"+%<>[\\]^`{|}/"] invertedSet];
    key = [key stringByAddingPercentEncodingWithAllowedCharacters:uRLCombinedCharacterSet];
    return key;
}
/**
 *  过滤空格 和换行符
 */
+ (NSString *)removeairAndWrap:(NSString *)string
{
    NSString *tempString = [string  stringByReplacingOccurrencesOfString:@" " withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return tempString;
}


#pragma mark - /*** 顶层控制器 ***/
/**
 *  获取最顶层的控制器
 */
+ (UIViewController *)obtainCurrentViewController{
    UIViewController *viewController = [self activityViewController];
    UIViewController *lastViewController  = [self getCurrentViewController:viewController];
    return lastViewController;
}

/**
 *  获取最顶层的控制器
 */
+ (UIViewController *)getCurrentViewController:(UIViewController *)viewController
{
    UIViewController *lastViewController  = nil;
    
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController *)viewController ;
        NSInteger selectIndex = tabBarController.selectedIndex ;
        if (selectIndex < tabBarController.viewControllers.count) {
            UIViewController *tabViewController = tabBarController.viewControllers[selectIndex];
            if ([tabViewController isKindOfClass:[UINavigationController class]]) {
                lastViewController = [[(UINavigationController *)tabViewController viewControllers] lastObject];
                lastViewController = [self getPresentedViewController :lastViewController];
            }else{
                lastViewController = [self getPresentedViewController:tabViewController];
            }
        }
    }else if ([viewController isKindOfClass:[UINavigationController class]]){
        
        lastViewController = [[(UINavigationController *)viewController viewControllers] lastObject];
        lastViewController = [self getPresentedViewController:lastViewController];
    }else{
        
        lastViewController = [self getPresentedViewController:viewController];
    }
    
    return lastViewController;
}
/**
 *  获取PresentedViewController
 */
+ (UIViewController *)getPresentedViewController:(UIViewController *)viewController
{
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;                // 1. ViewController 下
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {                // 2. NavigationController 下
            viewController =  [self getCurrentViewController:viewController];
        }
        
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            viewController = [self getCurrentViewController:viewController];     // 3. UITabBarController 下
        }
    }
    return viewController;
}
/**
 *  获取当前处于activity状态的view controller
 */
+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}
@end
