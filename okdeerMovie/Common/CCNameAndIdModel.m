//
//  CCNameAndIdModel.m
//  CloudCity
//
//  Created by 雷祥 on 16/3/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCNameAndIdModel.h"

@implementation CCNameAndIdModel
/**
 *  物业认证中的楼栋列表model
 *
 *  @param dic
 *
 *  @return
 */
+ (instancetype)modelObjectForPropertyBuildingWithDictionary:(NSDictionary *)dic {

    return [[self alloc] initWithDictionaryForPropertyBuilding:dic];
}

/**
 *  物业认证中的楼栋列表model
 *
 *  @param dic
 *
 *  @return
 */
- (instancetype)initWithDictionaryForPropertyBuilding:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        WEAKSELF(weakSelf)
        _name = DicGetValueIsClass(dic, @"buildingName", kString);
        _Id = DicGetValueIsClass(dic, @"buildingId", kString);
    }
    return self;
}



/**
 *  物业认证中的单元列表model
 *
 *  @param dic
 *
 *  @return
 */
+(instancetype)modelObjectForPropertyUnitWithDictionary:(NSDictionary *)dic {

    return [[self alloc] initWithDictionaryForPropertyUnit:dic];
}

/**
 *  物业认证中的单元列表model
 *
 *  @param dic
 *
 *  @return
 */
- (instancetype)initWithDictionaryForPropertyUnit:(NSDictionary *)dic {
    self = [super init];
    if (self) {

        _name = DicGetValueIsClass(dic, @"cellingName", kString);
        _Id = DicGetValueIsClass(dic, @"cellingId", kString);
    }
    return self;
}


/**
 *  物业认证中的房间列表model
 *
 *  @param dic
 *
 *  @return
 */
+(instancetype)modelObjectForPropertyRoomWithDictionary:(NSDictionary *)dic {

    return [[self alloc] initWithDictionaryForPropertyRoom:dic];
}

/**
 *  物业认证中的房间列表model
 *
 *  @param dic
 *
 *  @return
 */
- (instancetype)initWithDictionaryForPropertyRoom:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _name = DicGetValueIsClass(dic, @"roomName", kString);
        _Id = DicGetValueIsClass(dic, @"roomId", kString);
    }
    return self;
}

-(NSString *)Id {
    if (!_Id) {
        _Id = @"";
    }
    return _Id;
}

-(NSString *)name {
    if (!_name) {
        _name = @"";
    }
    return _name;
}


@end
