//
//  CCCustomPlaceholderTextView.h
//  TestViewDemo
//
//  Created by huangshupeng on 16/7/17.
//  Copyright © 2016年 huangshupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCCustomPlaceholderTextView;

typedef void(^TextViewHeightChangeBlock)(CCCustomPlaceholderTextView *textView);

@interface CCCustomPlaceholderTextView : UITextView

@property (nonatomic,copy) NSString *placeholder;           /**< 提示文字  */
@property (nonatomic,strong) UIColor *placeholderColor;     /**< 提示文字的颜色  */
@property (nonatomic,strong) UIFont *placeholderFont;       /**< 提示文字的字体大小 */
@property (nonatomic,assign) NSInteger maxLength;           /**< 最大的长度  0 不限制 */
@property (nonatomic,assign,getter=isMaskText) BOOL maskText;                 /**< textView是否适应文字的高度  默认为no */
@property (nonatomic,assign) CGFloat defaultHeight;         /**< 默认的高度 只有 maskText 为yes才有效 字的高度还没达到defaultHeight 则取这值为self的高度*/
@property (nonatomic,copy) TextViewHeightChangeBlock textHeightChangeBlock; 
@end
