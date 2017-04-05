//
//  CCNotificationView.h
//  CloudMall
//
//  Created by 雷祥 on 15/11/25.
//  Copyright © 2015年 CloudCity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCNotificationView : UIView

@property (nonatomic,copy) NSString *message;
@property (nonatomic,strong) UIImage *iconImage;        /**< 图片logo*/
@property (nonatomic,copy) NSString *titleString;       /**< 标题 */

@property (nonatomic,copy) void (^tapBlock)(void);
+ (instancetype)shareInstance;
- (void)show;
@end
