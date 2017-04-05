//
//  CCFilmCinemaMapVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmCinemaMapVC.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import "CCCinemaAddPointView.h"
#import "CCFilmCinemaMapLinesVC.h"

@interface CCFilmCinemaMapVC ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKMapView *mapView;      /**< 地图 */
@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) CCCinemaAddPointView *mapPinPointView;    /**< 地图标注 */
@property (nonatomic, strong) UILabel *cinemaNamelabel;     /**< 电影院名称 */
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;

@end

@implementation CCFilmCinemaMapVC

#pragma mark - /*** 生命周期 ***/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"高新园电影院";
    // ---
    [self initViews];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addPointAnnotation];
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
    _locService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
    _locService.delegate = nil;
    [_locService stopUserLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (_mapView) {
        _mapView = nil;
    }
}

//添加标注
- (void)addPointAnnotation
{
    if (_pointAnnotation == nil) {
        _pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = 22.553722;
        coor.longitude = 113.932179;
        _pointAnnotation.coordinate = coor;
    }
    [_mapView addAnnotation:_pointAnnotation];
    [_mapView setCenterCoordinate:_pointAnnotation.coordinate animated:YES];
    [self performSelectorOnMainThread:@selector(selectMapAnnotation) withObject:nil waitUntilDone:YES];
}

- (void)selectMapAnnotation
{
    // --- select
    [self.mapView selectAnnotation:self.pointAnnotation animated:YES];
}

#pragma mark - /*** BMKMapViewDelegate ***/
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation;
{
    if (annotation == _pointAnnotation)
    {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
            annotationView.image = [UIImage imageNamed:@"moviebooking_mapPin"];
            
            self.cinemaNamelabel.text = @"高新园电影院";
            BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:self.mapPinPointView];
            pView.frame = self.mapPinPointView.frame;
            annotationView.paopaoView = nil;
            annotationView.paopaoView = pView;
        }
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - /*** 地图定位相关 ***/
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //didUpdateUserLocation lat 22.553722,long 113.952179
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    //[_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

#pragma mark - /*** 导航 ***/
- (void)popToCinemaMapLinesVC
{
    CCLog(@"CCFilmCinemaMapLinesVC ");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCFilmCinemaMapLinesVC *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"CCFilmCinemaMapLinesVC"];
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark - /*** 初始化UI ***/
- (void)initViews
{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(CCNumberTypeOf0, CCNumberTypeOf0, kFullScreenWidth, kFullScreenHeight - CCNumberTypeOf64)];
    [self.view addSubview:self.mapView];
    _locService = [[BMKLocationService alloc] init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;   //显示定位图层
    _mapView.zoomLevel = 15;
    _mapView.userTrackingMode = BMKUserTrackingModeHeading;  //设置定位的状态
}

// --- 电影院名称
- (UILabel *)cinemaNamelabel
{
    if (!_cinemaNamelabel) {
        _cinemaNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];
        _cinemaNamelabel.backgroundColor = [UIColor clearColor];
        _cinemaNamelabel.font = [UIFont systemFontOfSize:12];
        _cinemaNamelabel.textColor = UIColorFromHex(COLOR_666666);
        _cinemaNamelabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cinemaNamelabel;
}

// --- 地图标注
- (CCCinemaAddPointView *)mapPinPointView
{
    if (!_mapPinPointView) {
        _mapPinPointView = [[CCCinemaAddPointView alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        _mapPinPointView.layer.masksToBounds = YES;
        _mapPinPointView.backgroundColor = [UIColor clearColor];
        
        //自定义显示的内容
        [_mapPinPointView addSubview:self.cinemaNamelabel];
        
        UIButton *driNavBtn = [[UIButton alloc] initWithFrame:CGRectMake(95, 10, 45, 30)];
        [driNavBtn setTitle:@"导航" forState:UIControlStateNormal];
        [driNavBtn setTitleColor:UIColorFromHex(COLOR_FFFFFF) forState:UIControlStateNormal];
        driNavBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        driNavBtn.backgroundColor = UIColorFromHex(COLOR_8CC63F);
        [driNavBtn addTarget:self action:@selector(popToCinemaMapLinesVC) forControlEvents:UIControlEventTouchUpInside];
        // -- 导航按钮只要两个角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:driNavBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = driNavBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        driNavBtn.layer.mask = maskLayer;
        [_mapPinPointView addSubview:driNavBtn];
    }
    return _mapPinPointView;
}

@end
