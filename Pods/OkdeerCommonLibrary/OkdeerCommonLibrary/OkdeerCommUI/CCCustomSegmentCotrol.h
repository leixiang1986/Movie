//
//  CCCustomSegmentCotrol.h
//  XIBScrollView
//
//  Created by Mac on 1/25/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CCCustomSegmentCotrolDelegate <NSObject>
@optional
-(void)selectIndex:(NSInteger)index;    //选中第几个
-(void)selectTitle:(NSString *)title;   //选中标题

@end


@interface CCCustomSegmentCotrol : UIView

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *imagesArr;
@property (nonatomic,strong) UIColor *selectColor;//选中的按钮颜色和边框颜色
@property (nonatomic,strong) UIColor *unSelectColor; //背景色（没有被选中的按钮颜色）
@property (nonatomic,assign) NSInteger selectIndex;   //选中的第几个按钮
@property (nonatomic,weak) id<CCCustomSegmentCotrolDelegate>delegate;
@end
