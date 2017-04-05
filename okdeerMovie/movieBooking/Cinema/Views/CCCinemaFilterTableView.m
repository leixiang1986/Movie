//
//  CCCinemaFilterTableView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaFilterTableView.h"
#import "masonry.h"

@interface CCCinemaFilterTableView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CCCinemaFilterTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        [self addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = UIColorFromHex(COLOR_E2E2E2);
        WEAKSELF(weakSelf)
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONGSELF(strongSelf)
            make.edges.equalTo(strongSelf);
        }];
    }

    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

//显示到父控件上
- (void)showOnView:(UIView *)superView withDataSource:(NSArray *)dataSource withConstraintEdgeInsets:(UIEdgeInsets)edgeInsets{
    if (superView && [superView isKindOfClass:[UIView class]]) {
        if (superView != self.superview) {
            self.alpha = 0; //第一次加入才设置为0，没有被移除就不隐藏
            [superView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(superView).insets(edgeInsets);
            }];
        }

        self.dataSource = dataSource;
        self.hidden = NO;
        [superView bringSubviewToFront:self];
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    }
}

- (void)hideFromSuperView {
    if (self.superview) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
        cell.textLabel.textColor = UIColorFromHex(COLOR_999999);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.text = self.dataSource[indexPath.row];
    if (tableView.contentSize.height < tableView.height) {
        tableView.scrollEnabled = NO;
    }
    else {
        tableView.scrollEnabled = YES;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndexBlock) {
        self.selectIndexBlock(self,indexPath.row);
    }
}





@end
