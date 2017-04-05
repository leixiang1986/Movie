//
//  CCKeyBoardTopView.m
//  CloudCity
//
//  Created by 雷祥 on 16/3/15.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCKeyBoardTopView.h"
#import "UIHeader.h"
#import "OkdeerCommUIHeader.h"
@interface CCKeyBoardTopView ()
@property (nonatomic,copy) ClickBlock finishBlock;  /**< 成功的block */
@property (nonatomic,copy) ClickBlock cancelBlock;  /**< 失败的block */
@end


@implementation CCKeyBoardTopView

/**
*  初始化
*
*  @param finishBlock 点击完成的block
*  @param cancelBlock 点击取消的block
*
*  @return 返回实例
*/
-(instancetype)initWithFinishBlock:(ClickBlock)finishBlock withCancelBlock:(ClickBlock)cancelBlock {
    CGRect frame = CGRectMake(0, 0, kUIFullWidth, 40);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xF9F9F9);
        _finishBlock = finishBlock;
        _cancelBlock = cancelBlock;

        CGFloat btnHeight = 25;
        CGFloat btnWidth = 50;
        CGFloat btnY = (frame.size.height - btnHeight) / 2;
        UIButton *cancelBtn = [self btnWithFrame:CGRectMake(10, btnY, btnWidth, btnHeight) withColor:UIColorFromHex(COLOR_CCCCCC) withTitle:@"取消"];
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];

        UIButton *finishBtn = [self btnWithFrame:CGRectMake(frame.size.width - 10 - btnWidth, btnY, btnWidth, btnHeight) withColor:UIColorFromHex(0x8CC63F) withTitle:@"完成"];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:finishBtn];
    }
    return self;
}

#pragma mark - /*** privite ***/
/**
 *  创建按钮
 *
 *  @param frame 位置
 *  @param color 文字及边框颜色
 *  @param title 标题
 *
 *  @return 按钮
 */
- (UIButton *)btnWithFrame:(CGRect)frame withColor:(UIColor *)color withTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = frame;
    [btn setCorneradius:btn.height / 2 withColor:color withBorderWidth:1 * 2];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    return btn;
}

/**
 *  取消的点击事件
 *
 *  @param sender sender
 */
- (void)cancelClick:(id)sender {
    if (_cancelBlock) {
        _cancelBlock();
    }
}

/**
 *  完成的点击事件
 *
 *  @param sender  sender
 */
- (void)finishClick:(id)sender {
    if (_finishBlock) {
        _finishBlock();
    }
}



@end
