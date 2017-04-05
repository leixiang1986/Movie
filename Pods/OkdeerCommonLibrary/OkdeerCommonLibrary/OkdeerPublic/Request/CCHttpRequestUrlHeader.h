//
//  CCHttpRequestUrlHeader.h
//  RequestFrameworks
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef CCHttpRequestUrlHeader_h
#define CCHttpRequestUrlHeader_h
#import "CCHttpRequestUrlManager.h"

    #define HTTP_MALLPrefix_URL         ([[CCHttpRequestUrlManager shareManager] selectFromMallPrefixUrl])                    // 商城
    #define HTTP_PropertyPrefix_URL     ([[CCHttpRequestUrlManager shareManager] selectFromPropertyPrefixUrl])                         // 物业
    #define HTTP_SellerPrefix_URL       ([[CCHttpRequestUrlManager shareManager] selectFromSellerPrefixUrl])                          // 商家app
    #define HTTP_UpdatePrefix_URL           ([[CCHttpRequestUrlManager shareManager] selectFromUpdatePrefixUrl])                          // Update
    #define UPGRADE_URL                 ([[CCHttpRequestUrlManager shareManager] selectFromUpdateUrl])  //更新版本地址

#endif /* CCHttpRequestUrlHeader_h */
