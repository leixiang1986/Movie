//
//  CCCinemaDetailFilmsView.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsView.h"
#import "CCCinemaDetailFilmsLayout.h"
#import "CCCinemaDetailFilmsCollectionViewCell.h"
#import "UIImage+vImage.h"

@interface CCCinemaDetailFilmsView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) CCCinemaDetailFilmsLayout *layout;
@property (weak, nonatomic) IBOutlet UILabel *filmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *discriptionLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation CCCinemaDetailFilmsView

- (void)awakeFromNib {
    [super awakeFromNib];

    CCCinemaDetailFilmsLayout *layout = [[CCCinemaDetailFilmsLayout alloc] init];
    layout.scale = 70 / 55.0;
    layout.itemSize = CGSizeMake(55, 78);
    _layout = layout;
    //放大到最大的item index
    layout.filmsLayoutSelectIndexPathBlock = ^(CCCinemaDetailFilmsLayout *layout,NSIndexPath *selectIndexPath, NSIndexPath *unselectIndexPath) {
        //设置选中item的边框
        CCCinemaDetailFilmsCollectionViewCell *selectCell = (CCCinemaDetailFilmsCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
        if (selectCell) {
            [self setupSelectCellBorder:selectCell];
            selectCell.score = @"8.7";
        }
        //取消非选中item的边框
        CCCinemaDetailFilmsCollectionViewCell *unselectCell = (CCCinemaDetailFilmsCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:unselectIndexPath];
        if (unselectCell) {
            [self setupUnSelectCellBorder:unselectCell];
            unselectCell.score = @"";
        }
    };

    [_collectionView setCollectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CCCinemaDetailFilmsCollectionViewCell class]) bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([CCCinemaDetailFilmsCollectionViewCell class])];

#warning 测试
    _backImageView.image = [UIImage boxblurImage:_backImageView.image withBlurNumber:0.2];

}




//设置cell的选中边框
- (void)setupSelectCellBorder:(UICollectionViewCell *)cell {
    if (cell) {
        [cell setSystemCorneradius:0 withColor:[UIColor whiteColor] withBorderWidth:ScreenGridViewHeight * 2];
    }
}

//设置cell的非选中边框
- (void)setupUnSelectCellBorder:(UICollectionViewCell *)cell {
    if (cell) {
        [cell setSystemCorneradius:0 withColor:[UIColor whiteColor] withBorderWidth:0.0001];    //边框宽度因内部判断是否为0，非零才设置，所以设置为一个很小的非零数
    }
}

- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    _backImageView.image = [UIImage boxblurImage:backImage withBlurNumber:0.2];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCCinemaDetailFilmsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CCCinemaDetailFilmsCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];

    if (indexPath.item == 0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self setupSelectCellBorder:cell]; //第一个选中设置边框
            cell.score = @"8.7";
        });
    }

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    CCLog(@"====%@",NSStringFromCGPoint(CGPointMake((_layout.minimumLineSpacing + _layout.itemSize.width) * indexPath.item, collectionView.contentOffset.y)));
    [collectionView setContentOffset:CGPointMake((_layout.minimumLineSpacing + _layout.itemSize.width) * indexPath.item, collectionView.contentOffset.y) animated:YES];
#warning 测试
    self.backImageView.image = [UIImage boxblurImage:[UIImage imageNamed:@"moviebooking_imax3d"] withBlurNumber:0.2];
}





-(void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;

    CCLog(@"CCCinemaDetailFilmsView dealloc");
}

@end
