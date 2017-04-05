//
//  CCCustomOrderContentView.h
//  CloudCity
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCustomOrderContentView : UIView

@property (nonatomic,strong) UIFont *titleFont;        /**< 标题的字体 */
@property (nonatomic,strong) UIColor *titleColor;      /**< 标题的字体颜色 */
@property (nonatomic,strong) UIFont *contentFont;      /**< 内容的字体 */
@property (nonatomic,strong) UIColor *contentColor;    /**< 内容的字体颜色 */
@property (nonatomic,assign) CGFloat defaultHeight;    /**< 默认的高度 */
@property (nonatomic,readonly) CGFloat currentHeight;  /**< 当前view的高度 */
@property (nonatomic,assign) CGFloat titleWidth ;      /**< 标题的宽度 默认为57*/
@property (nonatomic,copy) NSString *content;           /**< 内容 */

/**
 *  标题字体的样式, 居左 居中 居右 by chenzl
 */
@property (nonatomic, assign)NSTextAlignment titleTextAlignment;
/**
 *  内容字体的样式, 居左 居中 居右 by chenzl
 */
@property (nonatomic, assign)NSTextAlignment contentTextAlignment;

/**
 *  为标题和内容赋值
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)assignmentOfTitle:(NSString *)title withContent:(NSString *)content;

/**
 *  扩充....
 *  为标题和内容赋值
 *  @param title   标题
 *  @param content 内容
 *  @param hidden 是否隐藏
 */
- (void)assignmentOfTitle:(NSString *)title withContent:(NSString *)content isHidden:(BOOL)hidden;

@end
