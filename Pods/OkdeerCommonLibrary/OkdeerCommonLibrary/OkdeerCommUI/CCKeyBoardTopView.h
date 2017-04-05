//
//  CCKeyBoardTopView.h
//  CloudCity
//
//  Created by 雷祥 on 16/3/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(void);
@interface CCKeyBoardTopView : UIView

/**
 *  初始化
 *
 *  @param finishBlock 点击完成的block
 *  @param cancelBlock 点击取消的block
 *
 *  @return 返回实例
 */
-(instancetype)initWithFinishBlock:(ClickBlock)finishBlock
                   withCancelBlock:(ClickBlock)cancelBlock;

@end
