//
//  CCCinemaDetailFilmsDateCollectionViewCell.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
//电影院详情中选择排期日期的cell
@interface CCCinemaDetailFilmsDateCollectionViewCell : UICollectionViewCell

//设置数据
- (void)setDate:(NSString *)date select:(BOOL)select ;
@end
