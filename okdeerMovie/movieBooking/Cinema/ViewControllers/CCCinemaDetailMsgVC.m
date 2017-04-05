//
//  CCCinemaDetailMsgVC.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailMsgVC.h"
#import "CCCinemaDetailMsgSeatCollectionCell.h"
#import "CCFilmCinemaMapVC.h"

@interface CCCinemaDetailMsgVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *busLabel;
@property (weak, nonatomic) IBOutlet UILabel *subwayLabel;
@property (weak, nonatomic) IBOutlet UILabel *bussinessLabel;
@property (weak, nonatomic) IBOutlet UILabel *glasses3DLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightConstraint;

@end

@implementation CCCinemaDetailMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupDefaultUI];
    
    // --- address label
    [self addTapRecognizerForAddresslabel];
}

- (void)setupDefaultUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNavigation)];
    [self.addressLabel addGestureRecognizer:tap];


    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CCCinemaDetailMsgSeatCollectionCell class]) bundle:nil];

    [_collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([CCCinemaDetailMsgSeatCollectionCell class])];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    CGFloat itemSizeWidth = (kFullScreenWidth - 4 * 12) / 3;
    CGFloat itemSizeHeight = 26;
    if (kFullScreenWidth == 320) {
        itemSizeWidth = (kFullScreenWidth - 3 * 20) / 2;
        itemSizeHeight = 26;
    }

    flowLayout.itemSize = CGSizeMake(itemSizeWidth, itemSizeHeight);
    _collectionView.collectionViewLayout = flowLayout;

}


- (void)gotoNavigation {
    CCLog(@"点击导航");

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CCCinemaDetailMsgSeatCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CCCinemaDetailMsgSeatCollectionCell class]) forIndexPath:indexPath];

    if (collectionView.contentSize.height > 0) {
        self.collectionHeightConstraint.constant = collectionView.contentSize.height;
    }

    return cell;
}

#pragma mark - /*** 跳转到影院地图 ***/
- (void)addTapRecognizerForAddresslabel
{
    self.addressLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popToCinemaMapVC)];
    [self.addressLabel addGestureRecognizer:recog];
}

- (void)popToCinemaMapVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCFilmCinemaMapVC *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"CCFilmCinemaMapVC"];
    mapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVC animated:YES];
}

@end
