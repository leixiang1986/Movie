//
//  CCCinemaDetailScaduleFilmsCell.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCinemaDetailFilmsListModel.h"

// 影院详情中单个电影排期的cell
@interface CCCinemaDetailScaduleFilmsCell : UITableViewCell
@property (nonatomic, strong) CCCinemaDetailFilmsListModel *model;
@property (nonatomic, copy) void(^buyClickBlock)(CCCinemaDetailScaduleFilmsCell *cell);
@end
