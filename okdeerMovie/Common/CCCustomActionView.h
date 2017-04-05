//
//  CCCustomActionView.h
//  CloudCity
//
//  Created by 雷祥 on 16/1/29.
//  Copyright © 2016年 Mac. All rights reserved.
//
/**
 *  自定义的actionView
 */

#import <UIKit/UIKit.h>
//#import "CCNameAndIdModel.h"
#import "CCNameAndIdModel.h"
@class CCCustomActionView;

typedef BOOL (^ClickBtnBlock)(CCCustomActionView *view,NSInteger index) ;
@interface CCCustomActionView : UIView
@property (nonatomic,strong) NSArray <CCNameAndIdModel *>*dataSource;   /**< 数据源数组 */
@property (nonatomic,copy) NSString *title;         /**< 标题 */
@property (nonatomic,copy) NSString *btnTitle;      /**< 确认按钮的标题 */

- (void)setComfirmBtnClickBlock:(ClickBtnBlock)clickBlock;

- (void)showInView:(UIView *)superView withSelectIndex:(NSInteger)index;

- (void)hide;

@end
