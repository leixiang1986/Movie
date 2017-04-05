//
//  FilmWillPlayingTbv.h
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//


/***********
 *
 *  即将上映
 *
 ***********/

@interface FilmWillPlayingTbv : CCCustomTableView

/**< 获取正在热映的影片 */
@property (nonatomic, strong) NSArray *filmsDataList;

@property (nonatomic, copy) void(^willPlayingTbvDidSelectBlock)(FilmWillPlayingTbv *tableView,NSIndexPath *indexPath);

@end
