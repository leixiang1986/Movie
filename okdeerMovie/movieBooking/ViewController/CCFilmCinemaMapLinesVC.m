//
//  CCFilmCinemaMapLinesVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmCinemaMapLinesVC.h"
#import "CCCinemaLinesTbv.h"
#import "CCFilmCinemaMapLineDetailVC.h"

typedef NS_ENUM(NSInteger, lineBtnTag)
{
    lineBtnTag_bus = 10001,
    lineBtnTag_car,
    lineBtnTag_walk,
};

@interface CCFilmCinemaMapLinesVC ()

@property (weak, nonatomic) IBOutlet UITextField *startLocationlabel;
@property (weak, nonatomic) IBOutlet UITextField *dstLocationlabel;
@property (weak, nonatomic) IBOutlet UIImageView *startDstChangeImgV;
@property (weak, nonatomic) IBOutlet UIButton *busLineBtn;
@property (weak, nonatomic) IBOutlet UIButton *carLineBtn;
@property (weak, nonatomic) IBOutlet UIButton *walkLineBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *lineScrollBkv;

@property (nonatomic, strong) CCCinemaLinesTbv *busLineTbv;     /**< 公交线路 */
@property (nonatomic, strong) CCCinemaLinesTbv *carLineTbv;     /**< 汽车线路 */
@property (nonatomic, strong) CCCinemaLinesTbv *walkLineTbv;    /**< 步行线路 */

@end

@implementation CCFilmCinemaMapLinesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"查看导航线路";
    
    [self initViews];
    [self initLineBtnClick];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /*** 事件处理 ***/
- (void)lineBtnClicked:(id)sender
{
    UIButton *lineBtn = (UIButton *)sender;
    NSInteger btnTag = lineBtn.tag;
    switch (btnTag) {
        case lineBtnTag_bus:
        {
            [self.lineScrollBkv setContentOffset:CGPointMake(0, 0) animated:YES];
        }
            break;
        case lineBtnTag_car:
        {
            [self.lineScrollBkv setContentOffset:CGPointMake(kFullScreenWidth, 0) animated:YES];
        }
            break;
        case lineBtnTag_walk:
        {
            [self.lineScrollBkv setContentOffset:CGPointMake(2*kFullScreenWidth, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

// --- 跳转到路线的详细路线
- (void)popToMaplineDetailVC:(CinemaLineType)lineType trainsLine:(BMKTransitRouteLine *)trainline driveLine:(BMKDrivingRouteLine *)driveline walkLine:(BMKWalkingRouteLine *)walkline
{
    CCFilmCinemaMapLineDetailVC *detailVC = [[CCFilmCinemaMapLineDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - /*** 初始化UI ***/
- (void)initLineBtnClick
{
    self.busLineBtn.tag = lineBtnTag_bus;
    [self.busLineBtn addTarget:self action:@selector(lineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.carLineBtn.tag = lineBtnTag_car;
    [self.carLineBtn addTarget:self action:@selector(lineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.walkLineBtn.tag = lineBtnTag_walk;
    [self.walkLineBtn addTarget:self action:@selector(lineBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initViews
{
    [self.lineScrollBkv addSubview:self.busLineTbv];
    [self.lineScrollBkv addSubview:self.carLineTbv];
    [self.lineScrollBkv addSubview:self.walkLineTbv];
    self.lineScrollBkv.contentSize = CGSizeMake(0, 0);
}
/**< 公交线路 */
- (CCCinemaLinesTbv *)busLineTbv
{
    if (!_busLineTbv) {
        _busLineTbv = [[CCCinemaLinesTbv alloc] initWithFrame:CGRectMake(CCNumberTypeOf0, CCNumberTypeOf0, kFullScreenWidth, kFullScreenHeight - 64 - 172 - 10) style:UITableViewStylePlain];
        WEAKSELF(weakSelf);
        _busLineTbv.cinemaLineBlock = ^(CinemaLineType lineType, BMKTransitRouteLine *transLine, BMKDrivingRouteLine *driveline, BMKWalkingRouteLine *walkline){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf popToMaplineDetailVC:lineType trainsLine:transLine driveLine:driveline walkLine:walkline];
            }
        };
    }
    return _busLineTbv;
}
/**< 汽车线路 */
- (CCCinemaLinesTbv *)carLineTbv
{
    if (!_carLineTbv) {
        _carLineTbv = [[CCCinemaLinesTbv alloc] initWithFrame:CGRectMake(kFullScreenWidth, CCNumberTypeOf0, kFullScreenWidth, kFullScreenHeight - 64 - 172 - 10) style:UITableViewStylePlain];
        WEAKSELF(weakSelf);
        _carLineTbv.cinemaLineBlock = ^(CinemaLineType lineType, BMKTransitRouteLine *transLine, BMKDrivingRouteLine *driveline, BMKWalkingRouteLine *walkline){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf popToMaplineDetailVC:lineType trainsLine:transLine driveLine:driveline walkLine:walkline];
            }
        };
    }
    return _carLineTbv;
}
/**< 步行线路 */
- (CCCinemaLinesTbv *)walkLineTbv
{
    if (!_walkLineTbv) {
        _walkLineTbv = [[CCCinemaLinesTbv alloc] initWithFrame:CGRectMake(2*kFullScreenWidth, CCNumberTypeOf0, kFullScreenWidth, kFullScreenHeight - 64 - 172 - 10) style:UITableViewStylePlain];
        WEAKSELF(weakSelf);
        _walkLineTbv.cinemaLineBlock = ^(CinemaLineType lineType, BMKTransitRouteLine *transLine, BMKDrivingRouteLine *driveline, BMKWalkingRouteLine *walkline){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf popToMaplineDetailVC:lineType trainsLine:transLine driveLine:driveline walkLine:walkline];
            }
        };
    }
    return _walkLineTbv;
}


@end
