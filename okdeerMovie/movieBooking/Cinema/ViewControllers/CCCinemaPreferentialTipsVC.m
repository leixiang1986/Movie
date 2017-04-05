//
//  CCCinemaPreferentialTipsVC.m
//  okdeerMovie
//
//  Created by 雷祥 on 16/12/16.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCCinemaPreferentialTipsVC.h"

@interface CCCinemaPreferentialTipsVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CCCinemaPreferentialTipsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_content) {
        _textView.text = _content;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
