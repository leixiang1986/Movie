//
//  CCCycleScrollView.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CCCycleScrollView.h"
#import "CCSMPageControl.h"
@interface CCCycleScrollView () <UIScrollViewDelegate>


@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *afterView;

@end

@implementation CCCycleScrollView
#define PAGECOTROLHEIGHT 8


- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPagesCount = totalPagesCount;
    _totalPageCount = totalPagesCount ? totalPagesCount() : 0;
    self.pageControl.numberOfPages = _totalPageCount;
    _currentPageIndex = self.pageControl.currentPage = 0;
    if (_totalPageCount > 0) {
        [self configContentViews];
        if (!self.can_not_Scroll) {
            [self resumeTimerAfterTimeInterval:self.animationDuration];
        }
    }
}

//初始化方法
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction
{
    
    if (direction) {
        self.direction = direction;
    }
        self = [self initWithFrame:frame];
    
    
        if (animationDuration > 0.0) {
            self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                                   target:self
                                                                 selector:@selector(animationTimerDidFired:)
                                                                 userInfo:nil
                                                                  repeats:YES];
            [self pauseTimer];
        }
  
    [self bringSubviewToFront:self.pageControl];
    return self;
}



//设置方法
- (void)setWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction{
    self.frame = frame;
    [self setupUI];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self pauseTimer];
    }
    self.direction = direction;
}
#pragma mark - //****************** 定时器 ******************//
-(void)pauseTimer
{
    if (![self.animationTimer isValid]) {
        return ;
    }
    [self.animationTimer setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self.animationTimer isValid]) {
        return ;
    }
    [self.animationTimer setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self.animationTimer isValid]) {
        return ;
    }
    [self.animationTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

-(id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction withPage:(CCSMPageControl *)pageControl{
    self = [self initWithFrame:frame animationDuration:animationDuration direction:direction];
    if (pageControl) {
        self.pageControl = pageControl;
        self.pageControl.frame = CGRectMake(0, self.frame.size.height - pageControl.frame.size.height, self.frame.size.width, pageControl.frame.size.height);
        self.pageControl.indicatorMargin = 3.0f;
        self.pageControl.indicatorDiameter = 8.0f;

        [self addSubview:self.pageControl];
    }
    return self;
}

//设置方法
- (void)setWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration direction:(ScroDirection)direction withPage:(CCSMPageControl *)pageControl{
    [self setWithFrame:frame animationDuration:animationDuration direction:direction];
    if (pageControl) {
        self.pageControl = pageControl;
        self.pageControl.frame = CGRectMake(0, self.frame.size.height - pageControl.frame.size.height, self.frame.size.width, pageControl.frame.size.height);
        self.pageControl.indicatorMargin = 3.0f;
        self.pageControl.indicatorDiameter = 8.0f;
        [self addSubview:self.pageControl];
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupUI];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.autoresizesSubviews = YES;
    [self scrollView];
    if (self.direction == Horizontal) {
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    }else if (self.direction == Vertical){
        self.scrollView.contentSize = CGSizeMake( CGRectGetWidth(self.scrollView.frame),3 * CGRectGetHeight(self.scrollView.frame));
        self.scrollView.contentOffset = CGPointMake( 0, CGRectGetHeight(self.scrollView.frame));
    }
    _currentPageIndex = 0;
}

- (UIScrollView *)scrollView {
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.autoresizingMask = 0xFF;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentMode = UIViewContentModeCenter;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
    }
    _scrollView.frame = self.bounds;
    return _scrollView;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        if (self.TapActionBlock) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
            [contentView addGestureRecognizer:tapGesture];
        }
        CGRect rightRect = contentView.frame;
        
        if (self.direction == Vertical) {
            rightRect.origin = CGPointMake( 0, CGRectGetHeight(self.scrollView.frame) * (counter ++));
        }
        else if (self.direction == Horizontal){
            rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        }
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
        self.afterView = contentView;
    }
    if (self.direction == Vertical) {
        [_scrollView setContentOffset:CGPointMake(0, _scrollView.frame.size.height)];
    }
    else if (self.direction == Horizontal){
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    
    }
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        if (_totalPageCount > 0) {          //避免_totalPageCount为0时的报错
            if (previousPageIndex < _totalPageCount) {
                [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
            }
            if (_currentPageIndex < _totalPageCount) {
                [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
            }
            if (rearPageIndex < _totalPageCount) {
                [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
            }
        }
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex < 0) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex >= self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.direction == Vertical) {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        if(contentOffsetY >= (2 * CGRectGetHeight(scrollView.frame))) {
            _currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            self.pageControl.currentPage = self.currentPageIndex;
            [self configContentViews];
        }
        if(contentOffsetY <= 0) {
            _currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            self.pageControl.currentPage = self.currentPageIndex;
            [self configContentViews];
        }
    }
    else if (self.direction == Horizontal){
        
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
            _currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
            self.pageControl.currentPage = self.currentPageIndex;
            [self configContentViews];
        }
        if(contentOffsetX <= 0) {
            _currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
            self.pageControl.currentPage = self.currentPageIndex;
            [self configContentViews];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.direction == Vertical) {
        [scrollView setContentOffset:CGPointMake( 0, CGRectGetHeight(scrollView.frame)) animated:YES];
    }
    else if (self.direction == Horizontal){
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
    }
    
}

#pragma mark -
#pragma mark - 响应事件
//定时器执行方法
- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset;
    if (self.direction == Vertical) {
        
        newOffset = CGPointMake(self.scrollView.contentOffset.x , self.scrollView.contentOffset.y + CGRectGetHeight(self.scrollView.frame));
        if ((NSInteger)newOffset.y % (NSInteger)self.scrollView.frame.size.height == 0) {
            [self.scrollView setContentOffset:newOffset animated:YES];
        }else{
            self.scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(self.scrollView.frame));
        }
    }
    else if (self.direction == Horizontal){
       
        newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
        if ((NSInteger)newOffset.x % (NSInteger)(self.scrollView.frame.size.width)== 0) {
            [self.scrollView setContentOffset:newOffset animated:YES];
        }else{
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        }
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        if (self.totalPageCount == 1) { /**<  在只有一条数据时，self.currentPageIndex可能大于0 */
            self.TapActionBlock(0);
        }
        else {
            self.TapActionBlock(self.currentPageIndex);
        }
    }
}

- (void)free
{
    if (self.animationTimer) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.direction == Horizontal) {
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        
    }else if (self.direction == Vertical){
        self.scrollView.contentSize = CGSizeMake( CGRectGetWidth(self.scrollView.frame),3 * CGRectGetHeight(self.scrollView.frame));
    }

}

//是否可以滚动，如广告要求一张图片时不滚动，多张时可以滚动
-(void)setCan_not_Scroll:(BOOL)can_not_Scroll{
    _can_not_Scroll = can_not_Scroll;
    if (can_not_Scroll) {
        if (self.animationTimer) {
            [self pauseTimer];
        }
        self.scrollView.scrollEnabled = NO;
    }
    else{
        if (self.animationTimer) {
            [self resumeTimer];
        }
        self.scrollView.scrollEnabled = YES;
    }
}


-(void)dealloc{
    
}

@end
