//
//  FilmOnPlayingTbv.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "FilmOnPlayingTbv.h"
#import "CCFilmOnWillPlayingTbvCell.h"

@interface FilmOnPlayingTbv () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FilmOnPlayingTbv

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)setFilmsDataList:(NSArray *)filmsDataList
{
    _filmsDataList = filmsDataList;
    [self reloadData];
}

#pragma mark - /*** UITableViewDataSource ***/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filmsDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TbvCellstr = @"CCFilmOnWillPlayingTbvCell";
    CCFilmOnWillPlayingTbvCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:TbvCellstr];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CCFilmOnWillPlayingTbvCell" owner:nil options:nil];
        cell = [nibs firstObject];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    
    // 数据
    if (indexPath.row < self.filmsDataList.count) {
        cell.listModel = nil;
    }
    
    WEAKSELF(weakSelf);
    /**
     *  点击 购买/预售 按钮
     */
    cell.filmBuyBtnClciked = ^(CCFilmOnWillPlayingTbvCell *cell){
        STRONGSELF(strongSelf);
        if (strongSelf) {
            if (strongSelf.onPlayingTbvFilmBuyBlock) {
                strongSelf.onPlayingTbvFilmBuyBlock(self, cell.listModel);
            }
        }
    };
    
    return cell;
}

#pragma mark - /*** UITableViewDelegate ***/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.filmsDataList.count) {
        if (self.onPlayingTbvDidSelectBlock) {
            self.onPlayingTbvDidSelectBlock(self, self.filmsDataList[indexPath.row]);
        }
    }
}

@end
