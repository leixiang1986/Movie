//
//  CCCategorHeader.h
//  OkdeerCategory
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef CCCategorHeader_h
#define CCCategorHeader_h

#define ASSETS_GROUP_PROPERTYNAME     @"友门鹿"

#define COLOR_E2E2E2    0xe2e2e2
#define COLOR_FAFAFA    0xfafafa
#define COLOR_EDEDED    0xededed    // ededed
#define COLOR_CCCCCC    0xcccccc    // cccccc

//色码转RGB UIColor
#undef UIColorFromHex
#define UIColorFromHex(hexValue) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:1.0])
//附带透明度
#undef UIColorFromHexA
#define UIColorFromHexA(hexValue,a) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:(a)])

//UITextField.placeholder 默认颜色值
#undef TextFieldplaceColor
#define TextFieldplaceColor ([UIColor colorWithRed:0 green:0 blue:0.098039 alpha:0.22])

/**
 *  字体的大小
 */
#undef FONTWITHNAME
#define FONTWITHNAME(fontName,fontSize)    ([UIFont fontWithName:fontName size:fontSize])
//系统默认字体   设置字体的大小
#undef FONTDEFAULT
#define FONTDEFAULT(fontSize)            ([UIFont systemFontOfSize:fontSize])
//系统加粗字体   设置字体的大小
#undef FONTBOLD
#define FONTBOLD(fontSize)            ([UIFont boldSystemFontOfSize:fontSize])

#endif /* CCCategorHeader_h */
