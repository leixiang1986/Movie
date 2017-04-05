//
//  CCCustomActionSheet.h
//  CloudCity
//
//  Created by Mac on 16/2/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  自定义的弹出框---其actionTitles 和clickActionBlock 为必须设置,其它属性可不设置，
 *  可直接使用该类所定义的+或-方法也可alloc加init后再设置属性。创建对象后通过isDisplay来控制弹出/隐藏
 */
@interface CCCustomActionSheet : UIView

@property (nonatomic, strong) NSArray *actionTitles;                               /**< Action 标题数组 */
@property (nonatomic, strong) NSArray *subTitles;                                   /**< 副标题数组，个数与标题相同 */
@property (nonatomic, strong) UIFont *titleFont;                                    /**< 标题的字体 */
@property (nonatomic, strong) UIColor *defaultTitleColor;                           /**< 默认的标题字体颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;                  /**< 选中的标题字体颜色 */
@property (nonatomic, copy) NSString *cancelTitle;                               /**< 取消标题 */
@property (nonatomic, strong) UIColor *cancelTitleColor;                    /**< 取消标题颜色 */
@property (nonatomic, strong) UIFont *cancelTitleFont;                       /**< 取消标题的字体 */
@property (nonatomic, strong) UIColor *lineColor;                           /**< 各标题间隔的分割线颜色 */
@property (nonatomic, copy) void (^actionBlock)(NSUInteger );               /**< 选择点击的回调Block */
@property (assign, nonatomic, setter=setDisplay:) BOOL isDisplay;                                   /**< 是否弹出显示--在点击隐藏后需再次显示，则直接使用isDisplay来控制隐藏/显示 */
@property (nonatomic, strong) UITableView *titlesList;                          /**< 标题列表, 若需要给弹出框增加标题，可通过titlesList 列表tableHeaderView来设置 */

//  自定义Cell 格式需设置的属性--注意自定义的cell必须有actionTitleLabel这个名字的属性
@property (nonatomic, copy) NSString *cellClassStr;         /**< 自定义cell 类名 */
@property (nonatomic, assign) CGFloat cellHeight;      /**< 自定义cell 高度 */

/**
 *  快速创建默认格式的ActinSheet
 *
 *  @param titles      actionTitle数组
 *  @param actionBlock 点击ActionTitle的回调Block
 *
 *  @return actionSheet
 */
+ (instancetype)actionSheetWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock;

/**
 *  初始化默认格式的ActinSheet
 *
 *  @param titles      actionTitle数组
 *  @param actionBlock 点击ActionTitle的回调Block
 *
 *  @return actionSheet
 */
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock;

/**
 *  带副标题的默认初始化方式
 *
 *  @param titles      标题
 *  @param subTitles   副标题
 *  @param actionBlock 点击事件
 *
 *  @return  instancetype
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles subTitles:(NSArray *)subTitles actionBlock:(void (^)(NSUInteger))actionBlock;



/**
 *  初始化ActinSheet，并自定义默认的列表字体颜色，及选中字体颜色
 *
 *  @param titles        actionTitle数组
 *  @param actionBlock   点击ActionTitle的回调Block
 *  @param defaultColor  默认的actionTitle字体颜色
 *  @param selectedColor 选中的actionTitle字体颜色
 *
 *  @return actionSheet
 */
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock defaultTitleColor:(UIColor *)defaultColor selectedTitleColor:(UIColor *)selectedColor;

/**
 *  完全自定义弹出框Cell格式--弹出框cell是UITableViewCell
 *
 *  @param titles       actionTitle数组
 *  @param actionBlock  点击cell的回调Block
 *  @param cellClassStr 自定义cell的类名
 *
 *  @return actionSheet
 */
+ (instancetype)actionSheetWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock cellClassStr:(NSString *)cellClassStr cellHeight:(CGFloat)cellHeight;


/**
 *  完全自定义弹出框Cell格式--弹出框cell是UITableViewCell
 *
 *  @param titles       actionTitle数组
 *  @param actionBlock  点击cell的回调Block
 *  @param cellClassStr 自定义cell的类名
 *
 *  @return actionSheet
 */
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock cellClassStr:(NSString *)cellClassStr cellHeight:(CGFloat)cellHeight;

@end
