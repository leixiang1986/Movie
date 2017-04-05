//
//  CCCinemaDetailFilmModel.h
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/20.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
//排片详情中，中间段影片的model
@interface CCCinemaDetailFilmModel : NSObject
@property (nonatomic, copy) NSString *image;            //图片链接
@property (nonatomic, copy) NSString *name;             //片名
@property (nonatomic, copy) NSString *score;            //分数
@property (nonatomic, copy) NSString *introduction;     //简介
@end
