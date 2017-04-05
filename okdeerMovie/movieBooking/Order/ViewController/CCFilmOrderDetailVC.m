//
//  CCFilmOrderDetailVC.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmOrderDetailVC.h"
#import "CCFilmOrderDetailView.h"

@interface CCFilmOrderDetailVC ()<UIAlertViewDelegate>
@property (nonatomic,weak) CCFilmOrderDetailView *selfView;
@property (nonatomic,copy) NSString *cinemaPhoneNum;
@end

@implementation CCFilmOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    CCFilmOrderDetailView *detailView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCFilmOrderDetailView class]) owner:nil options:nil] lastObject];
    detailView.frame = CGRectMake(0, 0, kFullScreenWidth, kFullScreenHeight - kStatusBarAndNavigationBarHeight);
    //点击拨打电话
    WEAKSELF(weakSelf)
    detailView.phoneClick = ^(CCFilmOrderDetailView *view,NSString *phoneNum){
        STRONGSELF(strongSelf)
        if (phoneNum.length) {
            strongSelf.cinemaPhoneNum = phoneNum;
            [[CCCustomAlertView alloc] setAlertViewTitle:@"拨打电话" andMessage:phoneNum andDelegate:self andCanceButtonTitle:@"取消" andButtonTitleArray:@[@"拨打"]];
        }
        else {
            [[CCCustomAlertView alloc] setAlertViewTitle:@"提示" andMessage:@"该影院无联系电话" andhideAlertViewTimeOut:2];
        }


    };
    self.view = detailView;
    _selfView = detailView;

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"拨打"]) {
        [self dailCinemaPhone];
    }
}

//拨打电话
- (void)dailCinemaPhone {
    if (self.cinemaPhoneNum.length) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.cinemaPhoneNum]]];
    }
}


@end
