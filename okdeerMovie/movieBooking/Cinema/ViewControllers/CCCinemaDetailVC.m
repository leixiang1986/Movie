//
//  CCCinemaDetailVC.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailVC.h"
#import "CCCinemaDetailFilmsScheduleView.h"
#import "CCCinemaDetailFilmsView.h"
#import "CCCinemaDetailCinemaMsgView.h"
#import "CCCinemaDetailFilmsListModel.h"
#import "CCCinemaDetailMsgVC.h"
#import "CCCinemaPreferentialTipsVC.h"
#import "CCNoDataView.h"
#import "CCFilmSeatsDetailVC.h"
#import "CCCinemaDetailFilmsScheduleDateModel.h"
#import "CCAroundCarouselView.h"

@interface CCCinemaDetailVC ()

@property (strong, nonatomic) UIScrollView *baseScrollView;                     //底部的scrollView
@property (strong, nonatomic) CCAroundCarouselView *tipsView;                   //顶部提示信息
@property (strong, nonatomic) CCCinemaDetailCinemaMsgView *cinemaMsgView;       //展示影院信息的view
@property (strong, nonatomic) CCCinemaDetailFilmsView *filmsView;               //展示电影信息的view
@property (strong, nonatomic) CCCinemaDetailFilmsScheduleView *scheculeView;    //展示排期的信息view
@property (strong, nonatomic) __block MASConstraint *tableViewHieght;                   //tableView的高度
@property (strong, nonatomic) CCNoDataView *nodataView;                         /**< 没有数据的view */

@property (nonatomic, strong) NSArray *dateArr;
@property (nonatomic, strong) NSMutableDictionary *filmsListDic;                /**< 某部电影的 */
@property (nonatomic, copy) NSString *favorableTips;                            /**< 优惠提示信息 */
@property (nonatomic, strong) CCRequestModel *requestModel;
@property (nonatomic, strong) NSMutableDictionary *requestParameter;

@end

@implementation CCCinemaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self cinemaMsgView];
    [self filmsView];
    [self scheculeView];
    self.scheculeView.dateArr = self.dateArr;

//    [self setupNotAnyFilmsUI];
}

#pragma mark - data

//没有数据和刷新时请求数据
- (void)requestData:(CCRequestModel *)requestModel complete:(void(^)(NSString *tips,NSArray *filmList))completeBlock {
    if (requestModel.isRequest == YES) {
        return;
    }
    //请求数据
    //保存请求的电影列表数据
    //组装为展示数据model
}


- (NSArray *)dateArr {
    if (!_dateArr) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:7];
        for (NSInteger i = 0; i < 7; i++) {

            NSDate *date = [[NSDate date] dateByAddingTimeInterval:i * 24 * 60 * 60];
            CCCinemaDetailFilmsScheduleDateModel *model = [CCCinemaDetailFilmsScheduleDateModel modelWithDate:date andCurrentDate:[NSDate date]];
            if (i == 0) {
                model.select = YES;
            }
            [tempArr addObject:model];

        }
        _dateArr = [tempArr copy];
    }

    return _dateArr;
}

//影片排期列表,用日期作key
- (NSMutableDictionary *)filmsListDic {
    if (!_filmsListDic) {
        _filmsListDic = [[NSMutableDictionary alloc] init];

        for (NSInteger i = 0; i < self.dateArr.count; i++) {
            CCCinemaDetailFilmsScheduleDateModel *dateModel = [self.dateArr objectAtIndex:i];
            if (dateModel.requestDate) {
                NSMutableArray *tempArr = [[NSMutableArray alloc] init];
                for (NSInteger i = 0; i < 10; i++) {
                    CCCinemaDetailFilmsListModel *listModel = [[CCCinemaDetailFilmsListModel alloc] init];
                    [tempArr addObject:listModel];
                    
                }
                [_filmsListDic setObject:tempArr forKey:dateModel.requestDate];
            }
        }
    }

    return _filmsListDic;
}


#pragma mark - 其他UI

//设置没有任何拍片的UI
- (void)setupNotAnyFilmsUI {
    [self cinemaMsgView];

    UIView *nodataBackView = [[UIView alloc] init];
    [self.view addSubview:nodataBackView];
    [nodataBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.cinemaMsgView.mas_bottom);
    }];

    CCNoDataView *nodataView= [CCNoDataView showWithDefaultInSuperView:nodataBackView show:YES];
    nodataView.backgroundColor = UIColorFromHex(COLOR_F5F6F8);
    [nodataView loadText:@"该影院暂时无任何排片信息" image:[UIImage imageNamed:@"moviebooking_nodata_film"]];
}

//底层滑动的scrollView
- (UIScrollView *)baseScrollView {
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kFullScreenHeight - kStatusBarAndNavigationBarHeight)];
        [self.view addSubview:_baseScrollView];
        WEAKSELF(weakSelf)
        [_baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONGSELF(strongSelf)
            make.edges.equalTo(strongSelf.view);
        }];
    }

    return _baseScrollView;
}


#pragma mark - 顶部提示信息
//顶部提示信息
- (CCAroundCarouselView *)tipsView {
    if (!_tipsView) {
//        _tipsView = [[CCAroundCarouselView alloc] initWithFrame:CGRectMake(0, self., <#CGFloat width#>, <#CGFloat height#>)];
    }

    return _tipsView;
}



#pragma mark - 影院信息相关
- (CCCinemaDetailCinemaMsgView *)cinemaMsgView {
    if (!_cinemaMsgView) {
        _cinemaMsgView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCCinemaDetailCinemaMsgView class]) owner:nil options:nil] lastObject];

        [self.baseScrollView addSubview:_cinemaMsgView];
        [self addTapToView:_cinemaMsgView withSelector:@selector(tapCinemaMsgView)];
        WEAKSELF(weakSelf)
        //内部控制了高度
        [_cinemaMsgView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONGSELF(strongSelf)
            make.left.top.right.equalTo(strongSelf.baseScrollView);
            make.width.mas_equalTo(strongSelf.baseScrollView.mas_width);

        }];
    }
    return _cinemaMsgView;
}

//添加
- (void)addTapToView:(UIView *)view withSelector:(SEL)selector{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [view addGestureRecognizer:tap];
}

//点击影院信息
- (void)tapCinemaMsgView {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCCinemaDetailMsgVC *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CCCinemaDetailMsgVC class])];
    [self.navigationController pushViewController:vc animated:YES];
    
//    // 跳入选座
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
//    CCFilmSeatsDetailVC *vc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([CCFilmSeatsDetailVC class])];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 电影信息相关
- (CCCinemaDetailFilmsView *)filmsView {
    if (!_filmsView) {
        _filmsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCCinemaDetailFilmsView class]) owner:nil options:nil] lastObject];
        [self.baseScrollView addSubview:_filmsView];
        WEAKSELF(weakSelf)
        //内部控制了高度
        [_filmsView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONGSELF(strongSelf)
            make.left.right.equalTo(strongSelf.baseScrollView);
            make.top.mas_equalTo(strongSelf.cinemaMsgView.mas_bottom);
        }];
    }

    return _filmsView;
}





#pragma mark - 排期相关
- (CCCinemaDetailFilmsScheduleView *)scheculeView {
    if (!_scheculeView) {
        _scheculeView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCCinemaDetailFilmsScheduleView class]) owner:nil options:nil] lastObject];
        [self.baseScrollView addSubview:_scheculeView];
        //选中电影的事件
        WEAKSELF(weakSelf)
        _scheculeView.selectFilmBlock = ^(CCCinemaDetailFilmsScheduleView *view,NSIndexPath *indexPath) {
            STRONGSELF(strongSelf)
#warning 获取电影model
            CCCinemaDetailFilmsListModel *filmModel = [[CCCinemaDetailFilmsListModel alloc] init];
            [strongSelf selectFilm:filmModel];
        };

        //选中日期，获取该日期的电影信息
        _scheculeView.selectDateBlock = ^(CCCinemaDetailFilmsScheduleView *view,NSIndexPath *indexPath) {
            CCLog(@"选中了日期");
            //1,请求数据
            //2,根据数据显示界面
#warning 测试
            if (indexPath.item == 0) {  //有数据时

            }
            else if (indexPath.item == 1) { // 没有数据时

            }
        };

        //点击优惠提示view
        _scheculeView.tapTipsBlock = ^(CCCinemaDetailFilmsScheduleView *view){
            STRONGSELF(strongSelf)
            CCCinemaPreferentialTipsVC *vc = [[CCCinemaPreferentialTipsVC alloc] init];
            vc.title = @"优惠信息";
            [strongSelf.navigationController pushViewController:vc animated:YES];
        };

        // 内部控制了高度
        [_scheculeView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONGSELF(strongSelf)
            make.left.right.equalTo(strongSelf.baseScrollView);
            make.top.mas_equalTo(strongSelf.filmsView.mas_bottom).offset(10);
            make.bottom.mas_equalTo(strongSelf.baseScrollView.mas_bottom);
        }];
    }

    return _scheculeView;
}

//选中电影
- (void)selectFilm:(CCCinemaDetailFilmsListModel *)filmModel {


}

- (void)dealloc {

    CCLog(@"CCCinemaDetailVC dealloc");
}



@end
