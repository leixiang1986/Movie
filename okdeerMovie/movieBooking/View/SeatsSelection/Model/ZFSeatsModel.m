//
//  ZFSeatsModel.m
//  ZFSeatSelection
//
//  Created by © 2016年 qq 316917975  on 16/7/12.
//
//

#import "ZFSeatsModel.h"
#import "ZFSeatModel.h"

@implementation ZFSeatsModel

+(instancetype)modelObjectWithDictionary:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        NSArray *columnsArray = DicGetValueIsClass(dic, @"columns", kArray);
        NSMutableArray *newArray = [NSMutableArray new];
        for (NSDictionary *newDic in columnsArray) {
            ZFSeatModel *model = [ZFSeatModel modelObjectWithDictionary:newDic];
            [newArray addObject:model];
        }
        self.columns = newArray;
        
        self.rowId = DicGetValueIsClass(dic, @"rowId", kString);
        self.rowNum = DicGetValueIsClass(dic, @"rowNum", kString);
    }
    return self;
}

@end
