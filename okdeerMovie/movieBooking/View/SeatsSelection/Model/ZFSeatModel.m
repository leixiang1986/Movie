//
//  ZFSeatModel.m
//  ZFSeatSelection
//
//  Created by © 2016年 qq 316917975  on 16/7/12.
//
//

#import "ZFSeatModel.h"

@implementation ZFSeatModel

+(instancetype)modelObjectWithDictionary:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.seatNo = DicGetValueIsClass(dic, @"seatNo", kString);
        self.columnId = DicGetValueIsClass(dic, @"columnId", kString);
        self.st = DicGetValueIsClass(dic, @"st", kString);
    }
    return self;
}

@end
