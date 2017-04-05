//
//  CCFilmsViewController.m
//  okdeerMovie
//
//  Created by Mac on 16/12/12.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmsViewController.h"
#import "CCHttpRequest+Movie.h"
#import "FilmOnPlayingTbv.h"
#import "FilmWillPlayingTbv.h"
#import "CCMovieSearchViewController.h"
#import "CCFilmDetailsViewController.h"
#import "CCFilmPlayingListModel.h"

@interface CCFilmsViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;     /**< 正在热映 / 即将上映 */
@property (weak, nonatomic) IBOutlet UIScrollView *filmsBaseScrollV;    /**< 滚动页 */

@property (nonatomic, strong) FilmOnPlayingTbv *onPlayingTbv;       /**< 正在热映 */
@property (nonatomic, strong) FilmWillPlayingTbv *willPlayingTbv;   /**< 即将上映 */

@property (nonatomic, strong) CCRequestModel *requestModel;

@end

@implementation CCFilmsViewController

#pragma mark - /*** 生命周期 ***/
- (void)viewDidLoad {
    [super viewDidLoad];
    // -- 热映, 上映
    [self createSegmentControl];
    // -- 背景页
    [self createFilmBaseScrollV];
    // -- 设置NavBarItem
    [self createNavBarItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNavBarItems
{
    //moviebooking_search@2x
    UIImage *barImage = [UIImage imageNamed:@"moviebooking_search"];
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonMustItemWithImage:barImage highImage:nil target:self action:@selector(popToFilmsSearchVC)];
    [UIBarButtonItem addBarButtonToRight:backItem viewController:self width:-5];
}

#pragma mark - /*** 页面跳转 ***/
- (void)popToFilmsSearchVC
{
    CCMovieSearchViewController *vc = [[CCMovieSearchViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

// --- 跳转到影片详细信息
- (void)popToFilmDetailVC:(CCFilmPlayingListModel *)listModel
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCFilmDetailsViewController *VC = [storyboard instantiateViewControllerWithIdentifier:@"CCFilmDetailsViewController"];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

// --- 购买/预售 跳转
- (void)popToFilmBuyVC:(CCFilmPlayingListModel *)listModel
{
    CCLog(@"popToFilmBuyVC");
}

#pragma mark - /*** 数据请求 ***/
- (void)GetRequestWillPlayingPararms
{
    
}

/**< 获取即将上映的影片 */
- (void)requestWillPlayingFilmsData:(BOOL)isAnimation
{
    if (isAnimation) {
        [[CCAnimation instanceAnimation] startAnimationSubmitToView:self.view message:nil fullScreen:YES stopAnimationTime:0];
    }
    
    [self GetRequestWillPlayingPararms];
    
#warning --- 先做关闭动画
    [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:nil];
    [_willPlayingTbv customTableViewStopRefresh];
    return ;
    
    [CCHttpRequest requestFilmWillPlaying:self.requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        
    } success:^(NSString *code,NSString *msg,NSArray *arr,NSString *totalPage) {
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:^{
            [self handleWillPlayingFilmsData:arr];
        }];
    } failure:^(NSString *code, HttpRequestError httpRequestError, NSString *msg, NSDictionary *info, id objc) {
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:^{
            
        }];
    }];
}

- (void)handleWillPlayingFilmsData:(NSArray *)array
{
    self.willPlayingTbv.filmsDataList = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
}

- (void)GetRequestOnPlayingPararms
{
    
}

/**< 获取正在热映的影片 */
- (void)requestOnPlayingFilmsData:(BOOL)isAnimation
{
    if (isAnimation) {
        [[CCAnimation instanceAnimation] startAnimationSubmitToView:self.view message:nil fullScreen:YES stopAnimationTime:0];
    }
    
    [self GetRequestOnPlayingPararms];
#warning --- 先做关闭动画
    [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:nil];
    [_onPlayingTbv customTableViewStopRefresh];
    [self handleOnPlayingFilmsData:nil];
    return ;
    
    [CCHttpRequest requestFilmOnPlaying:self.requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        
    } success:^(NSString *code,NSString *msg,NSArray *arr,NSString *totalPage) {
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:^{
            [self handleOnPlayingFilmsData:arr];
            
        }];
    } failure:^(NSString *code, HttpRequestError httpRequestError, NSString *msg, NSDictionary *info, id objc) {
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:^{
            
        }];
    }];
}

- (void)handleOnPlayingFilmsData:(NSArray *)array
{
    self.onPlayingTbv.filmsDataList = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
}

#pragma mark - /*** 事件处理 ***/
- (void)clickSegmentedControlAction:(CCCustomSegmentedControl *)sender {
    NSInteger selectIndex = sender.selectedSegmentIndex;
    //CCLog(@"selectIndex... %ld", selectIndex);
    if (selectIndex < 2) {
        [self.filmsBaseScrollV setContentOffset:CGPointMake(selectIndex * kFullScreenWidth, 0) animated:YES];
        switch (selectIndex) {
            case 0:
            {
                [self.onPlayingTbv setContentOffset:CGPointZero animated:YES];
                // -- 请求数据
                self.onPlayingTbv.currentPage = 1;
                [self requestOnPlayingFilmsData:YES];
            }
                break;
            case 1:
            {
                [self.willPlayingTbv setContentOffset:CGPointZero animated:YES];
                // -- 请求数据
                self.willPlayingTbv.currentPage = 1;
                [self requestWillPlayingFilmsData:YES];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - /*** 初始化UI ***/
- (void)createSegmentControl
{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"正在热映",@"即将上映",nil];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    _segmentedControl.frame = CGRectMake(0.0, 0.0, 150, 30.0);
    _segmentedControl.tintColor = UIColorFromHex(COLOR_8CC63F);
    [_segmentedControl addTarget:self action:@selector(clickSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:_segmentedControl];
    _segmentedControl.selectedSegmentIndex = 0;
}

- (void)createFilmBaseScrollV
{
    [self.filmsBaseScrollV addSubview:self.onPlayingTbv];
    [self.filmsBaseScrollV addSubview:self.willPlayingTbv];
    self.filmsBaseScrollV.backgroundColor = UIColorFromHex(COLOR_FFFFFF);
    self.filmsBaseScrollV.contentSize = CGSizeMake(0, 0);
}

/**< 正在热映 */
- (FilmOnPlayingTbv *)onPlayingTbv
{
    if (!_onPlayingTbv) {
        _onPlayingTbv = [[FilmOnPlayingTbv alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, self.filmsBaseScrollV.height) style:UITableViewStylePlain];
        if ([_onPlayingTbv respondsToSelector:@selector(setSeparatorInset:)]) {
            _onPlayingTbv.separatorInset = UIEdgeInsetsZero;
        }
        if ([_onPlayingTbv respondsToSelector:@selector(setLayoutMargins:)]) {
            _onPlayingTbv.layoutMargins = UIEdgeInsetsZero;
        }
        _onPlayingTbv.tableFooterView = [UIView new];
        
        WEAKSELF(weakSelf);
        _onPlayingTbv.headerRefereshBlock = ^(CCCustomTableView *tableView,NSInteger currentPage){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf requestOnPlayingFilmsData:YES];
            }
        };
        
        _onPlayingTbv.footerRefreshBlock = ^(CCCustomTableView *tableView,NSInteger index,ResultBlock resultBlock){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf requestOnPlayingFilmsData:YES];
            }
        };
        
        /**
         *  电影详情
         */
        _onPlayingTbv.onPlayingTbvDidSelectBlock = ^(FilmOnPlayingTbv *tableView, CCFilmPlayingListModel *listModel){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf popToFilmDetailVC:listModel];
            }
        };
        
        /**
         *  购买/预售
         */
        _onPlayingTbv.onPlayingTbvFilmBuyBlock = ^(FilmOnPlayingTbv *tableView, CCFilmPlayingListModel *listModel){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf popToFilmBuyVC:listModel];
            }
        };
    }
    return _onPlayingTbv;
}

/**< 即将上映 */
- (FilmWillPlayingTbv *)willPlayingTbv
{
    if (!_willPlayingTbv) {
        _willPlayingTbv = [[FilmWillPlayingTbv alloc] initWithFrame:CGRectMake(kFullScreenWidth, 0, kFullScreenWidth, self.filmsBaseScrollV.height) style:UITableViewStylePlain];
        if ([_willPlayingTbv respondsToSelector:@selector(setSeparatorInset:)]) {
            _willPlayingTbv.separatorInset = UIEdgeInsetsZero;
        }
        if ([_willPlayingTbv respondsToSelector:@selector(setLayoutMargins:)]) {
            _willPlayingTbv.layoutMargins = UIEdgeInsetsZero;
        }
        _willPlayingTbv.tableFooterView = [UIView new];
        
        WEAKSELF(weakSelf);
        _willPlayingTbv.headerRefereshBlock = ^(CCCustomTableView *tableView,NSInteger currentPage){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf requestWillPlayingFilmsData:NO];
            }
        };
        
        _willPlayingTbv.footerRefreshBlock = ^(CCCustomTableView *tableView,NSInteger index,ResultBlock resultBlock){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf requestWillPlayingFilmsData:NO];
            }
        };
    }
    return _willPlayingTbv;
}

@end
