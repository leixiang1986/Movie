//
//  CCCustomTableView.m
//  CloudCity
//
//  Created by 雷祥 on 15/4/10.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import "CCCustomTableView.h"
#import "MJRefresh.h"
#import "CCCustomAlertView.h"
#import "UIHeader.h"
#import <objc/runtime.h>
#import "OkdeerRefreshGifHeader.h"
#import "OkdeerCommUIHeader.h"

#define kTopBtnWidth 45
#define kTopBtnHeight 45
#define kTopBtnRight 12
#define kTopBtnBottom 60

#define kObservingKey @"contentOffset"
#define kObservingContext @"topBtn"
#define kShowTopKeyValue 2


@interface CCCustomTableView ()

@property (nonatomic,weak) MJRefreshBackNormalFooter *footerView;       /**<  */

@property (strong, nonatomic) UIView *noMoreDataView;           /**< 无更多数据view */
@property (strong, nonatomic) UILabel *noMoreDataLbl;       /**< 无更多数据label */
@property (nonatomic, strong) UIButton *topBtn;             /**< 列表的置顶btn */
@property (nonatomic, assign) BOOL isKVO;                   /**< 是否添加了kvo */
@property (nonatomic,strong) CCTableViewMoreView *moreView;     /**< 更多的*/
@end

@implementation CCCustomTableView

#pragma mark - /*** 生命周期 ***/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)dealloc
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    self.mj_header = nil;
    self.mj_footer = nil;
    
    //清除相关block
    if (_returnBlock) {
        _returnBlock = nil;
    }
    if (_headerRefereshBlock) {
        _headerRefereshBlock = nil;
    }
    if (_footerRefreshBlock) {
        _footerRefreshBlock = nil;
    }
    if (_headerGifRefreshBlock) {
        _headerGifRefreshBlock = nil;
    }
    
    [self removeKVO];
    [_topBtn removeFromSuperview];
    _topBtn = nil;
    [_moreView removeFromSuperview];
    _moreView = nil;
}

#pragma mark - /*** 事件处理 ***/
//--- 普通正常的下拉刷新block
-(void)setHeaderRefereshBlock:(void (^)(CCCustomTableView *,NSInteger))headerRefereshBlock {
    _headerRefereshBlock = headerRefereshBlock;
    if (headerRefereshBlock) {
        __weak typeof(self) weakSelf = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{    //下拉刷新
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf customTableViewStopFooterRefresh];
                [strongSelf headerRefreshing];
            }
        }];
    }
    else {
        self.mj_header = nil;
    }
}

//--- 自定义下拉刷新block
- (void)setHeaderGifRefreshBlock:(void (^)(CCCustomTableView *, NSInteger))headerGifRefreshBlock
{
    _headerGifRefreshBlock = headerGifRefreshBlock;
    if (headerGifRefreshBlock) {
        __weak typeof(self) weakSelf = self;
        self.mj_header = [OkdeerRefreshGifHeader headerWithRefreshingBlock:^{    //下拉刷新
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf customTableViewStopFooterRefresh];
                [strongSelf headerRefreshing];
            }
        }];
    }
    else {
        self.mj_header = nil;
    }
}

//--- 上拉加载
-(void)setFooterRefreshBlock:(FooterRefreshBlock)footerRefreshBlock {
    _footerRefreshBlock = footerRefreshBlock;
    if (_footerRefreshBlock) {
         __weak typeof(self) weakSelf = self; //外部设置了block，才添加上拉加载功能
        MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{ //上拉加载更多
             __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf customTableViewStopHeaderRefresh];
                [strongSelf footerRefreshingWithResult:^(BOOL result) { //上拉加载之行的事件，调用自定义的方法－>调用设置的footerRefreshBlock
                    if (!result) {
                        strongSelf.currentPage --;
                    }
                    [strongSelf customTableViewStopFooterRefresh];
                }];
            }
        }];
        self.mj_footer = footerView;
        _footerView = footerView;
    }else{
        self.mj_footer = nil; 
    }
}

-(void)headerRefreshing{
    self.currentPage = 1;
    /**********************************************
     *  下拉刷新时,把上拉刷新加载进去..
     *  是为了解决在暂无数据页面,下拉刷新有数据之后的情况..
     *  modify by chenzl, fix me ^_^
     **********************************************/
    if (!self.mj_footer) {
        self.mj_footer = self.footerView;
    }
    //有展示更多数据的问题..
    if (self.tableFooterView) {
        [self hideNoMoreDataView];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
    }
    //block
    if (self.headerRefereshBlock) {
        self.headerRefereshBlock(self,self.currentPage);
    }
    //block
    if (self.headerGifRefreshBlock) {
        self.headerGifRefreshBlock(self, self.currentPage);
    }
}

-(void)footerRefreshingWithResult:(ResultBlock)resultBlock{

    _returnBlock = resultBlock;
    _currentPage++;
    if (self.currentPage <= self.totalPage) {
        if (self.footerRefreshBlock) {
            self.footerRefreshBlock(self,self.currentPage, resultBlock);
        }
    }
    else {
        _currentPage -- ;
        [self.footerView setTitle:_lastPageMessage forState:(MJRefreshStateRefreshing)];
        self.footerView.loadingView.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.mj_footer isRefreshing]) {
                [self.mj_footer endRefreshing];
                [self.footerView setTitle:MJRefreshBackFooterRefreshingText forState:(MJRefreshStateRefreshing)];
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.footerView.loadingView.hidden = NO;
        });
    }
}

/**
 *  停止上下拉刷新
 */
- (void)customTableViewStopRefresh
{
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
}

/**
 *  停止下拉刷新
 */
- (void)customTableViewStopHeaderRefresh {

    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
}

/**
 *  停止上拉刷新
 */
- (void)customTableViewStopFooterRefresh {
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)headerBeginRefresh
{
    if (![self.mj_header isRefreshing]) {
        [self.mj_header beginRefreshing];
    }
}

- (void)setHideNoDataView:(BOOL)hideNoDataView
{
    _hideNoDataView = hideNoDataView;
    [self obtainNoDataView];
}
 

/**
 *  没有更多数据...
 *  处理有无更多数据的view展示
 *  @param noMoreTips 无更多数据文字提示
 */
- (void)hanleTbvNoMoreDataView:(NSString *)noMoreTips
{
    /**
     *  处理流程
     *  如果是暂无数据,就展示暂无数据, 可以用self.mj_footer来判断
     *  如果是当前页超过后台的页数就展示无更多数据...
     */
    if (!self.mj_footer) {
        return ;
    }
    // 不需要展示没有更多数据的view return
    if (!self.isShowNoMoreView) {
        return;
    }
    
    //没有更多数据...
    if (self.currentPage >= self.totalPage) {
        [self customTableViewStopFooterRefresh];
        self.mj_footer = nil;
        [self.tableFooterView removeFromSuperview];
        self.moreView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 58);
        self.tableFooterView = self.moreView;
        self.moreView.hidden = NO;
        [self.moreView startImageAnimation];
        [self reloadData];
    }
    else {
        [self hideNoMoreDataView];
        //有展示更多数据的问题..
        if (self.tableFooterView) {
            self.tableFooterView = [UIView new];
        }
    }
}
/**
 * 隐藏没有更多数据的view
 */
- (void)hideNoMoreDataView{
    [_moreView stopImageAnimation];
    _moreView.hidden = YES;
    if (!self.mj_footer) {
        self.mj_footer = self.footerView;
    }
}
- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    if (_currentPage <= 1 ) {
        [self setDefaultTotTalPage];
    }
    [self hanleTbvNoMoreDataView:@"没有更多的数据"];
}

- (void)setTotalPage:(NSInteger)totalPage{
    _totalPage = totalPage;
    
    [self hanleTbvNoMoreDataView:@"没有更多的数据"];
  
}

- (void)setShowTopBtn:(BOOL)isShowTopBtn {
    _isShowTopBtn = isShowTopBtn;
    if (_isShowTopBtn){
        self.topBtn.hidden = NO;
        [self addKVO];
    }else {
        [self removeKVO];
        if (_topBtn){
            _topBtn.hidden = YES;
        }
    }
}

-(UIButton *)topBtn {
    if (!_topBtn){
        _topBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kTopBtnWidth, kTopBtnHeight)];
     
//        _topBtn.layer.cornerRadius = kTopBtnHeight *0.5;
//        _topBtn.layer.masksToBounds = YES;
        [_topBtn addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTopBtn:)];
        [_topBtn setImage:[self imagefrombundle:@"MJRefresh" inDirectory:@"Image" fileName:@"TableView_top"] forState:UIControlStateNormal];
        [_topBtn addGestureRecognizer:panGes];
    }
    return _topBtn;
}
//获取到图片
- (UIImage *)imagefrombundle:(NSString *)bundleName inDirectory:(NSString *)inDirectory fileName:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
    //没有找到bundle
    if (!bundle) {
        if (imageName.length) {
            return [UIImage imageNamed:imageName];
        }
        return nil;
    }
    
    UIImage *image = nil;
    
    NSString *imageBundleName = [NSString stringWithFormat:@"%@.bundle%@/%@",bundleName,(inDirectory.length > 0 ? [NSString stringWithFormat:@"/%@",inDirectory] : @""),imageName];
    if (imageBundleName.length){
        //NSLog(@"imagebundle..%@", imageBundleName);
        image = [UIImage imageNamed:imageBundleName];
        //image = [UIImage imageWithContentsOfFile:imageBundleName];
    }
    
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:inDirectory];
    if (!image){
        //NSLog(@"imagepath..");
        //图片路径是nil
        if (!imagePath.length) {
            if (imageName.length) {
                image = [UIImage imageNamed:imageName];
            }
        }
    }
    if(!image){
        image = [UIImage imageNamed:imagePath];
    }
    return image;
}
- (void)addTopBtnToSuperView {
    if (!self.topBtn.superview) {
        [self.superview addSubview:self.topBtn];
        [self changeTopBtnCenter];
    }
}

- (void)changeTopBtnCenter{
    self.topBtn.center = CGPointMake(self.superview.frame.size.width-kTopBtnRight-kTopBtnWidth*0.5, self.superview.frame.size.height - kTopBtnBottom-kTopBtnHeight*0.5);
}

- (void)addKVO {
    if (!self.isKVO){
        [self addObserver:self forKeyPath:kObservingKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:kObservingContext];
        self.isKVO = YES;
    }
}

- (void)removeKVO {
    if (self.isKVO){
        [self removeObserver:self forKeyPath:kObservingKey context:kObservingContext];
        self.isKVO = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self addTopBtnToSuperView]; // 添加topBtn于table的父视图中
    if ([keyPath isEqualToString:kObservingKey] && context == kObservingContext){
        static CGPoint point;
        point = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (point.y >= self.frame.size.height * kShowTopKeyValue){
            self.topBtn.hidden = NO;
        }else {
            self.topBtn.hidden = YES;
            if (point.y == 0){  // 处理已滑至顶部或点击statusBar滑到顶部
                self.topBtn.center = CGPointMake(self.superview.frame.size.width-kTopBtnRight-kTopBtnWidth*0.5, self.superview.frame.size.height - kTopBtnBottom-kTopBtnHeight*0.5);
            }
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)scrollToTop {
    
    [self scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.55 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.topBtn.hidden = YES;
        self.topBtn.center = CGPointMake(self.superview.frame.size.width-kTopBtnRight-kTopBtnWidth*0.5, self.superview.frame.size.height - kTopBtnBottom-kTopBtnHeight*0.5);
        if (_completeBlock){
            _completeBlock(self.topBtn);
        }
    });
}

- (void)panTopBtn:(UIPanGestureRecognizer *)ges {
    CGPoint point = [ges locationInView:self.superview];
    
    [UIView animateWithDuration:1.05 delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.topBtn.center = point;
    } completion:nil];
}

#pragma mark - /*** 初始化UI ***/
/**
 *  初始化设置
 */
-(void)initViews
{
    _currentPage = 1;
    _isLastPage = YES;
    _lastPageMessage = @"最后一页";
    [self setDefaultTotTalPage];
    self.mj_header.backgroundColor = [UIColor clearColor];
    self.mj_footer.backgroundColor = [UIColor clearColor];
    _hideNoDataView = YES;
    self.showsVerticalScrollIndicator = NO;
}
/**
 * 设置默认的总页数
 */
- (void)setDefaultTotTalPage{
    _totalPage = 1000;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
}
- (void)setNoDataView:(UIView *)noDataView{
    _noDataView = noDataView;
//    if (!_noDataView.superview) {
//         [self addSubview:_noDataView];
//    }
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self changeTopBtnCenter];
}
/**
 *  为没有数据赋值
 */
- (void)obtainNoDataView
{
    _noDataView.hidden = self.isHideNoDataView;
}

#pragma mark - /*** 没有更多数据 ***/
- (UIView *)noMoreDataView
{
    if (!_noMoreDataView) {
        _noMoreDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIFullWidth , 44)];
        _noMoreDataView.backgroundColor = UIColorFromHex(0xF5F6F8);
        
        _noMoreDataLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kUIFullWidth, 44)];
        _noMoreDataLbl.font = FONTDEFAULT(14);
        _noMoreDataLbl.textColor = UIColorFromHex(0x333333);
        _noMoreDataLbl.textAlignment = NSTextAlignmentCenter;
        _noMoreDataLbl.center = _noMoreDataView.center;
        [_noMoreDataView addSubview:_noMoreDataLbl];
    }
    return _noMoreDataView;
}

- (CCTableViewMoreView *)moreView{
    if (!_moreView) {
        _moreView = [[CCTableViewMoreView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 58)];
    }
    return _moreView;
}

@end

@interface CCTableViewMoreView ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation CCTableViewMoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageView];
        [self titleLabel];
    }
    return self;
}
/**
 * 开始动画
 */
- (void)startImageAnimation{
    if (![self.imageView isAnimating]) {
        NSLog(@"startImageAnimation");
        [self.imageView startAnimating];
    }
}
/**
 * 结束动画
 */
- (void)stopImageAnimation{
    if ([self.imageView isAnimating]) {
        [self.imageView stopAnimating];
    }
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 8; i ++ ) {
            NSString *imageName = [NSString stringWithFormat:@"TableViewMore0%zd",i];
            if (imageName.length) {
                UIImage *image = [self imagefrombundle:@"MJRefresh" inDirectory:@"Image" fileName:imageName];
                if (image)[imageArray addObject:image];
            }
        }
        _imageView.animationImages = imageArray;
        _imageView.animationDuration = 14/30.0f;
        [self addSubview:_imageView];
        [self addConstraintToImageView];
    }
    return _imageView;
}

- (void)addConstraintToImageView{
    _imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-20]];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"到底啦~~~";
        _titleLabel.font = [UIFont systemFontOfSize:12]; 
        [self addSubview:_titleLabel];
        [self addConstraintToTitleLabel];
    }
    return _titleLabel;
}

- (void)addConstraintToTitleLabel{
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-8]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:13]];
}
//获取到图片
- (UIImage *)imagefrombundle:(NSString *)bundleName inDirectory:(NSString *)inDirectory fileName:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
    //没有找到bundle
    if (!bundle) {
        if (imageName.length) {
            return [UIImage imageNamed:imageName];
        }
        return nil;
    }
    
    UIImage *image = nil;
    
    NSString *imageBundleName = [NSString stringWithFormat:@"%@.bundle%@/%@",bundleName,(inDirectory.length > 0 ? [NSString stringWithFormat:@"/%@",inDirectory] : @""),imageName];
    if (imageBundleName.length){
        //NSLog(@"imagebundle..%@", imageBundleName);
        image = [UIImage imageNamed:imageBundleName];
        //image = [UIImage imageWithContentsOfFile:imageBundleName];
    }
    
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png" inDirectory:inDirectory];
    if (!image){
        //NSLog(@"imagepath..");
        //图片路径是nil
        if (!imagePath.length) {
            if (imageName.length) {
                image = [UIImage imageNamed:imageName];
            }
        }
    }
    if(!image){
        image = [UIImage imageNamed:imagePath];
    }
    return image;
}

- (void)dealloc{
    [self stopImageAnimation];
    [_imageView removeFromSuperview];
    _imageView = nil;
    [_titleLabel removeFromSuperview];
    _titleLabel = nil;
}

@end
