//
//  CCCinemaLinesTbv.m
//  okdeerMovie
//
//  Created by Mac on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaLinesTbv.h"
#import "CCFilmCinemaMapLineDetailVC.h"
#import "CCNaviLineTableCell.h"

@interface CCCinemaLinesTbv () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CCCinemaLinesTbv

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            self.separatorInset = UIEdgeInsetsZero;
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark - /*** 获取数据 ***/
- (void)requestData:(CinemaLineType)lineType
{
    [self reloadData];
}

#pragma mark - /*** UITableViewDelegate ***/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cinemaInfoCell = @"CCNaviLineTableCell";
    CCNaviLineTableCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cinemaInfoCell];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CCNaviLineTableCell" owner:nil options:nil];
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
    if (self.cinemaLineBlock) {
        self.cinemaLineBlock(CinemaLineType_bus, nil, nil, nil);
    }
}


@end
