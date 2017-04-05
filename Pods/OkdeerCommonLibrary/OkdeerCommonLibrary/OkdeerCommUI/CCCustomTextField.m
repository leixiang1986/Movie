//
//  LxTextField.m
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import "CCCustomTextField.h"
#import "UIHeader.h"

@implementation CCCustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.isSelectAll = NO;
        self.isCopy = YES;
        self.isCut = YES;
        self.isPaste = YES;
        self.isDelete = NO;
        self.isSelect = YES;
    }
    return self;
}


/**
 *  禁止复制粘贴等功能
 */
-(void)banAllCopyAndSelect
{
    self.isSelectAll = NO;
    self.isCopy = NO;
    self.isCut = NO;
    self.isPaste = NO;
    self.isDelete = NO;
    self.isSelect = NO;
}


/**
 *  初始化
 *
 *  @param frame     frame
 *  @param fontSize  字体大小
 *  @param HEXString 颜色
 *  @param style     外形风格
 *
 *  @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor borderStyle:(UITextBorderStyle)style{
    self = [self initWithFrame:frame withFontSize:fontSize withTextColor:textColor borderStyle:style placeHolder:nil];
    return self;
}

/**
 *  初始化
 *
 *  @param frame     frame
 *  @param fontSize  字体大小
 *  @param HEXString 颜色
 *  @param style     外形风格
 *  @param placeHolder     默认值
 *
 *  @return 实例
 */
-(instancetype)initWithFrame:(CGRect)frame withFontSize:(CGFloat)fontSize withTextColor:(UIColor *)textColor borderStyle:(UITextBorderStyle)style placeHolder:(NSString *)placeHolder{
    self = [self initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:fontSize];
        self.textColor = textColor;
        self.borderStyle = style;
        self.placeholder = placeHolder;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    //处理光标, 关闭按钮遮盖问题.
    if (self.clearButtonMode == UITextFieldViewModeWhileEditing) {
        return CGRectMake(bounds.origin.x + 5.0f, bounds.origin.y , bounds.size.width - 25.f, bounds.size.height);
    }
    else {
        return CGRectMake(bounds.origin.x + 5.0f, bounds.origin.y , bounds.size.width - 5.f, bounds.size.height);
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    //处理光标, 关闭按钮遮盖问题.
    if (self.clearButtonMode == UITextFieldViewModeWhileEditing) {
        return CGRectMake(bounds.origin.x + 5.0f, bounds.origin.y , bounds.size.width - 25.f, bounds.size.height);
    }
    else {
        return CGRectMake(bounds.origin.x + 5.0f, bounds.origin.y , bounds.size.width - 5.f, bounds.size.height);
    }
}

/**
 *  复写方法，确定是否可以粘贴，剪切，删除
 *
 *  @param action  action
 *  @param sender  sender
 *
 *  @return  BOOL
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if ([@"_showKeyboard:" isEqualToString:NSStringFromSelector(action)]) {
        return NO;
    }
    if (action == @selector(paste:)) {
        return self.isPaste;
    }
    else if (action == @selector(delete:)){
//        return self.isDelete;
        return NO;
        
    }else if (action == @selector(cut:)){
        return self.isCut;
    }
    else if (action == @selector(copy:)){
        return self.isCopy;
    }
    else if (action == @selector(selectAll:)){
//        return self.isSelectAll;
        return NO;
    }
    else if (action == @selector(select:)){
        return self.isSelect;
    }
    else{
//        [super canPerformAction:action withSender:sender];
        return NO;
    }
    
}

/**
 *  设置 多种颜色字体显示  多种字体大小显示
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright{
    
    if (self.text.length > 0 ) {
        NSMutableAttributedString *mutabPriceName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.text]];
      
        if (self.attributedText.length != 0) {
            [mutabPriceName deleteCharactersInRange:NSMakeRange(0, self.text.length)];
            [mutabPriceName appendAttributedString:self.attributedText];
        }
        NSRange rang = [self.text rangeOfString:equalString];
        if (rang.location != NSNotFound) {
            if (isright) {
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentRight;//设置对齐方式
                
                [mutabPriceName setAttributes:@{NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.text.length)];
            }
            if (font) {
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:NSMakeRange(rang.location, self.text.length - rang.location)];
            }else{
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(rang.location, self.text.length - rang.location)];
            }
            
            self.attributedText = mutabPriceName ;
        }
        
    }
    
}
/**
 *  设置 多种颜色字体显示  多种字体大小显示  传的值有多长显多长的
 *
 *  @param color       颜色
 *  @param font        字体大小
 *  @param equalString 比较的文字
 *  @param isright     是否靠右
 */
- (void)setVariedWidthColor:(UIColor *)color font:(UIFont *)font equalString:(NSString *)equalString isalignmentRight:(BOOL )isright{
   
    if (self.text.length > 0 ) {
        NSMutableAttributedString *mutabPriceName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",self.text]];
        
        if (self.attributedText.length != 0) {
            [mutabPriceName deleteCharactersInRange:NSMakeRange(0, self.text.length)];
            [mutabPriceName appendAttributedString:self.attributedText];
        }
        NSRange rang = [self.text rangeOfString:equalString];
        if (rang.location != NSNotFound) {
            if (isright) {
                NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                paragraph.alignment = NSTextAlignmentRight;//设置对齐方式
                
                [mutabPriceName setAttributes:@{NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.text.length)];
            }
            if (font) {
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:NSMakeRange(rang.location, equalString.length)];
            }else{
                [mutabPriceName setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(rang.location, equalString.length)];
            }
            
            self.attributedText = mutabPriceName ;
        }
        
    }
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
