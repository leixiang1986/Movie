//
//  CCCustomTableView.h
//  CloudCity
//
//  Created by 雷祥 on 15/4/10.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCCustomTableView;

typedef void(^ResultBlock)(BOOL);   //返回请求成功还是失败的block
typedef void(^FooterRefreshBlock)(CCCustomTableView *tableView,NSInteger index,ResultBlock resultBlock);

@interface CCCustomTableView : UITableView

@property (nonatomic, strong) UIView *noDataView;         /**< 暂无相关数据 由外部实现 */

/**
 *  最后一页是否提示
 */
@property (nonatomic,assign) BOOL isLastPage;

/**
 *  最后一页的提示信息
 */
@property (nonatomic,copy) NSString *lastPageMessage;

/**
 *  总页数,默认为1000
 */
@property (nonatomic,assign) NSInteger totalPage;

/**
 *  当前页数,默认为1
 */
@property (nonatomic,assign) __block NSInteger currentPage;

/**
 *  下拉刷新
 */
@property (nonatomic, copy) void(^headerRefereshBlock)(CCCustomTableView *tableView,NSInteger currentPage);

/**
 *  下拉刷新---,自定义首页,Gif动态图
 */
@property (nonatomic, copy) void(^headerGifRefreshBlock)(CCCustomTableView *tableView,NSInteger currentPage);

/**
 *  上拉刷新
 */
@property (nonatomic, copy) FooterRefreshBlock footerRefreshBlock; //请求成功后返回YES，当前页才加一

/*******************************
 *  上拉刷新结果 回传结果.
 *  如果下拉刷新失败,把当前页计数减一
 *******************************/
@property (nonatomic, copy) ResultBlock returnBlock;


@property (nonatomic, assign,getter=isHideNoDataView) BOOL hideNoDataView;  /**< 是否隐藏错误图片 */
@property (nonatomic, assign, setter=setShowTopBtn:) BOOL isShowTopBtn;     /**< 是否显示置顶按钮(点击置顶按钮,列表滚至顶部) */
@property (nonatomic, copy) void (^completeBlock)(UIButton *);              /**< 列表滚至顶部后的回调(点击置顶按钮后，若需做列表置顶后的操作则赋值) */
@property (nonatomic, assign) BOOL isShowNoMoreView;                     /**< 是否展示没有更多的数据view*/

/**
 *  停止上拉下拉刷新
 */
- (void)customTableViewStopRefresh;

/**
 *  停止下拉刷新
 */
- (void)customTableViewStopHeaderRefresh;

/**
 *  停止上拉刷新
 */
- (void)customTableViewStopFooterRefresh;

- (void)headerBeginRefresh;
/**
 *  没有更多数据...
 *  处理有无更多数据的view展示
 *  @param noMoreTips 无更多数据文字提示
 */
- (void)hanleTbvNoMoreDataView:(NSString *)noMoreTips;
/**
 * 隐藏没有更多数据的view
 */
- (void)hideNoMoreDataView;

@end

@interface CCTableViewMoreView : UIView
/**
 * 开始动画
 */
- (void)startImageAnimation;
/**
 * 结束动画
 */
- (void)stopImageAnimation;

@end
 
