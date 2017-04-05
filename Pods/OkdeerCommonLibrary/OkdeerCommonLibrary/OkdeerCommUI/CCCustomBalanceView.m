//
//  CCCustomBalanceView.m
//  CloudCity
//
//  Created by JuGuang on 15/2/9.
//  Copyright (c) 2015年 聚光. All rights reserved.
//

#import "CCCustomBalanceView.h"
#import "CCCustomLabel.h"
#import "CCCustomTextField.h"
#import "CCCustomButton.h"
#import "UIHeader.h"
#import "CCCustomAlertView.h"
#import "CCKeyBoardTopView.h"
#import "OkdeerCommUIHeader.h"
#import "CCCategorHeader.h"

@interface CCCustomBalanceView ()<UITextFieldDelegate>
@property (nonatomic, strong) CCCustomTextField *passWordTextField;
@property (nonatomic,copy)    ClickButtonBlock clickBlock;

@end

@implementation CCCustomBalanceView{
    UIView *_contentView ;
    CCCustomLabel *_messagelabel ;
    CCCustomLabel *_priceLabel ;
    
    CCCustomButton *canceButton ;
    CCCustomButton *doneButton ;
   
    
    CGFloat keyboardHeight ;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame] ;
    if (self) {
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width - 60 , 167)];
        _contentView.backgroundColor = [UIColor whiteColor] ;
        _contentView.layer.cornerRadius = 3 ;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        _contentView.center  = CGPointMake(self.frame.size.width / 2 , self.frame.size.height / 2) ;
        _messagelabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, 43)];
        _messagelabel.backgroundColor = [UIColor whiteColor] ;
        _messagelabel.text = @"请输入支付密码";
        _messagelabel.textColor = UIColorFromHex(0x333333);
        _messagelabel.textAlignment = NSTextAlignmentCenter ;
        _messagelabel.font = FONTDEFAULT(16) ;
        [_contentView addSubview:_messagelabel];
        
        _priceLabel = [[CCCustomLabel alloc] initWithFrame:CGRectMake(_messagelabel.left, _messagelabel.bottom, _messagelabel.width, 38) ];
        _priceLabel.backgroundColor = [UIColor whiteColor] ;
        _priceLabel.textColor = UIColorFromHex(0xFF3333);
        _priceLabel.font = FONTDEFAULT(15);
        _priceLabel.textAlignment = NSTextAlignmentCenter ;
        
        [_contentView addSubview:_priceLabel];
        
        _passWordTextField = [[CCCustomTextField alloc] initWithFrame:CGRectMake(28, _priceLabel.bottom , _contentView.width - 56 , 31)];
        _passWordTextField.backgroundColor = UIColorFromHex(COLOR_E2E2E2);
        _passWordTextField.layer.cornerRadius = 5 ;
        _passWordTextField.layer.masksToBounds = YES ;
        _passWordTextField.delegate = self;
        _passWordTextField.secureTextEntry = YES;
        _passWordTextField.keyboardType = UIKeyboardTypeASCIICapable ;
        __weak typeof(self) weakSelf = self;
        _passWordTextField.inputAccessoryView = [[CCKeyBoardTopView alloc]initWithFinishBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf clickDoneAction];
            }
        } withCancelBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf clickCanceAction];
            }
        }] ;
        [_contentView addSubview:_passWordTextField];
        
        
        canceButton = [CCCustomButton buttonWithType:UIButtonTypeCustom] ;
        canceButton.frame = CGRectMake(0, _contentView.height - 45 , _contentView.width / 2 , 45) ;
        [canceButton setTitle:@"取消" forState:UIControlStateNormal];
        [canceButton setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_contentView addSubview:canceButton];
        
        doneButton = [CCCustomButton buttonWithType:UIButtonTypeCustom] ;
        doneButton.frame = CGRectMake(canceButton.width, canceButton.top, canceButton.width, canceButton.height) ;
        [doneButton setTitle:@"付款" forState:UIControlStateNormal];
        [doneButton setTitleColor:UIColorFromHex(0x8CC63F) forState:UIControlStateNormal];
        [_contentView addSubview:doneButton];
        
        [canceButton addTarget:self action:@selector(clickCanceAction) forControlEvents:UIControlEventTouchUpInside];
        [doneButton addTarget: self action:@selector(clickDoneAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, doneButton.top, _contentView.width, 1)];
        lineView.backgroundColor = UIColorFromHex(COLOR_E2E2E2) ;
        [_contentView addSubview:lineView];
        
        UIView *nextLineView = [[UIView alloc] initWithFrame:CGRectMake(canceButton.right, lineView.top, 1, canceButton.height) ];
        nextLineView.backgroundColor = lineView.backgroundColor ;
        [_contentView addSubview:nextLineView];
        
        UIView *titleLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _messagelabel.bottom, _contentView.width, 1)];
        titleLineView.backgroundColor = UIColorFromHex(COLOR_E2E2E2);
        [_contentView addSubview:titleLineView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

/**
 *  初始化
 */
- (instancetype)initWithPrice:(NSString *)price clickBlock:(ClickButtonBlock)clickBlock{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _clickBlock = clickBlock;
        _priceLabel.text = price;
        
    }
    return self;
}

/**
 *  展示
 */
- (void)showView{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        _contentView.center  = CGPointMake(self.frame.size.width / 2 , self.frame.size.height / 2) ;
    } completion:^(BOOL finished) {
        
    }];
    
}
/**
 *   隐藏
 */
- (void)hideView{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.top = kUIFullHeight;
         self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _passWordTextField.text = @"";
    }];
}

/**
 *  点击取消
 */
- (void)clickCanceAction{
    if (_clickBlock) {
        _clickBlock (self,NO,nil);
    }
    [self hideView];
 
    
}
/**
 *  点击完成
 */
- (void)clickDoneAction{
    
    if (!_passWordTextField.text.length) {
        [[CCCustomAlertView alloc]setAlertViewTitle:nil andMessage:@"请输入支付密码" andhideAlertViewTimeOut:3.0f];
    }else{
        if (_clickBlock) {
            _clickBlock(self,YES,_passWordTextField.text);
        }
        [self hideView];
 
    }
   
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES ;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)keyShow:(NSNotification *)obj{
    NSDictionary *info = [obj userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    keyboardHeight = keyboardSize.height ;
    [self changframe] ;
}


- (void)changframe{
    
    if (_contentView.bottom + 64 + keyboardHeight > kUIFullHeight) {
        CGRect oldFrame = _contentView.frame ;
        oldFrame.origin.y = (kUIFullHeight  - keyboardHeight - 64 ) - _contentView.height ;
        _contentView.frame = oldFrame ;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
