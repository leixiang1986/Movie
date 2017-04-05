//
//  CCFilmOrderTypeModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/17.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CCFilmOrderType) {
    CCFilmOrderTypeIssuing,         /**< 出票中 */
    CCFilmOrderTypeRefunding,       /**< 出票失败系统退款中 */
    CCFilmOrderTypeFail,            /**< 出票失败 */
    CCFilmOrderTypeSucceed          /**< 出票成功 */
};

@interface CCFilmOrderTypeModel : NSObject
@property (nonatomic, copy) NSString *stateName;        /**< 状态名字 */
@property (nonatomic, copy) NSString *note;             /**< 备注信息(如系统退款中) */
@property (nonatomic, assign) CCFilmOrderType type;     /**< 类型 */

@end
