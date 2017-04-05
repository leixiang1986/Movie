//
//  CCFilmOrderListVC.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmOrderListVC.h"
#import "CCFilmOrderListCell.h"
#import "CCFilmOrderDetailVC.h"

@interface CCFilmOrderListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) CCCustomTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation CCFilmOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];


}

#pragma mark - 初始化
- (CCCustomTableView *)tableView {
    if (!_tableView) {
        _tableView = [[CCCustomTableView alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kFullScreenHeight - kStatusBarAndNavigationBarHeight) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = UIColorFromHex(COLOR_F5F6F8);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.headerRefereshBlock = ^(CCCustomTableView *tableView,NSInteger page) {

            CCLog(@"下拉刷新");
        };

        _tableView.footerRefreshBlock = ^(CCCustomTableView *tableView,NSInteger currentPage,ResultBlock resultBlock) {
            CCLog(@"上拉加在更多%ld",currentPage);

        };

        [self.view addSubview:_tableView];
    }

    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }

    return _dataSource;
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

#warning 测试
    return 10;
    return self.dataSource;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CCFilmOrderListCell";
    CCFilmOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCFilmOrderListCell class]) owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 180;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CCFilmOrderDetailVC *detailVC = [[CCFilmOrderDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
