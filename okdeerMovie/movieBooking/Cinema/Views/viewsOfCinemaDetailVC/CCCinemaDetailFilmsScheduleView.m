//
//  CCCinemaDetailFilmsScheduleView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/15.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsScheduleView.h"
#import "CCCinemaDetailScaduleFilmsCell.h"
#import "CCCinemaDetailFilmsDateCollectionViewCell.h"
#import "CCCinemaDetailFilmsScheduleView.h"
#import "CCNoDataView.h"
#import "CCCinemaDetailFilmsSceduleModel.h"
#import "CCCinemaDetailFilmsScheduleDateModel.h"


#define kDateItemWidth  100

@interface CCCinemaDetailFilmsScheduleView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *dateCollectionView;  //选择日期的collectionView
@property (strong, nonatomic) UIView *dateSeleceView;                       //日期的选中view

@property (weak, nonatomic) IBOutlet UIView *tipsView;                      //提示信息的view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipsLineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *tipsContentLabel;
@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;
@property (strong, nonatomic) CCCinemaDetailScaduleFilmsCell *baseCell;
@property (strong, nonatomic) CCCinemaDetailFilmsScheduleView *noScheduleView;  // 没有排片或已播放完
@property (strong, nonatomic) CCNoDataView *nodataView; //没有请求到数据


@end

@implementation CCCinemaDetailFilmsScheduleView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupDateCollectionViewDefault];
    [self setupTipsDefault];
    [self setupScheduleTableViewDefault];
}




- (void)setScheduleModel:(CCCinemaDetailFilmsSceduleModel *)scheduleModel {
    _scheduleModel = scheduleModel;

}


#pragma mark - 选择日期相关
//日期的默认设置
- (void)setupDateCollectionViewDefault {
    _dateCollectionView.delegate = self;
    _dateCollectionView.dataSource = self;
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing = 0;

    flowlayout.itemSize = CGSizeMake(kDateItemWidth, 34);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _dateCollectionView.collectionViewLayout = flowlayout;
    [_dateCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CCCinemaDetailFilmsDateCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CCCinemaDetailFilmsDateCollectionViewCell class])];
    _dateCollectionView.showsHorizontalScrollIndicator = NO;

    self.tipsLineViewHeightConstraint.constant = ScreenGridViewHeight;


    [_dateCollectionView addSubview:self.dateSeleceView];
}

- (UIView *)dateSeleceView {
    if (!_dateSeleceView) {
        _dateSeleceView = [[UIView alloc] initWithFrame:CGRectMake(0, _dateCollectionView.height - 2, kDateItemWidth, 2)];
        _dateSeleceView.backgroundColor = UIColorFromHex(COLOR_8CC63F);

    }

    return _dateSeleceView;
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning 测试
    return 7;

    return self.dateArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CCCinemaDetailFilmsDateCollectionViewCell";
    CCCinemaDetailFilmsDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    CCCinemaDetailFilmsScheduleDateModel *model = self.dateArr[indexPath.item];
    [cell setDate:model.showDate select:model.isSelect];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //设置日期选中UI
    CGFloat x = (indexPath.item) * kDateItemWidth - (collectionView.width - kDateItemWidth) / 2 ; //中点
    x = x > 0 ? x : 0;
    CGPoint contentOffset = CGPointMake(x ,collectionView.contentOffset.y);
    [collectionView setContentOffset:contentOffset animated:YES];

    CCCinemaDetailFilmsDateCollectionViewCell *cell = (CCCinemaDetailFilmsDateCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    [UIView animateWithDuration:0.2 animations:^{
        self.dateSeleceView.frame = CGRectMake(cell.x , collectionView.height - 2, cell.width, 2);
    }];

    //数据选中的数据处理
    CCLog(@"选中日期的数据处理");
    
}



#pragma mark - 提示信息相关
//提示信息的默认设置
- (void)setupTipsDefault {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTipsClick)];
    [self.tipsView addGestureRecognizer:tap];

}

//点击优惠提示
- (void)tapTipsClick {
    if (self.tapTipsBlock) {
        self.tapTipsBlock(self);
    }
}




#pragma mark - tableView 相关
//tableView的默认设置
- (void)setupScheduleTableViewDefault {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CCCinemaDetailScaduleFilmsCell class]) bundle:nil];
    [_scheduleTableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([CCCinemaDetailScaduleFilmsCell class])];
    _scheduleTableView.separatorColor = UIColorFromHex(COLOR_E2E2E2);
    if (iOS8UP) {
        _scheduleTableView.rowHeight = UITableViewAutomaticDimension;
        _scheduleTableView.estimatedRowHeight = 60;
    }
    else {
        _scheduleTableView.rowHeight = 60;
        _baseCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CCCinemaDetailScaduleFilmsCell class]) owner:nil options:nil] lastObject];
    }
}

// 更新tableView的contentSize
- (void)updateTableViewContentSize:(CGSize)tableViewContentSize {
    self.tableViewHeightConstraint.constant = tableViewContentSize.height;
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning 暂时关闭
//    if (!self.dataSource.count) {   //没有的时候tableViewContentSize设置为一定
//        [self updateTableViewContentSize:CGSizeMake(tableView.width, 100)];
//    }

#warning 测试

    return 10;
    return self.scheduleModel.filmList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCCinemaDetailScaduleFilmsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CCCinemaDetailScaduleFilmsCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //更新contentSize
    [self updateTableViewContentSize:tableView.contentSize];
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
    if (self.selectFilmBlock) {
        self.selectFilmBlock(self,indexPath);
    }
    CCLog(@"选择了某场电影");
}

- (void)configureCell:(CCCinemaDetailScaduleFilmsCell *)cell atIndexPath:(NSIndexPath *)indexPath {


}

@end
