
//
//  CustomTitleAndContentTextView.m
//  CloudCity
//
//  Created by 雷祥 on 15/2/4.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import "CCCustomTitleAndContentTextView.h"
#import "CCCustomAlertView.h"
#import "UIHeader.h"

@implementation CCCustomTitleAndContentTextView{
    NSString *_title;
    NSString *_placeHolder;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[CCCustomLabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = FONTDEFAULT(15);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.textView = [[CCCustomTextView alloc] initWithFrame:CGRectMake(17, 0, frame.size.width - 40, frame.size.height)];
        self.textView.font = FONTDEFAULT(15);
        [self addSubview:self.titleLabel];
        self.textView.delegate = self;
        [self addSubview:self.textView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder{
    self = [self initWithFrame:frame];
    if (self) {
        _title = title;
        _placeHolder = placeHolder;
        self.titleLabel.text = title;
        self.titleLabel.text = [NSString stringWithFormat:@"%@%@",title,placeHolder];
        self.titleLabel.textColor = [UIColor clearColor];
        if (_placeHolder && _placeHolder.length > 0) {
            [self.titleLabel setVariedColor:UIColorFromHex(COLOR_E2E2E2) font:FONTDEFAULT(16) equalString:_placeHolder isalignmentRight:NO];
        }
        self.textView.text = [NSString stringWithFormat:@"%@",title];
    }
    return self;
}


-(void)layoutSubviews{
    CGSize size = CGSizeMake(self.width - 40, 20);
    CGSize titleSize = [self.titleLabel.text calculateheight:self.titleLabel.font andcontSize:size ];
    self.titleLabel.frame = CGRectMake(22, 9, titleSize.width + 10, titleSize.height);
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _titleLabel.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTitleAndContentTextViewBegin:)]) {
        return [self.delegate customTitleAndContentTextViewBegin:textView];
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([_title isEqualToString:textView.text]) {
        _titleLabel.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    NSRange textRange = [textView selectedRange];
    NSString *noEmoji = [NSString disable_emoji:textView.text] ;
    if (![noEmoji isEqualToString:textView.text]) {
        textView.text = noEmoji;
        
        [[CCCustomAlertView alloc] setAlertViewTitle:@"提示" andMessage:@"不能包含表情" cancelTitle:@"确定" andhideAlertViewTimeOut:0.5f];
        return ;
    }


    [textView setSelectedRange:textRange];
}



/**
 *  光标范围
 */
- (void)textViewDidChangeSelection:(UITextView *)textView{
    if (_title && _title.length > 0) {
        NSRange tempRange = [textView.text rangeOfString:_title];
        if (textView.selectedRange.location < tempRange.length) {
            textView.selectedRange = NSMakeRange(tempRange.length, 0);
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTitleAndContentTextViewDidChang:)]) {
        [self.delegate customTitleAndContentTextViewDidChang:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //光标在title后面
    if (range.location == _title.length - 1 && [text isEqualToString:@""]) {
        return NO;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTitleAndContentTextView:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate customTitleAndContentTextView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

@end

