//
//  CCFilmDetailsViewController.m
//  okdeerMovie
//
//  Created by Mac on 16/12/14.
//  Copyright © 2016年 okdeer. All rights reserved.
//

#import "CCFilmDetailsViewController.h"
#import "CCHttpRequest+Movie.h"
#import "CCFilmDetailCinemaVC.h"
#import <iCarousel.h>

@interface CCFilmDetailsViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *movieBuyBtnHeightConstraints;  /**< 购买 高度约束 */
@property (weak, nonatomic) IBOutlet UIImageView *movieIconImgV;    /**< 电影logo */
@property (weak, nonatomic) IBOutlet UILabel *moviewNamelabel;      /**< 电影名称 */
@property (weak, nonatomic) IBOutlet UILabel *movieTypelabel;       /**< 电影类型 */
@property (weak, nonatomic) IBOutlet UIView *movieStarsView;        /**< 电影星级 */
@property (weak, nonatomic) IBOutlet UILabel *movieGradelabel;      /**< 电影评分 */
@property (weak, nonatomic) IBOutlet UIView *movieDescrilabel;      /**< 电影描述 */
@property (weak, nonatomic) IBOutlet UILabel *movieTimelabel;       /**< 电影时间 */
@property (weak, nonatomic) IBOutlet UILabel *moviePlayDatelabel;   /**< 电影上映日期 */
@property (weak, nonatomic) IBOutlet UILabel *movieDetailDescriptionlabel;      /**< 电影详情描述 */
@property (weak, nonatomic) IBOutlet UIView *movieStageView;        /**< 电影剧照 */
@property (weak, nonatomic) IBOutlet UILabel *movieDirectorlabel;       /**< 导演 */
@property (weak, nonatomic) IBOutlet UILabel *movieActorlabel;      /**< 演员 */
@property (weak, nonatomic) IBOutlet UILabel *movieStorylabel;      /**< 剧情 */
@property (weak, nonatomic) IBOutlet UIButton *movieBuyBtn;     /**< 立即购买 */

@property (nonatomic, strong) CCRequestModel *requestModel;

@end

@implementation CCFilmDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"影片详细信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - /*** 请求数据 ***/
- (void)requestData
{
    [[CCAnimation instanceAnimation] startAnimationSubmitToView:self.view message:nil fullScreen:YES stopAnimationTime:0];
    
    [CCHttpRequest requestFilmDetailInfo:self.requestModel httpRequest:^(CCSendHttpRequest *sendHttpRequest) {
        
    } success:^(NSString *code, NSString *msg, CCFilmDetailInfoModel *detailModel) {
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:^{
            [self handleData:detailModel];
        }];
    } failure:^(NSString *code, HttpRequestError httpRequestError, NSString *msg, NSDictionary *info, id objc) {
        [[CCAnimation instanceAnimation] stopAnimationWithDuration:0 completion:^{
            
        }];
    }];
}

- (void)handleData:(CCFilmDetailInfoModel *)detailModel
{
    
}

#pragma mark - /*** 初始化UI ***/
- (void)initViews
{

}

// --- 剧照
- (void)initStageView
{

}

#pragma mark - /*** 点击立即购票 ***/
- (IBAction)filmBuyBtnClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieBooking" bundle:nil];
    CCFilmDetailCinemaVC *VC = [storyboard instantiateViewControllerWithIdentifier:@"CCFilmDetailCinemaVC"];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
