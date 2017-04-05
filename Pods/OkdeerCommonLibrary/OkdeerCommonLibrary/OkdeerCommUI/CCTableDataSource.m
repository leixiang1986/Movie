//
//  CCTableDataSource.m
//  CloudCity
//
//  Created by Mac on 15/10/28.
//  Copyright © 2015年 YsChome. All rights reserved.
//

#import "CCTableDataSource.h"

@interface CCTableDataSource ()

@property (nonatomic, strong) NSArray *itemArray;  
@property (nonatomic, strong) Class cellCalss;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellTypeBlock cellTypeBlock;

@end

@implementation CCTableDataSource

/**
 *  初始化  datasource
 *
 *  @param className     cell 对象 的字符串
 *  @param itemArray     数据源
 *  @param Identifier    标志
 *  @param cellTypeBlock 回调
 */
- (instancetype)initWithClass:(NSString *)className itemAray:(NSArray *)itemArray cellIdentifier:(NSString *)identifier cellType:(CellTypeBlock)cellTypeBlock
{
    self = [super init];
    if (self) {
        _cellCalss = NSClassFromString(className);
        if (!_cellCalss) {
            
        }
        _itemArray = itemArray;
        _cellIdentifier = identifier;
        _cellTypeBlock = cellTypeBlock;
    }
    return self;
}

/**
 *  获取数组中的元素
 */
- (id)itemForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _itemArray.count) {
        return _itemArray[(NSUInteger)indexPath.row];
    }else{
        return nil;
    }
}

/**
 *  赋值
 *
 */
- (void)loadItemData:(NSArray *)itemArray
{
    _itemArray = itemArray;
}

#pragma mark ---dataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_itemArray.count != 0 ) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_itemArray.count != 0 ) {
        return _itemArray.count;
    }
    return 0;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell;
    if (self.isXib) {
        cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath]; 
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
        if (!cell) {
            if (_cellCalss && [_cellCalss isSubclassOfClass:[UITableViewCell class]]) {
                cell = [[_cellCalss alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentifier];
            }
        }
    }
    id item = [self itemForIndexPath:indexPath];
    if (_cellTypeBlock) {
        _cellTypeBlock (cell,item);
    }
    return cell;
}

@end
