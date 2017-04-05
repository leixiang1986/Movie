//
//  CCCustomActionTableViewCell.h
//  CloudCity
//
//  Created by 雷祥 on 16/1/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCustomActionTableViewCell : UITableViewCell
@property (nonatomic,assign) BOOL hidenLine;    // 是否显示分割线
@property (nonatomic,copy) NSString *content;
@end
