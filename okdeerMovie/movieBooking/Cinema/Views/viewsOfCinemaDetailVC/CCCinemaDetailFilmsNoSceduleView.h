//
//  CCCinemaDetailFilmsNoSceduleView.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/19.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

//某一部电影没有场次安排的view
@interface CCCinemaDetailFilmsNoSceduleView : UIView
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *btnTitle;

@property (copy, nonatomic) void (^btnClickBlock)(CCCinemaDetailFilmsNoSceduleView *view);
@end
