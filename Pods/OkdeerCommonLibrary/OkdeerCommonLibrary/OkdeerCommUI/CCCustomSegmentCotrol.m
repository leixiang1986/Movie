//
//  CCCustomSegmentCotrol.m
//  XIBScrollView
//
//  Created by Mac on 1/25/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "CCCustomSegmentCotrol.h"
#import "UIHeader.h"

@implementation CCCustomSegmentCotrol

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setImagesArr:(NSArray *)imagesArr{
    if (_imagesArr != imagesArr) {
        _imagesArr = imagesArr;
        CGFloat width = self.frame.size.width / imagesArr.count;
        CGFloat height = self.frame.size.height;
        for (NSInteger i = 0; i < imagesArr.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.tag = 10 + i;
            [btn setImage:imagesArr[i] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.frame = CGRectMake(i * width, 0, width, height);
            btn.titleLabel.font = [UIFont systemFontOfSize:14] ;
            [self addSubview:btn];
        }
    }
}

-(void)setTitleArr:(NSArray *)titleArr{
    if (_titleArr != titleArr) {
        _titleArr = titleArr;
        CGFloat width = self.frame.size.width / titleArr.count;
        CGFloat height = self.frame.size.height;
        for (NSInteger i = 0; i < titleArr.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.tag = 10 + i;
            [btn setTitle:titleArr[i] forState:(UIControlStateNormal)];
            btn.titleLabel.font = FONTDEFAULT(14);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.frame = CGRectMake(i * width, 0, width, height);
            [self addSubview:btn];
        }
    }
    
}


// 选中第几个按钮
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = (UIButton *)self.subviews[i];
        if (selectIndex == i) {
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:self.selectColor forState:(UIControlStateNormal)];
        }
        else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:self.unSelectColor forState:(UIControlStateNormal)];
        }
    }
}

// 设置选中按钮和边框颜色
-(void)setSelectColor:(UIColor *)selectColor{
    
    if (selectColor != _selectColor && selectColor) {
        _selectColor = selectColor;
        for (NSInteger i = 0; i < self.subviews.count; i ++) {
            UIButton *btn = (UIButton *)self.subviews[i];
            if (i == self.selectIndex) {
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:self.selectColor forState:(UIControlStateNormal)];
            }
            else {
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:self.unSelectColor forState:(UIControlStateNormal)];
            }
        }
    }
}

//
-(void)setUnSelectColor:(UIColor *)unSelectColor{
   
    if (unSelectColor != _unSelectColor && unSelectColor) {
         _unSelectColor = unSelectColor ;
        for (NSInteger i = 0; i < self.subviews.count; i ++) {
            UIButton *btn = (UIButton *)self.subviews[i];
            if (i != self.selectIndex) {
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:self.unSelectColor forState:(UIControlStateNormal)];
            }
            else{
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:self.selectColor forState:(UIControlStateNormal)];
            }
        }
    }
}


//
-(void)btnClick:(UIButton *)sender{
    self.selectIndex = sender.tag - 10;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:self.selectIndex];
    }
    else if (self.delegate && [self.delegate respondsToSelector:@selector(selectTitle:)]){
        NSString *title = sender.titleLabel.text;
        [self.delegate selectTitle:title];
    }
}


@end
