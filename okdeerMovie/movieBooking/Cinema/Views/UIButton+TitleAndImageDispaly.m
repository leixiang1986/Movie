//
//  UIButton+TitleAndImageDispaly.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

//gongyong
#import "UIButton+TitleAndImageDispaly.h"
#import <objc/runtime.h>

@implementation UIButton (TitleAndImageDispaly)

//static const char MJRefreshHeaderKey = '\0';
//- (void)setMj_header:(MJRefreshHeader *)mj_header
//{
//    if (mj_header != self.mj_header) {
//        // 删除旧的，添加新的
//        [self.mj_header removeFromSuperview];
//        [self insertSubview:mj_header atIndex:0];
//
//        // 存储新的
//        [self willChangeValueForKey:@"mj_header"]; // KVO
//        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
//                                 mj_header, OBJC_ASSOCIATION_ASSIGN);
//        [self didChangeValueForKey:@"mj_header"]; // KVO
//    }
//}

static const char CCTitleAndImageDispalySpaceKey = '\0';
-(void)setSpace:(CGFloat)space {
    if (space != self.space) {
        [self willChangeValueForKey:@"space"];
//        objc_setAssociatedObject(self, &CCTitleAndImageDispalySpaceKey,space, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"space"];
    }

}

@end
