//
//  CCFilmSeatsDetailVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmSeatsDetailVC.h"
#import "ZFSeatSelectionView.h"
#import "CCFilmConfirmOrderVC.h"
#import "ZFSeatsModel.h"
#import "CCFilmSelectedSeatView.h"

@interface CCFilmSeatsDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *cinemaNamelabel;      /**< 影院名称 */
@property (weak, nonatomic) IBOutlet UILabel *dateCinemaInfolabel;      /**< 电影场次提示 */
@property (weak, nonatomic) IBOutlet UILabel *cinemaTotalMoneylabel;    /**< 票价总价 */
@property (weak, nonatomic) IBOutlet UILabel *cinemaNumPricelabel;      /**< 票价单价 */
@property (weak, nonatomic) IBOutlet UIButton *cinemeConfirmSeatsBtn;   /**< 确认选座 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searsTipsSeplineConstraints;
@property (weak, nonatomic) IBOutlet UILabel *NoSeatsTipslabel;     /**< 无选座提示 */

@property (nonatomic, strong) ZFSeatSelectionView *zfSeatSelectionV;    /**< 座位选择图 */
@property (nonatomic, strong) CCFilmSelectedSeatView *filmSelectedSeatView;        /**< 已选座位View */

@end

@implementation CCFilmSeatsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // -- 初始化UI
    [self initViews];
    
    // --- 初始化座位表
    [self initZfSeatsSelectionViews];
    
    // --- 已选座位处理
    [self.view addSubview:self.filmSelectedSeatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /*** 确定选座 ***/
- (IBAction)confirmSeatsToSubmit:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCFilmConfirmOrderVC *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CCFilmConfirmOrderVC class])];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - /*** 处理座位信息 ***/


#pragma mark - /*** 初始化UI相关 ***/
- (void)initViews
{
    self.searsTipsSeplineConstraints.constant = ScreenGridViewHeight;
    self.cinemeConfirmSeatsBtn.backgroundColor = UIColorFromHex(0xe7e7e7);
    [self.cinemeConfirmSeatsBtn setTitleColor:UIColorFromHex(0xc3c3c3) forState:UIControlStateNormal];
    self.cinemaNumPricelabel.hidden = YES;
    self.cinemaTotalMoneylabel.hidden = YES;
    self.NoSeatsTipslabel.textColor = UIColorFromHex(COLOR_666666);
    self.cinemaTotalMoneylabel.textColor = UIColorFromHex(COLOR_FF3333);
    self.cinemaNumPricelabel.textColor = UIColorFromHex(COLOR_999999);
    self.cinemaNamelabel.textColor = UIColorFromHex(COLOR_333333);
    self.dateCinemaInfolabel.textColor = UIColorFromHex(0xff5a00);
}

// --- 懒加载座位表
- (void)initZfSeatsSelectionViews
{
    __weak typeof(self) weakSelf = self;
    //模拟延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"seats 2.plist"] ofType:nil];
        //模拟网络加载数据
        NSDictionary *seatsDic = [NSDictionary dictionaryWithContentsOfFile:path];
        //NSLog(@"dic -- %@", seatsDic);
        
        __block  NSMutableArray *  seatsArray = seatsDic[@"seats"];
        __block  NSMutableArray *seatsModelArray = [NSMutableArray array];
        
        [seatsArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"obj -- %@", obj);
            ZFSeatsModel *seatModel = [ZFSeatsModel modelObjectWithDictionary:(NSDictionary *)obj];
            [seatsModelArray addObject:seatModel];
        }];
        //数据回来初始化选座模块
        [weakSelf initSelectionView:seatsModelArray];
    });
}

//创建选座模块
-(void)initSelectionView:(NSMutableArray *)seatsModelArray{
    
    ZFSeatSelectionView *selectionView = [[ZFSeatSelectionView alloc] initWithFrame:CGRectMake(0, 125, kFullScreenWidth, kFullScreenHeight - 125 - 46 - 80 - 64) SeatsArray:seatsModelArray seatBtnActionBlock:^(NSMutableArray *seatsBtnsArray) {
        NSLog(@"%zd个选中按钮",seatsBtnsArray.count);
    }];
    selectionView.backgroundColor = UIColorFromHex(COLOR_FFFFFF);
    [self.view addSubview:selectionView];
}

// --- 已选座位展示
- (CCFilmSelectedSeatView *)filmSelectedSeatView
{
    if (!_filmSelectedSeatView) {
        _filmSelectedSeatView = [[CCFilmSelectedSeatView alloc] initWithFrame:CGRectMake(0, kFullScreenHeight - 64 - 46 - 80, kFullScreenHeight, 80)];
    }
    return _filmSelectedSeatView;
}

@end
