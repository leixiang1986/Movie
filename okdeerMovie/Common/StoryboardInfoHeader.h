//
//  StoryboardInfoHeader.h
//  CCCommunityAction
//
//  Created by Mac on 15/10/29.
//  Copyright © 2015年 DeFei. All rights reserved.
//

#ifndef StoryboardInfoHeader_h
#define StoryboardInfoHeader_h

//>>>>>>>>>>>>>>>>>>>>>>>>> Storyboard 的文件名 >>>>>>>>>>>>>>>>>>>>>>>>>//
#define HomePage @"HomePage"
#define kGatePassStoryBoard @"GatePass"
#define PropertyHome @"Property"

//>>>>>>>>>>>>>>>>>>>>>>>>> ViewController 的storyboardID >>>>>>>>>>>>>>>>>>>>>>>>>//
//      首页
#define kCCHomePageVC @"homepageVC"     /**< 首页 CCHomePageViewController 的storyboardID */
#define kCCHomepageMoreServiceVC @"homepageMoreServiceVC"     /**< 首页更多服务 CCHomepageMoreServiceController 的storyboardID */


//      我的消息
#define kCCMessagesVC @"messagesVC"     /**< 我的消息 CCMessagesViewController 的storyboardID */
#define kCCMessageDetailVC @"messageDetailVC"     /**< 我的消息详情 CCMessageDetailViewController 的storyboardID */


//     物业
#define kCCPropertyBillVC @"propertyBillVC"     /**< 物业账单首页 CCPropertyBillViewController 的storyboardID */
#define kCCBillReportVC @"billReportVC"     /**<  物业账单->账单报表 CCBillReportViewController 的storyboardID */
#define kCCPayingOrderVC @"payingOrderVC"     /**<  物业账单->缴费订单 CCPayingOrderViewController 的storyboardID */


//     智慧小区
#define kCCSmartCommunityVC @"smartCommunityVC"     /**< 智慧小区首页 CCSmartCommunityViewController 的storyboardID */
#define kCCOpenDoorVC @"openDoorVC"     /**< 智慧小区-> 手机开门 CCOpenDoorViewController 的storyboardID */
#define kCCOpenDoorSetupVC @"openDoorSetupVC"     /**< 智慧小区-> 手机开门 -> 设置 CCOpenDoorSetupViewController 的storyboardID */
#define kCCOpenDoorAuthManageVC @"openDoorAuthManageVC"     /**< 智慧小区-> 手机开门 -> 设置->管理开门权限 CCOpenDoorAuthManageViewController 的storyboardID */
#define kCCOpenDoorFailReasonsVC @"openDoorFailReasonsVC"     /**< 智慧小区-> 手机开门 -> 门禁开启失败原因 CCOpenDoorFailReasonsViewController 的storyboardID */
#define kCCOpenDoorAuthListVC @"openDoorAuthListVC"     /**< 智慧小区-> 手机开门 -> 小区门禁授权列表 CCOpenDoorAuthListViewController 的storyboardID */
#define kCCOpenDoorOnekeyVC @"openDoorOnekeyVC"     /**< 智慧小区-> 手机开门 之一键开门 CCOpenDoorOnekeyViewController 的storyboardID */
#define kCCOpenDoorOrientationVC @"openDoorOrientationVC"     /**< 智慧小区-> 手机开门 之定向开门 CCOpenDoorOrientationViewController 的storyboardID */



//      在线支付
#define kCCOnlinePayVC @"onlinePayVC"     /**< 在线支付 CCOnlinePayViewController 的storyboardID */


//      定位
#define kCCCommunityLocationVC @"communityLocationVC"     /**< 物业模块下的小区搜索定位 CCCommunityLocationViewController 的storyboardID */
#define kCCLocationAllCommunityVC @"locationAllCommunityVC"     /**<物业模块-查看所定位城市的所有小区 CCLocationAllCommunityViewController 的storyboardID */
#define kCCHomepageCommunityLocationVC @"homepageCommunityLocationVC"     /**< 首页的小区搜索定位 CCHomepageCommunityLocationViewController 的storyboardID */
#define kCCChooseCityVC @"chooseCityVC"     /**< 选择城市 CCChooseCityViewController 的storyboardID */
#define kCCSearchResultVC @"searchResultVC"     /**< 小区搜索结果界面 CCSearchResultViewController 的storyboardID */

//  WebViewController
#define kCCWebViewVC @"webViewVC"     /**< WebView控制器界面 WebViewController 的storyboardID */

//  物业首页
#define kCCPropertyHomeVC @"propertyHomeVC"     /**< 物业首页 CCPropertyHomeViewController 的storyboardID */

//>>>>>>>>>>>>>>>>>>>>>>>>> cell 的复用Identitier >>>>>>>>>>>>>>>>>>>>>>>>>//
//      首页 Cell
#define kCCMessageCell  @"messageCell"    /**< 我的消息 CCMessageCell 的 Identitier */
#define kCCHomePageOperationCell  @"homePageOperationCell"    /**< 首页运营栏目 CCHomePageOperationCell 的 Identitier */
#define kCCServiceCollectionViewCell  @"serviceCollectionViewCell"    /**< 首页服务栏位 CCServiceCollectionViewCell 的 Identitier */
#define kCCSecKillCollectionViewCell  @"secKillCollectionViewCell"    /**< 首页限时秒杀 CCSecKillCollectionViewCell 的 Identitier */

//     物业 TableCell
#define kCCPropertyBillCell  @"propertyBillCell"    /**< 物业账单 CCPropertyBillCell 的 Identitier */
#define kCCBillReportCell  @"billReportCell"    /**< 账单报表Cell CCBillReportCell 的 Identitier */
#define kCCOnlinePayCell  @"onlinePayCell"    /**< 在线支付方式Cell CCOnlinePayCell 的 Identitier */
#define kCCPayingOrderCell  @"payingOrderCell"    /**< 缴费订单Cell CCPropertyBillCell 的 Identitier */
#define kCCPropertyBillRoomCell  @"propertyBillRoomCell"    /**< 物业房间号Cell CCPropertyBillRoomCell 的 Identitier */



//  手机开门TableCell
#define kCCOpenDoorPromptSetupCell  @"openDoorPromptSetupCell"    /**< 手机开门-设置界面的提示/震动设置的 CCOpenDoorPromptSetupCell 的 Identitier */
#define kCCOpenDoorSetupCell  @"openDoorSetupCell"    /**< 手机开门-设置界面的 CCOpenDoorSetupCell 的 Identitier */
#define kCCOpenDoorAuthCell  @"openDoorAuthCell"    /**< 手机开门-设置->管理开门权限界面的用户权限授权cell CCOpenDoorAuthCell 的 Identitier */
#define kCCOpenDoorAuthedListCell  @"openDoorAuthedListCell"    /**< 手机开门-开门失败原因->小区门禁授权列表（已开通cell）cell CCOpenDoorAuthedListCell 的 Identitier */
#define kCCOpenDoorUnAuthedListCell  @"openDoorUnAuthedListCell"    /**< 手机开门-开门失败原因->小区门禁授权列表（未开通cell）cell CCOpenDoorUnAuthedListCell 的 Identitier */
#define kCCOpenDoorOrientationCell  @"openDoorOrientationCell"    /**< 手机开门-定向开门 列表 CCOpenDoorOrientationCell 的 Identitier */


//  定位 --TableCell
#define kCCCommunityLocationCell  @"communityLocationCell"    /**< 物业的小区搜索定位的小区列表cell CCCommunityLocationCell 的 Identitier */
#define kCCHomepageCommunityLocationCell  @"homepageCommunityLocationCell"    /**< 首页的小区搜索定位的小区列表cell CCHomepageCommunityLocationCell 的 Identitier */
#define kCCLocationAllCommunityCell  @"locationAllCommunityCell"    /**< 物业的定位到城市后，查看该城市的所有小区列表 cell CCLocationAllCommunityCell 的 Identitier */
#define kCCChooseCityCell  @"chooseCityCell"    /**< 物业的定位到城市后，查看该城市的所有小区列表 cell CCChooseCityCell 的 Identitier */
#define kCCSearchResultCell  @"searchResultCell"    /**< 点击小区的搜索框->小区搜索结果界面列表的 cell CCSearchResultCell 的 Identitier */


//     账单报表月份CollectionCell
#define kCCBillReportMonthCell  @"billReportMonthCell"    /**< 账单报表 CCBillReportMonthCell 的 Identitier */
#define kCCBillRoomCell  @"billRoomCell"    /**< 账单报表的房间cell CCBillRoomCell 的 Identitier */


//  物业首页Cell
#define kCCPropertyNoticeCell  @"propertyNoticeCell"    /**< 物业首页的物业通知 CCPropertyNoticeCell 的 Identitier */
#define kGatePassHome @"gatePassHome"           //访客通行首页
#define kVisitorGatePass @"visitorGatePass"     //访客通行
#define kGoodsGatePass @"goodsGatePass"         //物品放行
#define kGatePassShareVC @"gatePassShareVC"     //分享的弹出层
#define kGatePassReasonVC @"CCGatePassReasonVC" //放行事由，放行物品，通行事由控制器

#define kCCTopCollectionViewCell  @"topCollectionViewCell"    /**< 物业首页的顶部 CCTopCollectionViewCell 的 Identitier */
#define kCCMidCollectionViewCell  @"midCollectionViewCell"    /**< 物业首页的中间 CCMidCollectionViewCell 的 Identitier */
#define kCCSurveyTableViewCell  @"surveyTableViewCell"    /**< 物业首页的调查 CCSurveyTableViewCell 的 Identitier */

//>>>>>>>>>>>>>>>>>>>>>>>>> UIStoryboardSegue 的Identitier >>>>>>>>>>>>>>>>>>>>>>>>>//
//     智慧小区
#define kSmartCommunityToOperDoor @"smartCommunityToOperDoor"     /**< 智慧小区到手机开门的segue */


#endif /* StoryboardInfoHeader_h */
