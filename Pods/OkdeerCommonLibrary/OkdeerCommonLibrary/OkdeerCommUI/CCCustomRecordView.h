//
//  CCCustomRecordView.h
//  CloudCity
//
//  Created by Mac on 15/7/6.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCustomRecordView : UIView

@property (nonatomic, strong) NSArray *titleArray;      //数据源

@property (nonatomic, copy) void (^didClickTagAtString)(NSString *title);   //点击触发事件
@property (nonatomic, copy) void (^didTaprecoginizer)();                //手指点击事件
@property (nonatomic, copy) void (^didClickDelAllSource)();                //清除历史记录事件
@end
