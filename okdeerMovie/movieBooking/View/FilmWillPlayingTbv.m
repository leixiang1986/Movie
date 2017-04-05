//
//  FilmWillPlayingTbv.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "FilmWillPlayingTbv.h"
#import "CCHttpRequest+Movie.h"

@interface FilmWillPlayingTbv () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FilmWillPlayingTbv

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
    self.filmsDataList = filmsDataList;
    [self reloadData];
}

#pragma mark - /*** UITableViewDataSource ***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filmsDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TbvCellstr = @"FilmWillPlayingCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:TbvCellstr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TbvCellstr];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }
    }
    cell.textLabel.text = @"index";
    return cell;
}

#pragma mark - /*** UITableViewDelegate ***/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.filmsDataList.count < indexPath.row) {
        if (self.willPlayingTbvDidSelectBlock) {
            self.willPlayingTbvDidSelectBlock(self, self.filmsDataList[indexPath.row]);
        }
    }
}

@end
