//
//  CCNameAndIdModel.h
//  CloudCity
//
//  Created by 雷祥 on 16/3/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

/**< 名字和id的model,作为通用的model */
#import <Foundation/Foundation.h>

@interface CCNameAndIdModel : NSObject
@property (nonatomic,copy) NSString *name;          /**< 名字 */
@property (nonatomic,copy) NSString *Id;            /**< id */

/**
 *  物业认证中的楼栋列表model
 *
 *  @param dic
 *
 *  @return
 */
+(instancetype)modelObjectForPropertyBuildingWithDictionary:(NSDictionary *)dic;

/**
 *  物业认证中的单元列表model
 *
 *  @param dic
 *
 *  @return
 */
+(instancetype)modelObjectForPropertyUnitWithDictionary:(NSDictionary *)dic;

/**
 *  物业认证中的房间列表model
 *
 *  @param dic
 *
 *  @return
 */
+(instancetype)modelObjectForPropertyRoomWithDictionary:(NSDictionary *)dic;


@end
