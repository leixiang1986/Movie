//
//  CCCinemaDetailFilmsLayout.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>


// 影院详情的影片信息详情
@interface CCCinemaDetailFilmsLayout : UICollectionViewFlowLayout
//@property (nonatomic,assign) CGFloat maxWidth;
@property (nonatomic,assign) CGFloat lineSpacing;
@property (nonatomic,assign) CGFloat scale;

@property (nonatomic,copy) void (^filmsLayoutSelectIndexPathBlock)(CCCinemaDetailFilmsLayout *filmsLayout,NSIndexPath *selectIndexPath, NSIndexPath *unselectIndexPath);   
@end
