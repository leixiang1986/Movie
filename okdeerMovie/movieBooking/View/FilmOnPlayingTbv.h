//
//  FilmOnPlayingTbv.h
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

/***********
 *
 *  正在热映
 *
 ***********/

#import "CCFilmPlayingListModel.h"

@interface FilmOnPlayingTbv : CCCustomTableView

/**< 获取正在热映的影片 */
@property (nonatomic, strong) NSArray *filmsDataList;

/**
 *  点击某一行 的回调
 */
@property (nonatomic, copy) void(^onPlayingTbvDidSelectBlock)(FilmOnPlayingTbv *tableView, CCFilmPlayingListModel *listModel);

/**
 *  点击 购买/预售 按钮回调
 */
@property (nonatomic, copy) void (^onPlayingTbvFilmBuyBlock)(FilmOnPlayingTbv *tableView, CCFilmPlayingListModel *listModel);

@end
