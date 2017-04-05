//
//  CCCinemaDetailFilmsView.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>
//影院详情中的影片信息view
@interface CCCinemaDetailFilmsView : UIView
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) NSArray *filmsArr;
@property (nonatomic, copy) void (^selectItemBlock)(CCCinemaDetailFilmsView *filmsView,NSIndexPath *selectIndexPath, NSIndexPath *unselectIndexPath); //取消选中的unselectIndex默认为-1
@end
