//
//  CCMoviesViewController.m
//  okdeerMovie
//
//  Created by Mac on 16/12/12.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCMoviesViewController.h"
#import "CCCinemaFilterView.h"
#import "masonry.h"
#import "CCMovieTableCell.h"
#import "CCCinemaFilterTableView.h"
#import "CCCinemaDetailVC.h"

@interface CCMoviesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CCCinemaFilterView *filterBtnView;    //筛选的按钮底部view
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) CCMovieTableCell *baseCell;
@property (strong, nonatomic) CCCinemaFilterTableView *filterTableView;             //点击筛选按钮点击时，展示的筛选数据列表
@end

@implementation CCMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"影院";
    [self setupDefaultUI];

}

- (void)setupDefaultUI {
    [self filterBtnView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (iOS8UP) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 60;
    }
    else {
        _tableView.rowHeight = 60;
        _baseCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCMovieTableCell class]) owner:nil options:nil] lastObject];
    }
}


#pragma mark - 筛选相关
//筛选的按钮底部view
- (CCCinemaFilterView *)filterBtnView {
    if (!_filterBtnView) {
        _filterBtnView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCCinemaFilterView class]) owner:nil options:nil] lastObject];
        _filterBtnView.frame = CGRectMake(10, 50, 200, 50);
        [self.view addSubview:_filterBtnView];
        WEAKSELF(weakSelf)
        _filterBtnView.selectBlock = ^(CCCinemaFilterView *filterView,CCCinemaFilterViewSelectType selectedIndex,CCCinemaFilterViewSelectType oldSelectedIndex){
            STRONGSELF(strongSelf)
            if (selectedIndex == CCCinemaFilterViewSelectTypeLeft) {
                [strongSelf filterViewLeftClick];
            }
            else if (selectedIndex == CCCinemaFilterViewSelectTypeRight) {
                [strongSelf filterViewRightClick];
            }
        };
        [_filterBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONGSELF(strongSelf)
            make.left.right.top.equalTo(strongSelf.view);
            make.height.mas_equalTo(45);
        }];
    }

    return _filterBtnView;
}

//筛选的tableView
- (CCCinemaFilterTableView *)filterTableView {
    if (!_filterTableView) {
        _filterTableView = [[CCCinemaFilterTableView alloc] initWithFrame:CGRectMake(0, self.filterBtnView.height, self.tableView.width, kFullScreenHeight - kStatusBarAndNavigationBarHeight - self.filterBtnView.height)];
//        [self.tabBarController.view addSubview:_filterTableView];
        WEAKSELF(weakSelf)
        _filterTableView.selectIndexBlock = ^(CCCinemaFilterTableView *filterTableView,NSInteger index) {
            STRONGSELF(strongSelf)
            if (strongSelf.filterBtnView.selectedIndex == CCCinemaFilterViewSelectTypeLeft) {    //左面的筛选
                [strongSelf.filterTableView hideFromSuperView];
                [strongSelf.filterBtnView setSelect:NO atIndex:(CCCinemaFilterViewSelectTypeLeft)];
                CCLog(@"左侧点击筛选");
#warning 测试
                strongSelf.filterBtnView.leftBtnTitle = @"那山区";
            }
            else if (strongSelf.filterBtnView.selectedIndex == 1) {  //右边的筛选
                [strongSelf.filterTableView hideFromSuperView];
                [strongSelf.filterBtnView setSelect:NO atIndex:(CCCinemaFilterViewSelectTypeRight)];
                CCLog(@"右侧点击筛选");
                strongSelf.filterBtnView.rightBtnTitle = @"价格由高到低";
            }
        };
    }

    return _filterTableView;
}


#pragma mark - action
//左侧筛选按钮的点击事件
- (void)filterViewLeftClick{
    if (self.filterBtnView.oldSelectedIndex == CCCinemaFilterViewSelectTypeLeft) {
        [self.filterTableView hideFromSuperView];
    }
    else {
        [self.filterTableView showOnView:self.tabBarController.view withDataSource:@[@"123",@"456",@"123",@"456",@"123",@"456",@"123",@"456",@"123",@"456",@"123",@"456",@"123",@"456"] withConstraintEdgeInsets:UIEdgeInsetsMake(self.filterBtnView.height + kStatusBarAndNavigationBarHeight, 0, 0, 0)];
    }
}

//右侧按钮的点击事件
- (void)filterViewRightClick {
    CCLog(@"%ld====sd==",self.filterBtnView.oldSelectedIndex);
    if (self.filterBtnView.oldSelectedIndex == CCCinemaFilterViewSelectTypeRight) {
        [self.filterTableView hideFromSuperView];
    }
    else {
        [self.filterTableView showOnView:self.tabBarController.view withDataSource:@[@"距离由近到远",@"价格由低到高"] withConstraintEdgeInsets:UIEdgeInsetsMake(self.filterBtnView.height + kStatusBarAndNavigationBarHeight, 0, 0, 0)];
    }

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning 测试
    return 10;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CCMovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CCMovieTableCell class])];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCMovieTableCell class]) owner:nil options:nil] lastObject];
    }
#warning 测试
    if (!(indexPath.row % 3)) {
        [cell hideFavourate:YES];
    }
    else {
        [cell hideFavourate:NO];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (iOS8UP) {
        return UITableViewAutomaticDimension;
    }
    else {
        [self configureCell:_baseCell atIndexPath:indexPath];
        [_baseCell layoutSubviews];
        CGFloat height = [_baseCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height + 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CCCinemaDetailVC *vc = [[CCCinemaDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configureCell:(CCMovieTableCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    TrainticketModel *model = self.ticketModels[indexPath.row];
//    cell.ticketModel = model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
