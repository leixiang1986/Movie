//
//  CCTableDataSource.h
//  CloudCity
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 YsChome. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CellTypeBlock)(id cell, id item);

@interface CCTableDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, assign,getter=isXib) BOOL xib;     /**< 是否xib*/

/**
 *  初始化  datasource
 *
 *  @param className     cell 对象 的字符串
 *  @param itemArray     数据源
 *  @param identifier    标志
 *  @param cellTypeBlock 回调
 */
- (instancetype)initWithClass:(NSString *)className itemAray:(NSArray *)itemArray cellIdentifier:(NSString *)identifier cellType:(CellTypeBlock)cellTypeBlock;

/**
 *  获取数组中的元素
 */
- (id)itemForIndexPath:(NSIndexPath *)indexPath;
/**
 *  赋值
 *
 */
- (void)loadItemData:(NSArray *)itemArray;

@end
