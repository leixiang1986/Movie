//
//  CCCinemaDetailFilmsScheduleView.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCCinemaDetailFilmsScheduleView;
@class CCCinemaDetailFilmsSceduleModel;

typedef void(^CinemaDetailSelectItemBlock)(CCCinemaDetailFilmsScheduleView *view,NSIndexPath *indexPath);
typedef void(^CinemaDetailTapTipsBlock)(CCCinemaDetailFilmsScheduleView *view);

@interface CCCinemaDetailFilmsScheduleView : UIView
@property (nonatomic,strong) CCCinemaDetailFilmsSceduleModel *scheduleModel; //某一天某个影片的排片
//@property (nonatomic,strong) NSArray *dataSource;                       /**< <#注释内容#> */
@property (nonatomic,strong) NSArray *dateArr;                          /**< 日期数组 */
@property (nonatomic,strong,readonly) NSDate *selectDate;               /**< 选中的日期 */

@property (nonatomic,copy) CinemaDetailSelectItemBlock selectFilmBlock; /**< 点击电影的回调事件 */
@property (nonatomic,copy) CinemaDetailSelectItemBlock selectDateBlock; /**< 点击日期的回调事件 */
@property (nonatomic,copy) CinemaDetailTapTipsBlock tapTipsBlock;       /**< 点击优惠提示的事件 */

@end
