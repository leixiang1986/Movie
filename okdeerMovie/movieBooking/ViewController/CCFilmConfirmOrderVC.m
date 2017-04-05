//
//  CCFilmConfirmOrderVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmConfirmOrderVC.h"
#import "CCConfirmOrderPrivilegeVC.h"

@interface CCFilmConfirmOrderVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *confirmInfoScrollBkv;
@property (weak, nonatomic) IBOutlet UIView *orefrecePriceBkView;
@property (weak, nonatomic) IBOutlet UILabel *confirmPayTimelabel;          /**< 订单倒计时时间 */
@property (weak, nonatomic) IBOutlet UILabel *filmNamelabel;                /**< 电影名称 */
@property (weak, nonatomic) IBOutlet UILabel *filmDatelabel;        /**< 电影日期 */
@property (weak, nonatomic) IBOutlet UILabel *filmCinemalabel;      /**< 影院名称 */
@property (weak, nonatomic) IBOutlet UILabel *filmFirstSeatlabel;       /**< 第一个座位 */
@property (weak, nonatomic) IBOutlet UILabel *filmSecoSeatlabel;        /**< 第二个座位 */
@property (weak, nonatomic) IBOutlet UILabel *filmThirdSeatlabel;       /**< 第三个座位 */
@property (weak, nonatomic) IBOutlet UILabel *filmFourSeatlabel;        /**< 第四个座位 */
@property (weak, nonatomic) IBOutlet UILabel *filmTotalMoneylabel;      /**< 票价 */
@property (weak, nonatomic) IBOutlet UILabel *filmOrderTotalMoneylabel; /**< 订单总价 */
@property (weak, nonatomic) IBOutlet UILabel *filmPreficePricelabel;        /**< 优惠价 */
@property (weak, nonatomic) IBOutlet UILabel *filmActualPaylabel;       /**< 实付价格  */
@property (weak, nonatomic) IBOutlet UITextField *usePhoneTxtField;     /**< 手机号码 */
@property (weak, nonatomic) IBOutlet UIButton *confirmPayBtn;           /**< 确认支付 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *prefrecelineConstraints;   /**< 分割线 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filmTotallineConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phonelineConstraints;

@end

@implementation CCFilmConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // --- 初始化设置
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /*** 确认支付 ***/
- (IBAction)confirmPayBtnClicked:(id)sender
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// --- 优惠劵
- (void)prefrcePriceViewClicked
{
    CCConfirmOrderPrivilegeVC *VC = [[CCConfirmOrderPrivilegeVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - /*** 初始化UI设置 ***/
- (void)initViews
{
    self.prefrecelineConstraints.constant = ScreenGridViewHeight;
    self.filmTotallineConstraint.constant = ScreenGridViewHeight;
    self.phonelineConstraints.constant = ScreenGridViewHeight;
    self.filmFirstSeatlabel.layer.cornerRadius = 12.5f;
    self.filmFirstSeatlabel.layer.masksToBounds = YES;
    self.filmFirstSeatlabel.layer.borderWidth = 1.f;
    self.filmFirstSeatlabel.layer.borderColor = UIColorFromHex(COLOR_8CC63F).CGColor;
    self.filmFirstSeatlabel.textColor = UIColorFromHex(COLOR_8CC63F);
    self.filmSecoSeatlabel.layer.cornerRadius = 12.5f;
    self.filmSecoSeatlabel.layer.masksToBounds = YES;
    self.filmSecoSeatlabel.layer.borderWidth = 1.f;
    self.filmSecoSeatlabel.layer.borderColor = UIColorFromHex(COLOR_8CC63F).CGColor;
    self.filmSecoSeatlabel.textColor = UIColorFromHex(COLOR_8CC63F);
    self.filmThirdSeatlabel.layer.cornerRadius = 12.5f;
    self.filmThirdSeatlabel.layer.masksToBounds = YES;
    self.filmThirdSeatlabel.layer.borderWidth = 1.f;
    self.filmThirdSeatlabel.layer.borderColor = UIColorFromHex(COLOR_8CC63F).CGColor;
    self.filmThirdSeatlabel.textColor = UIColorFromHex(COLOR_8CC63F);
    self.filmFourSeatlabel.layer.cornerRadius = 12.5f;
    self.filmFourSeatlabel.layer.masksToBounds = YES;
    self.filmFourSeatlabel.layer.borderWidth = 1.f;
    self.filmFourSeatlabel.layer.borderColor = UIColorFromHex(COLOR_8CC63F).CGColor;
    self.filmFourSeatlabel.textColor = UIColorFromHex(COLOR_8CC63F);
    self.filmNamelabel.textColor = UIColorFromHex(COLOR_333333);
    self.filmCinemalabel.textColor = UIColorFromHex(COLOR_666666);
    self.filmDatelabel.textColor = UIColorFromHex(0xff5a00);
    
    // ---
    self.filmPreficePricelabel.textColor = UIColorFromHex(COLOR_FF3333);
    self.filmTotalMoneylabel.textColor = UIColorFromHex(COLOR_FF3333);
    self.filmActualPaylabel.textColor = UIColorFromHex(COLOR_FF3333);
    self.filmOrderTotalMoneylabel.textColor = UIColorFromHex(COLOR_FF3333);
    // ---
    self.confirmPayBtn.backgroundColor = UIColorFromHex(0xff5a00);
    [self.confirmPayBtn setTitleColor:UIColorFromHex(COLOR_FFFFFF) forState:UIControlStateNormal];
    
    // --- 触摸手势
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)];
    [self.confirmInfoScrollBkv addGestureRecognizer:recog];
    
    // --- 触摸优惠信息
    UITapGestureRecognizer *recogOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prefrcePriceViewClicked)];
    [self.orefrecePriceBkView addGestureRecognizer:recogOne];
}

- (void)tapClicked
{
    [self.view endEditing:YES];
}

@end
