//
//  LxImageView.m
//  CloudMall
//
//  Created by 雷祥 on 14-11-5.
//  Copyright (c) 2014年 JuGuang. All rights reserved.
//

#import "CCCustomImageView.h"
#import "UIHeader.h"
#import "CCBlurView.h"

@interface CCCustomImageView ()

@property (nonatomic, strong) CCBlurView *cloudBlurView;       /**< 蒙层*/

@end

@implementation CCCustomImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _changeColor = UIColorFromHex(COLOR_E2E2E2);
        _imageAlpha = 0.3f;
        _blendMode = kCGBlendModeLuminosity ;
    }
    return self;
}

- (CCBlurView *)cloudBlurView
{
    if (!_cloudBlurView) {
        _cloudBlurView = [[CCBlurView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _cloudBlurView.alpha = 0.7;
        _cloudBlurView.hidden = YES;
        [self addSubview:_cloudBlurView];
    }
    return _cloudBlurView;
}

- (void)setImage:(UIImage *)image{
    if (_isChangeColor) {
        image = [image imageWithTintColor:_changeColor blendMode:_blendMode alpha:_imageAlpha];
    }
    [super setImage:image];

}

- (void)setHideMongoliaLayer:(BOOL)hideMongoliaLayer
{
    _hideMongoliaLayer = hideMongoliaLayer;
    self.cloudBlurView.hidden = _hideMongoliaLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
