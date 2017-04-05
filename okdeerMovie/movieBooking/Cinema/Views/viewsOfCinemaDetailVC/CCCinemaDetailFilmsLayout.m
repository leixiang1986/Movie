//
//  CCCinemaDetailFilmsLayout.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaDetailFilmsLayout.h"

//#define kItemMaxWidth   70.0
//#define kItemWidth      55.0
//#define kItemHeight     78.0
//#define kLineSpacing    40.0  //行与行之间的距离
//#define kScale          (kItemMaxWidth/kItemWidth)   //放大比例


@interface CCCinemaDetailFilmsLayout ()
@property (nonatomic, strong) NSIndexPath *oldSelectIndexPath;    //取消选中的indexPath
@end

@implementation CCCinemaDetailFilmsLayout

// 默认设置
- (void)setupDefault {
    self.minimumLineSpacing = 40;
    self.minimumInteritemSpacing = 30;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.scale = 1.0;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupDefault];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDefault];
    }

    return self;
}



-(void)prepareLayout {
    [super prepareLayout];

    self.sectionInset = UIEdgeInsetsMake(0, (self.collectionView.width - self.itemSize.width) / 2, 0, (self.collectionView.width - self.itemSize.width) / 2);
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {

    return [super collectionViewContentSize];
}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesArr = [[NSMutableArray alloc] init];
    CGFloat collectionViewCenterX = self.collectionView.contentOffset.x + CGRectGetMidX(self.collectionView.frame);
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSInteger selectIndex = 0;
    CGFloat lastMaxScale = 1;
//    NSArray *attrsArr = [super layoutAttributesForElementsInRect:rect];
    for ( NSInteger i = 0 ; i < count ; i++) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];

        CGFloat space = attribute.center.x - collectionViewCenterX; //距离中点的距离
        if (ABS(space) < self.itemSize.width + self.lineSpacing) {
            CGFloat scale = 1 + (self.scale - 1) * (((self.itemSize.width + self.lineSpacing) - ABS(space)) / (self.itemSize.width + self.lineSpacing));
            if (scale > lastMaxScale) {
                lastMaxScale = scale;
                selectIndex = i;
                CCLog(@"最大的index:%ld",selectIndex);
            }
            CCLog(@"i的大小:%ld",i);
            attribute.transform = CGAffineTransformMakeScale(scale, scale);
        }
        else {
            attribute.transform = CGAffineTransformIdentity;
        }
        [attributesArr addObject:attribute];
    }
    if (self.filmsLayoutSelectIndexPathBlock) {
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForItem:selectIndex inSection:0];
        if (self.oldSelectIndexPath) {
            if (self.oldSelectIndexPath.item != selectIndex) {
                self.filmsLayoutSelectIndexPathBlock(self,selectIndexPath,self.oldSelectIndexPath);
                self.oldSelectIndexPath = selectIndexPath;
            }
        }
        else {
            self.filmsLayoutSelectIndexPathBlock(self,selectIndexPath,self.oldSelectIndexPath);
            self.oldSelectIndexPath = selectIndexPath;
        }
    }


    return attributesArr;
}



- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    CGFloat lastRectCenterX = lastRect.origin.x + lastRect.size.width / 2;
    NSArray *attrsArr = [self layoutAttributesForElementsInRect:lastRect];
    CGFloat adjustOffsetX = MAXFLOAT;   //调整的距离
    for (UICollectionViewLayoutAttributes *attrs in attrsArr) {
        if (ABS(adjustOffsetX) > ABS(attrs.center.x - lastRectCenterX)) {
            adjustOffsetX = attrs.center.x - lastRectCenterX;
        }
    }
    CCLog(@"withScrollingVelocity%@",NSStringFromCGRect(lastRect));
    NSLog(@"targetContentOffsetForProposedContentOffset:%@----%@",NSStringFromCGPoint(CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y)),NSStringFromCGPoint(proposedContentOffset));
    return  CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}

@end
