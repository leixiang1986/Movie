//
//  LxTextView.h
//  公共类
//
//  Created by 雷祥 on 14-11-4.
//  Copyright (c) 2014年 雷祥. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CCCustomTextView : UITextView
//在initWithFrame：方法中设置了背景色为透明，无需再设置

@property (nonatomic,assign) BOOL isPaste;      //允许粘贴
@property (nonatomic,assign) BOOL isDelete;     //允许选中删除
@property (nonatomic,assign) BOOL isCut;        //允许剪切
@property (nonatomic,assign) BOOL isSelectAll;  //允许全选
@property (nonatomic,assign) BOOL isSelect;     //选择功能
@property (nonatomic,assign) BOOL isCopy;  //允许复制

@property (nonatomic, copy)void(^textViewClickSelectAllBlock)(void);

/**
 *  注释 目前是 CCSurroundingConfirmShopView，CCOrderComplaintViewController，CCPostViewController
 *  三个用到placeholder属性. 现在新增一个placeholder文字显示区域的
 *  如果发现有问题, 及时联系我 by chenzl. by 2016-1-6
 */

/**
 *  默认文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  默认文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;
/**
 *  默认文字字体
 */
@property (nonatomic, strong) UIFont *placeholderFont;
/**
 *  placeholder文字显示区域,目前支持左中右,其他的归为左
 */
@property (nonatomic, assign) NSTextAlignment placeAlignment;
@property (nonatomic, assign) CGFloat placeholderOriginX;    //起始位置
@end
