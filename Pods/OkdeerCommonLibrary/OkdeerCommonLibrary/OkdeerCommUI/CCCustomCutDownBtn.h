//
//  CCCustomCutDownBtn.h
//  CloudCity
//
//  Created by 雷祥 on 16/2/19.
//  Copyright © 2016年 Mac. All rights reserved.
//

/**
 *  倒计时的按钮
 */
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CCCustomCutDownBtnType) {
    CCCustomCutDownBtnTypeDefault = 0,
    CCCustomCutDownBtnTypeEdge    = 1
};

typedef void(^CompleteBlock)(BOOL ret);

@protocol CCCustomCutDownBtnProtocol <NSObject>

/**
 *  点击事件的代理方法
 *
 *  @param sender        发送事件的控件－－具体实例
 *  @param completeBlock 发送是否成功的回调，根据回调的成功失败设置相应的状态
 */
- (void)sendWithSender:(id)sender complete:(CompleteBlock)completeBlock;

@end

@interface CCCustomCutDownBtn : UIButton
@property (nonatomic,assign) NSInteger totalTime;                   /**< 默认60秒 */
@property (nonatomic,assign,readonly) NSInteger currentTime;        /**< 当前剩余的时间 */
@property (nonatomic,assign,readonly) BOOL isCutDowning;            /**< 正在倒计时 */
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *disableColor;
@property (nonatomic,weak) id<CCCustomCutDownBtnProtocol>delegate;
@property (nonatomic,assign) CCCustomCutDownBtnType type;

/**
 *  开始倒计时
 */
- (void)startCutDown;

/**
 *  在使用本类的类调用dealloc时，调用
 */
- (void)invalidateTimer;

@end
