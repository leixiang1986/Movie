//
//  OkdeerCommUIHeader.h
//  OkdeerCommonLibrary
//
//  Created by Mac on 16/10/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef OkdeerCommUIHeader_h
#define OkdeerCommUIHeader_h

#define kUIFullWidth   ([UIScreen mainScreen].bounds.size.width)
#define kUIFullHeight   ([UIScreen mainScreen].bounds.size.height)
/**
 *  判断版本是否大于等于7/8的布尔变量
 */
#define kUIIOS7UP ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define kUIIOS8UP ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define kUIIOS9UP  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define kUIIOS10UP ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

#endif /* OkdeerCommUIHeader_h */
