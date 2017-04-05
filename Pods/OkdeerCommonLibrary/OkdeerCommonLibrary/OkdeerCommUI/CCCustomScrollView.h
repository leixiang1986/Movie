//
//  CCCustomScrollView.h
//  CloudCity
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCCustomScrollView;
typedef void(^HeaderRefereshBlock)(CCCustomScrollView *view);   /**< 下拉刷新 */

@interface CCCustomScrollView : UIScrollView

@property (nonatomic,copy) HeaderRefereshBlock headerRefereshBlock;
/**
 *  停止刷新加载动画 
 */
- (void)stopReferesh;
@end
