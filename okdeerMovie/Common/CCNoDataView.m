//
//  CCNoDataView.m
//  OkdeerUser
//
//  Created by Mac on 16/9/9.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCNoDataView.h"

#define kImageW         100    // 图片的宽度
#define kImageH         100    // 图片的高度
#define kTopSpace       12     // 图片与文字之间的间距
#define kFont           14     // 字体大小
#define kLabelH         (kFont + 6)
#define kTagNoDataView              1000000000      //没有数据的view的tag 1 000 000 000

@interface CCNoDataView ()

@property (nonatomic,strong) UIImageView *noDataImageView;          /**< 显示没有数据的图片*/
@property (nonatomic,strong) UILabel *noDataLabel;                  /**< 显示没有数据上的文字*/

@end

@implementation CCNoDataView

/**
 *  加载错误的页面上的数据
 *
 *  @param text  文字
 *  @param image 图片
 */
- (void)loadText:(NSString *)text image:(UIImage *)image{
    self.noDataImageView.image = image;
    self.noDataLabel.text = text;
}

/**
 * 获取最底部的UIView
 */
- (UIView *)obtainBottomView{
    return  self.noDataLabel; 
}
+ (instancetype)initWithText:(NSString *)text image:(UIImage *)image inSuperView:(UIView *)superView show:(BOOL)show{
    CCNoDataView *noDataView = nil;
    if (superView) {
        noDataView = [superView viewWithTag:kTagNoDataView];
        if (!noDataView) {
            noDataView = [[CCNoDataView alloc] init];
            noDataView.tag = kTagNoDataView;
            [superView addSubview:noDataView];
            [self addConstraintToView:noDataView superView:superView];
        }
        noDataView.backgroundColor = [UIColor whiteColor]; 
        [noDataView.superview bringSubviewToFront:noDataView];
        [noDataView loadText:text image:image];
        noDataView.hidden= !show;
    }
    
    return noDataView;
}
/**
 * 添加约束到view 中
 */
+ (void)addConstraintToView:(UIView *)view superView:(UIView *)superView{
    if (iOS8UP) {
        view.translatesAutoresizingMaskIntoConstraints = false;
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    }else{
        view.frame = superView.bounds;
    }

}


+ (instancetype)showWithDefaultInSuperView:(UIView *)superView show:(BOOL)show{
    CCNoDataView *noDataView = [CCNoDataView initWithText:@"暂无相关数据" image: kShareImgInNoData(@"nodata_nodata@2x") inSuperView:superView show:show];
    return noDataView;
}

/**
 *  隐藏
 */
-(void)hide {
    self.hidden = YES;
}


#pragma mark - //****************** getter ******************//
- (UIImageView *)noDataImageView{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] init];
        [self addSubview:_noDataImageView];
        [self addConstraintInImageView];
    }
    return _noDataImageView;
}

- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.font = [UIFont systemFontOfSize:kFont];
        _noDataLabel.textColor = UIColorFromHex(COLOR_666666);
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_noDataLabel];
        [self addConstraintInLabel];
    }
    return _noDataLabel;
}
/**
 *  为imageView 添加约束
 */
- (void)addConstraintInImageView{
    _noDataImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kImageW]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kImageH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_noDataImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:kLabelH + kTopSpace ]];
}
/**
 *  为label 添加约束
 */
- (void)addConstraintInLabel{
    _noDataLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kLabelH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_noDataLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.noDataImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kTopSpace]];
  
}


@end
