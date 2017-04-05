//
//  CCFilmDetailCinemaSubVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmDetailCinemaSubVC.h"
#import "CCMovieTableCell.h"
#import "CCCinemaDetailVC.h"

@interface CCFilmDetailCinemaSubVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CCCustomTableView *cinemaInfoTbv;

@end

@implementation CCFilmDetailCinemaSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];
}

#pragma mark - /*** 请求数据 ***/
- (void)requestCinemaData
{
    CCLog(@"rqeust--Data");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /*** UITableViewDelegate/UITableViewDataSource ***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cinemaInfoCell = @"CCMovieTableCell";
    CCMovieTableCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cinemaInfoCell];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CCMovieTableCell" owner:nil options:nil];
        cell = [nibs firstObject];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_viewController) {
        CCCinemaDetailVC *vc = [[CCCinemaDetailVC alloc] init];
        [_viewController.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - /*** 初始化UI ***/
- (void)initViews
{
    [self.view addSubview:self.cinemaInfoTbv];
}

- (CCCustomTableView *)cinemaInfoTbv
{
    if (!_cinemaInfoTbv) {
        _cinemaInfoTbv = [[CCCustomTableView alloc] initWithFrame:CGRectMake(CCNumberTypeOf0, CCNumberTypeOf0, kFullScreenWidth, self.view.frame.size.height)];
        _cinemaInfoTbv.dataSource = self;
        _cinemaInfoTbv.delegate = self;
        if ([_cinemaInfoTbv respondsToSelector:@selector(setSeparatorInset:)]) {
            _cinemaInfoTbv.separatorInset = UIEdgeInsetsZero;
        }
        if ([_cinemaInfoTbv respondsToSelector:@selector(setLayoutMargins:)]) {
            _cinemaInfoTbv.layoutMargins = UIEdgeInsetsZero;
        }
        _cinemaInfoTbv.tableFooterView = [UIView new];
        
        WEAKSELF(weakSelf);
        _cinemaInfoTbv.headerRefereshBlock = ^(CCCustomTableView *tableView,NSInteger currentPage){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf requestCinemaData];
            }
        };
        
        _cinemaInfoTbv.footerRefreshBlock = ^(CCCustomTableView *tableView,NSInteger index,ResultBlock resultBlock){
            STRONGSELF(strongSelf);
            if (strongSelf) {
                [strongSelf requestCinemaData];
            }
        };
    }
    return _cinemaInfoTbv;
}

@end
