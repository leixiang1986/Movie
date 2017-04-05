//
//  CCFilmDetailCinemaVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmDetailCinemaVC.h"
#import "FilmCinemaDateCollectionCell.h"
#import "CCFilmDetailCinemaSubVC.h"

@interface CCFilmDetailCinemaVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *filmDateCollectionView;      /**< 日期CollectionView */
@property (weak, nonatomic) IBOutlet UIScrollView *filmDateCinemaScrollV;

@property (nonatomic, strong) UIView *seplineView;      /**< 分割线 */
@property (nonatomic, strong) NSMutableArray *childVCArray;     /**< 存储子控制器 */
@property (nonatomic, strong) NSMutableArray *dateCountArray;       /**< 日期源数据 */

@end

@implementation CCFilmDetailCinemaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"那年那兔那些事";
    
    self.dateCountArray = [NSMutableArray new];
    self.childVCArray = [NSMutableArray new];
    [self.dateCountArray addObjectsFromArray:[NSArray arrayWithObjects:@"12月16日",@"12月17日",@"12月18日",@"12月19日",@"12月20日", nil]];
    //初始化UI
    [self initViews];
    //初始化VC
    [self initScrollAndSubVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /*** 事件处理 ***/
- (void)collectionViewDidIndex:(NSInteger)index
{
    if (index < [self.childVCArray count]) {
        CCFilmDetailCinemaSubVC *subVC = [self.childVCArray objectAtIndex:index];
        if (subVC) {
            [subVC requestCinemaData];
            [_filmDateCinemaScrollV setContentOffset:CGPointMake(kFullScreenWidth * index, 0) animated:NO];
        }
    }
}

#pragma mark - /*** UICollectionViewDelegate/UICollectionViewDataSource ***/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dateCountArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilmCinemaDateCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilmCinemaDateCollectionCell" forIndexPath:indexPath];
    cell.filmDatelabel.text = [self.dateCountArray objectAtIndex:indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilmCinemaDateCollectionCell *cell = (FilmCinemaDateCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    if (cell.center.x > kFullScreenWidth/2) {
//        if (indexPath.row <= self.dateCountArray.count - 2) {
//            [self.filmDateCollectionView setContentOffset:CGPointMake(cell.center.x - kFullScreenWidth/2, 0) animated:YES];
//        }
//    }
//    else {
//        [self.filmDateCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.seplineView setFrame:CGRectMake(cell.left, CCNumberTypeOf42, CCNumberTypeOf100, CCNumberTypeOf2)];
    }];
    
    // --- 滚动到对应的页面去
    [self collectionViewDidIndex:indexPath.row];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 44);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)sectio
{
    return 0;
}

#pragma mark - /*** 初始化UI ***/
- (void)initViews
{
    self.filmDateCollectionView.dataSource = self;
    self.filmDateCollectionView.delegate = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.filmDateCollectionView.showsHorizontalScrollIndicator = NO;
    self.filmDateCollectionView.showsVerticalScrollIndicator = NO;
    [self.filmDateCollectionView setCollectionViewLayout:layout];
    
    self.filmDateCollectionView.contentSize = CGSizeMake([self.dateCountArray count] * CCNumberTypeOf100, 0);
    [self.filmDateCollectionView addSubview:self.seplineView];
}

- (void)initScrollAndSubVC
{
    for (int index = 0; index < [self.dateCountArray count]; index ++) {
        CCFilmDetailCinemaSubVC *subVC = [[CCFilmDetailCinemaSubVC alloc] init];
        [self.childVCArray addObject:subVC];
        subVC.view.frame = CGRectMake(kFullScreenWidth * index, CCNumberTypeOf0, kFullScreenWidth, _filmDateCinemaScrollV.height);
        subVC.viewController = self;
        subVC.view.tag = index;
        [self addChildViewController:subVC];
        
        //获取数据
        if (index == 0) {
            [subVC requestCinemaData];
        }
        [self.filmDateCinemaScrollV addSubview:subVC.view];
    }
    self.filmDateCinemaScrollV.contentSize = CGSizeMake(0, 0);
}

- (UIView *)seplineView
{
    if (!_seplineView) {
        _seplineView = [[UIView alloc] initWithFrame:CGRectMake(CCNumberTypeOf0, CCNumberTypeOf42, CCNumberTypeOf100, CCNumberTypeOf2)];
        _seplineView.backgroundColor = UIColorFromHex(COLOR_8CC63F);
    }
    return _seplineView;
}

@end
