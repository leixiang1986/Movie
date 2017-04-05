//
//  CCCustomVerticalScrollView.m
//  CloudCity
//
//  Created by 雷祥 on 15/2/28.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import "CCCustomVerticalScrollView.h"

@implementation CCCustomVerticalScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _animationTime = 3.0f;
        _scrollView = [[CCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) animationDuration:_animationTime direction:Vertical];
        [self addSubview:_scrollView];
    }
    return self;
}


/**
 *  复写左侧的view,重新设置frame
 *
 *  @param leftView  leftView
 */
-(void)setLeftView:(UIView *)leftView{
    if (leftView && _leftView.hidden == NO) {
        _leftView = nil;
        _leftView = leftView;
        if (_leftView.frame.size.width == 0 || _leftView.frame.size.height == 0) {
            CGFloat leftWidth = 0;
            if (self.frame.size.width > self.frame.size.height) {
                leftWidth = self.frame.size.height;
            }
            else{
                leftWidth = self.frame.size.width;
            }
            _leftView.frame = CGRectMake(0, 0, leftWidth, leftWidth);
            //重新设置scrollView的frame
            CGFloat rightWidth = 0;
            if (_rightView && _rightView.hidden == NO) {
                rightWidth = _rightView.frame.size.width;
            }
            _scrollView.frame = CGRectMake(_leftView.frame.size.width + _leftView.frame.origin.x + 2, 0, self.frame.size.width - leftWidth - rightWidth - 4, self.frame.size.height);
            [self addSubview:_leftView];
        }
        else{
            [self addSubview:_leftView];
            CGFloat leftWidth = 0;
            if (_leftView && _leftView.hidden == NO) {
                leftWidth = _leftView.frame.size.width;
            }
            CGFloat rightWidth = 0;
            if (_rightView && _rightView.hidden == NO) {
                rightWidth = _rightView.frame.size.width;
            }
            _scrollView.frame = CGRectMake(_leftView.frame.size.width + _leftView.frame.origin.x + 2, 0, self.frame.size.width - leftWidth - rightWidth - 4, self.frame.size.height);
        }
        
    }
    else{   //leftView不存在,即赋空
        CGFloat rightWidth = 0;
        if (_rightView && _rightView.hidden == NO) {
            rightWidth = _rightView.frame.size.width;
        }
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width - rightWidth - 2, self.frame.size.height);
    }
    [self setViewArr:_viewArr];
    
}

/**
 *  复写右侧的view,重新设置frame
 *
 *  @param rightView <#rightView description#>
 */
-(void)setRightView:(UIView *)rightView{
    if (rightView && _rightView.hidden == NO) {
        _rightView = nil;
        _rightView = rightView;
        if (_rightView.frame.size.width == 0 || _rightView.frame.size.height == 0) {
            CGFloat rightWidth = 0;
            if (self.frame.size.width > self.frame.size.height) {
                rightWidth = self.frame.size.height;
            }
            else{
                rightWidth = self.frame.size.width;
            }
            _rightView.frame = CGRectMake(0, 0, rightWidth, rightWidth);
            //重新设置scrollView的frame
            CGFloat leftWidth = 0;
            if (_leftView && _leftView.hidden == NO) {
                leftWidth = _leftView.frame.size.width;
            }
            _scrollView.frame = CGRectMake(_leftView.frame.size.width + _leftView.frame.origin.x + 2, 0, self.frame.size.width - leftWidth - rightWidth - 4, self.frame.size.height);
            [self addSubview:_rightView];
        }
        else{
            [self addSubview:_rightView];
            CGFloat leftWidth = 0;
            if (_leftView && _leftView.hidden == NO) {
                leftWidth = _leftView.frame.size.width;
            }
            CGFloat rightWidth = 0;
            if (_rightView && _rightView.hidden == NO) {
                rightWidth = _rightView.frame.size.width;
            }
            _scrollView.frame = CGRectMake(_leftView.frame.size.width + _leftView.frame.origin.x + 2, 0, self.frame.size.width - leftWidth - rightWidth - 4, self.frame.size.height);
            
        }
    }
    else{
        CGFloat leftWidth = 0;
        if (_leftView && _leftView.hidden == NO) {
            leftWidth = _leftView.frame.size.width;
        }
        _scrollView.frame = CGRectMake(leftWidth + 2, 0, self.frame.size.width - leftWidth - 2, self.frame.size.height);
    }
    [self setViewArr:_viewArr];
}


/**
 *  复写滚动的scrollView,重新设置frame
 */
-(void)setScrollView:(CCCycleScrollView *)scrollView{
    if (scrollView) {
        _scrollView = nil;
        _scrollView = scrollView;
        [self addSubview:_scrollView];
    }
}

/**
 *  动画时间
 */
-(void)setAnimationTime:(CGFloat)animationTime{
    if (animationTime > 0) {
        _animationTime = animationTime;
        _scrollView.animationDuration = animationTime;
    }
}

/**
 *  复写传入view数组
 */
-(void)setViewArr:(NSArray *)viewArr{
    if (viewArr) {
        if (viewArr.count > 0) {
            _viewArr = viewArr;
            CGRect frame = _scrollView.frame;
            _scrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){   //返回view
                if (viewArr.count > pageIndex) {
                    UIView *view = (UIView *)viewArr[pageIndex];
                    view.frame = frame;
                    return view;
                }
                else{
                    return nil;
                }
            };
            
            _scrollView.totalPagesCount = ^NSInteger(void){
                return viewArr.count;
            };
            
            __weak typeof(self) weakSelf = self;
            _scrollView.TapActionBlock = ^(NSInteger pageIndex){
                __strong typeof(self) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf scrollViewTap:pageIndex];
                }
            };
            
        }
    }
}

/**
 *  点击了第几个view,从0开始
 */
-(void)scrollViewTap:(NSInteger)index{
    if (self.tapIndex) {
        self.tapIndex(index);
    }
    
}

@end
