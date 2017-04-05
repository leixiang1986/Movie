//
//  CCFilmOnWillPlayingTbvCell.h
//  okdeerMovie
//
//  Created by Mac on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCFilmPlayingListModel;

@interface CCFilmOnWillPlayingTbvCell : UITableViewCell

@property (nonatomic, strong) CCFilmPlayingListModel *listModel;

/**
 *  点击 购买/预售 按钮
 */
@property (nonatomic, copy) void (^filmBuyBtnClciked)(CCFilmOnWillPlayingTbvCell *cell);

@end
