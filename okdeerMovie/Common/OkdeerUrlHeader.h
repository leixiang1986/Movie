//
//  OkdeerUrlHeader.h
//  OkdeerUser
//
//  Created by Mac on 16/9/27.
//  Copyright © 2016年 okdeer. All rights reserved.
//
 
#ifndef OkdeerUrlHeader_h
#define OkdeerUrlHeader_h

/**
 *  接口地址   注: USERCENTER_HOST  MESSAGECENTER_HOST  BASIS_HOST  暂时不需要  现在只有物业和商城的
 */
#ifdef DEBUG          // 在debug时连开发环境，发布时连正式环境

#define ISDEVE       // 判断是否在开发 (打开是, 注释否)

#ifdef ISDEVE

static NSString *const kProperty_Host    = @"http://psmsmobile.dev02.youmenlu.com";   // 物业后台
static NSString *const kMall_Host        = @"http://mallmobile.dev02.youmenlu.com" ;   // 商城后台
static NSString *const kSellerApp_Host   = @"http://seller.dev02.youmenlu.com";    // 商家app
static NSString *const kUpload_host      = @"http://update.dev02.youmenlu.com";     // 升级

#define HTTP_MallDefult_URL            ([NSString stringWithFormat:@"%@%@",kMall_Host,@""])      // 商城的前缀
#define HTTP_PropertyDefult_URL       ([NSString stringWithFormat:@"%@%@",kProperty_Host,@""])   // 物业的前缀
#define HTTP_SellerAppDefult_URL      ([NSString stringWithFormat:@"%@%@",kSellerApp_Host,@""]) // 商家app的前缀

#else

static NSString *const kProperty_Host    = @"http://psmsmobile.test04.youmenlu.com";   // 物业后台
static NSString *const kMall_Host        = @"http://mallmobile.test04.youmenlu.com" ;   // 商城后台
static NSString *const kSellerApp_Host   = @"http://seller.test04.youmenlu.com";    // 商家app
static NSString *const kUpload_host      = @"http://update.test04.youmenlu.com";     // 升级


#define HTTP_MallDefult_URL            ([NSString stringWithFormat:@"%@%@",kMall_Host,@""])      // 商城的前缀
#define HTTP_PropertyDefult_URL       ([NSString stringWithFormat:@"%@%@",kProperty_Host,@""])   // 物业的前缀
#define HTTP_SellerAppDefult_URL      ([NSString stringWithFormat:@"%@%@",kSellerApp_Host,@""]) // 商家app的前缀

#endif

#else

static NSString *const kProperty_Host    = @"http://psmsmobile.test04.youmenlu.com";   // 物业后台
static NSString *const kMall_Host        = @"http://mallmobile.test04.youmenlu.com" ;   // 商城后台
static NSString *const kSellerApp_Host   = @"http://seller.test04.youmenlu.com";    // 商家app
static NSString *const kUpload_host      = @"http://update.test04.youmenlu.com";     // 升级

#define HTTP_MallDefult_URL            ([NSString stringWithFormat:@"%@%@",kMall_Host,@""])      // 商城的前缀
#define HTTP_PropertyDefult_URL       ([NSString stringWithFormat:@"%@%@",kProperty_Host,@""])   // 物业的前缀
#define HTTP_SellerAppDefult_URL      ([NSString stringWithFormat:@"%@%@",kSellerApp_Host,@""]) // 商家app的前缀

#endif

// appType  01 为用户版  02 为商家版 03 为物业版
#define HTTP_UPGRADE_URL                 ([NSString stringWithFormat:@"%@%@",kUpload_host,@"/mobile/version?appType=01&versionType=ios"])  //更新版本地址

#endif /* OkdeerUrlHeader_h */
