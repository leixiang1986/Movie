//
//  ViewController.m
//  okdeerMovie
//
//  Created by Mac on 16/12/5.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "CCHttpRequest+CCLoginRequest.h"
#import "CCMovieMainTabbarVC.h"
#import "CCCinemaFilterView.h"
#import "CCCinemaDetailFilmsView.h"
#import "CCCinemaDetailFilmsScheduleView.h"
#import "CCCinemaDetailFilmsScheduleDateModel.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) UITextField *userNameTxtField;
@property (nonatomic, strong) UITextField *passWordTxtField;
@property (nonatomic, strong) CCCustomSegmentedControl *segment;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"电影票项目";
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userphone = [userdefault objectForKey:@"phone"];
    NSString *userpass = [userdefault objectForKey:@"password"];
    _userNameTxtField.text = userphone;
    _passWordTxtField.text = userpass;






}

#pragma mark - /*** 火车票项目 ***/
- (void)GotoTrainTicket
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCMovieMainTabbarVC *ticketMainVC = [storyboard instantiateViewControllerWithIdentifier:@"CCMovieMainTabbarVC"];
    [self.navigationController pushViewController:ticketMainVC animated:YES];
}

- (void)createUI
{
    //提示信息
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kFullScreenWidth - 40, 20)];
    label.text = @"-------  提示  -------";
    label.font = FONTDEFAULT(14);
    label.textColor = UIColorFromHex(COLOR_FF3333);
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    UILabel *userlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 50, 40)];
    userlabel.text = @"用户名:";
    userlabel.font = FONTDEFAULT(14);
    [self.view addSubview:userlabel];
    _userNameTxtField = [[UITextField alloc] initWithFrame:CGRectMake(70, 120, 200, 40)];
    _userNameTxtField.placeholder = @"用户名";
    _userNameTxtField.layer.cornerRadius = 3.f;
    _userNameTxtField.layer.borderColor = UIColorFromHex(COLOR_FF3333).CGColor;
    _userNameTxtField.layer.borderWidth = ScreenGridViewHeight;
    [self.view addSubview:_userNameTxtField];
    
    UILabel *passlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 50, 40)];
    passlabel.text = @"密码:";
    passlabel.font = FONTDEFAULT(14);
    [self.view addSubview:passlabel];
    _passWordTxtField = [[UITextField alloc] initWithFrame:CGRectMake(70, 170, 200, 40)];
    _passWordTxtField.placeholder = @"密码";
    _passWordTxtField.layer.cornerRadius = 3.f;
    _passWordTxtField.layer.borderColor = UIColorFromHex(COLOR_FF3333).CGColor;
    _passWordTxtField.layer.borderWidth = ScreenGridViewHeight;
    [self.view addSubview:_passWordTxtField];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
    [btn setTitle:@"电影票" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 60)];
    [btn1 setTitle:@"免登录" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor lightGrayColor];
    CGPoint center = btn.center;
    btn1.center = CGPointMake(center.x, center.y + 120);
    [btn1 addTarget:self action:@selector(noLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)noLogin {
    if ([UserDataManager shareManager].userInfo.userId.length) {
        //开始跳转进入火车票项目
        [self GotoTrainTicket];
    }
    else {
        CCLog(@"请登录");
        [self GotoTrainTicket];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)toLogin
{
    if (_userNameTxtField.text.length == 0 || _passWordTxtField.text.length == 0) {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = @"请输入用户名或密码";
        [HUD hideAnimated:YES afterDelay:1.5];
        return ;
    }
    
    [self.view endEditing:YES];
    [_userNameTxtField resignFirstResponder];
    [_passWordTxtField resignFirstResponder];
    
    _phone = _userNameTxtField.text;
    _password = _passWordTxtField.text;

    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:_phone forKey:@"phone"];
    [userdefault setObject:_password forKey:@"password"];
    [userdefault synchronize];
    
    NSString *const kPassKey = @"3B827D20";             /**< 密码key*/
    [[CCAnimation instanceAnimation] startAnimationSubmitToView:self.view message:nil fullScreen:YES stopAnimationTime:0];
    CCRequestModel *requestModel = [[CCRequestModel alloc] init];
    requestModel.parameters = @{
                                @"data": @{
                                        @"loginName":[CCUtility encryptWithText:_phone key:kPassKey],
                                        @"loginPassword":[CCUtility encryptWithText:_password key:kPassKey],
                                        @"verifyCode": @"",
                                        @"verifyCodeType": @""
                                        }
                                };
    [CCHttpRequest requestLogin:requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        
    } success:^(){
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:nil];
        //开始跳转进入火车票项目
        [self GotoTrainTicket];
    } failure:^(NSString *code, HttpRequestError httpRequestError, NSString *msg, NSDictionary *info, id objc) {
        
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:nil];
        showRequestErrMsgTip(msg, code, httpRequestError, @"登录失败");
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.destinationViewController isKindOfClass:[UITabBarController class]]){
//        
//        UITabBarController *mainVC= (UITabBarController *)segue.destinationViewController;
//        mainVC.tabBar.tintColor = [UIColor colorWithRed:0.55 green:0.78 blue:0.25 alpha:1];
//    }
}


@end
