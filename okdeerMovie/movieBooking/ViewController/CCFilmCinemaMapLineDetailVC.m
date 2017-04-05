//
//  CCFilmCinemaMapLineDetailVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmCinemaMapLineDetailVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface CCFilmCinemaMapLineDetailVC ()<BMKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BMKMapView *mapView;      /**< 地图 */
@property (nonatomic, strong) UITableView *lineDetailTbv;       /**< 线路详细信息 */

@end

@implementation CCFilmCinemaMapLineDetailVC

#pragma mark - /*** 生命周期 ***/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"查看导航线路";
    
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
}

- (void)dealloc
{
    if (self.mapView) {
        self.mapView = nil;
    }
}

#pragma mark - /*** UITableViewDelegate/UITableViewDataSource ***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cellStr";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = @"index";
    return cell;
}

#pragma mark - /*** 初始化UI ***/
- (void)initViews
{
    [self initMapView];
    [self.view addSubview:self.lineDetailTbv];
}

- (void)initMapView
{
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(CCNumberTypeOf0, CCNumberTypeOf0, kFullScreenWidth, kFullScreenWidth * 3/4)];
    [self.view addSubview:self.mapView];
}

- (UITableView *)lineDetailTbv
{
    if (!_lineDetailTbv) {
        _lineDetailTbv = [[UITableView alloc] initWithFrame:CGRectMake(CCNumberTypeOf0, kFullScreenWidth * 3/4, kFullScreenWidth, kFullScreenHeight -64 - kFullScreenWidth * 3/4)];
        _lineDetailTbv.delegate = self;
        _lineDetailTbv.dataSource = self;
        if ([_lineDetailTbv respondsToSelector:@selector(setSeparatorInset:)]) {
            _lineDetailTbv.separatorInset = UIEdgeInsetsZero;
        }
        if ([_lineDetailTbv respondsToSelector:@selector(setLayoutMargins:)]) {
            _lineDetailTbv.layoutMargins = UIEdgeInsetsZero;
        }
        
        _lineDetailTbv.tableFooterView = [UIView new];
    }
    return _lineDetailTbv;
}

@end
