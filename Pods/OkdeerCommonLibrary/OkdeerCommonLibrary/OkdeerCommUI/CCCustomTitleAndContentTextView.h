//
//  CustomTitleAndContentTextView.h
//  CloudCity
//
//  Created by 雷祥 on 15/2/4.
//  Copyright (c) 2015年 聚光. All rights reserved.
//


#import "CCCustomLabel.h"
#import "CCCustomTextView.h"


@protocol CCCustomTitleAndContentTextViewDelegate <NSObject>
@optional
-(BOOL)customTitleAndContentTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
-(void)customTitleAndContentTextViewDidChang:(UITextView *)textView;
-(BOOL)customTitleAndContentTextViewBegin:(UITextView *)textView;

@end

@interface CCCustomTitleAndContentTextView : UIView<UITextViewDelegate>
@property (nonatomic,strong) CCCustomLabel *titleLabel;
@property (nonatomic,strong) CCCustomTextView *textView;
@property (nonatomic,weak) id<CCCustomTitleAndContentTextViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder;
@end

