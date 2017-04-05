//
//  CCMovieMainTabbarVC.m
//  okdeerMovie
//
//  Created by Mac on 16/12/13.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCMovieMainTabbarVC.h"

@interface CCMovieMainTabbarVC ()

@end

@implementation CCMovieMainTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromHex(COLOR_F5F6F8);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // --- 在外面隐藏掉 导航栏
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
