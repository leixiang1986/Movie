//
//  DeBugIPViewController.m
//  RequestFrameworks
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "DeBugIPViewController.h"
#import "CCHttpRequestUrlManager.h"
#import "NetWorkStatusHeader.h"
#import "OkdeerPublic.h"
#import "PublicToolManager.h"

typedef NS_ENUM(NSUInteger,DeBugIpType) {
    DeBugIpTypeOfMall = 0,          /**< 商城*/
    DeBugIpTypeOfProperty = 1,      /**< 物业*/
    DeBugIpTypeOfSellertApp = 2,    /**< 商家 */
};

typedef void(^TableSelectBlock)(NSString *ipName,DeBugIpType ipType,NSArray *dataArray);
typedef void(^TableDeleteBlock)(DeBugIpType ipType,NSArray *dataArray);

@interface DeBugIPView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *doneButton;          /**< 确定按钮*/
@property (nonatomic,strong) UIButton *defaultButton;       /**< 默认 */
@property (nonatomic,strong) UITextField *textFiled;
@property (nonatomic,strong) UITableView *ipTableView;
@property (nonatomic,strong) NSArray *listArray;            /**< 数据源 */
@property (nonatomic,assign) DeBugIpType ipType;            /**< 类型 */
@property (nonatomic,copy) TableSelectBlock tableSelectBlock;       /**< 选择回调 */
@property (nonatomic,copy) TableDeleteBlock tableDeleteBlock;       /**< 删除回调 */

@end

@implementation DeBugIPView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
/**
 *  创建UI
 */
- (void)setupUI{
    _textFiled = [[UITextField alloc]init];
    _textFiled.placeholder = @"http://XXX 或 http://XXX/yscmobile";
    [self addSubview:_textFiled];
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(clickDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doneButton];
    
    _ipTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _ipTableView.delegate = self;
    _ipTableView.dataSource = self;
    _ipTableView.rowHeight = 44;
    _ipTableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_ipTableView];
    
    _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultButton setTitle:@"还原默认" forState:UIControlStateNormal];
    [_defaultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _defaultButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [_defaultButton addTarget:self action:@selector(clickDefaultAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_defaultButton];
    
    [self initUIConstraint];
}
/**
 *  约束
 */
- (void)initUIConstraint{
    _textFiled.translatesAutoresizingMaskIntoConstraints = false;
    _doneButton.translatesAutoresizingMaskIntoConstraints = false;
    _ipTableView.translatesAutoresizingMaskIntoConstraints = false;
    _defaultButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_textFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_textFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_textFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_textFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_doneButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_doneButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_textFiled attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_doneButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_doneButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_textFiled attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_doneButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:10]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_ipTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_textFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_ipTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_ipTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_ipTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_defaultButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_defaultButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_defaultButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_defaultButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
}

- (void)setListArray:(NSArray *)listArray{
    _listArray = listArray;
    [_ipTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listArray.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ipCellIdentifier = @"ipCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ipCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ipCellIdentifier];
    }
    if (indexPath.row < _listArray.count) {
        cell.textLabel.text = [_listArray objectAtIndex:indexPath.row];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < _listArray.count ) {
        NSString *ipName = [_listArray objectAtIndex:indexPath.row];
        [self clickSelect:ipName];
    }
}
/**
 *  点击选择
 */
- (void)clickSelect:(NSString *)ipName{
    if (_tableSelectBlock) {
        _tableSelectBlock(ipName,_ipType,_listArray);
    }
}

/**
 *  点击确定按钮
 */
- (void)clickDoneAction{
    if (_textFiled.text.length > 0) {
        [self clickSelect:_textFiled.text];
    }
}
/**
 *  点击设置为默认的
 */
- (void)clickDefaultAction{
    [self clickSelect:@""];
}

@end


@interface DeBugIPViewController ()

@property (nonatomic,strong) UISegmentedControl *segmented;     /**< 选择*/
@property (nonatomic,strong) UIScrollView *ipScrollView;        /**< 滚动 */
@property (nonatomic,strong) NSString *mallPlistPath;           /**< 商城plist*/
@property (nonatomic,strong) NSString *propertyPlistPath;       /**< 物业plist*/
@property (nonatomic,strong) NSString *sellerPlistPath;         /**< 商家*/

@end

@implementation DeBugIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPlistPath];
    [self setupUI];
}
/**
 *  初始化plist 路径
 */
- (void)initPlistPath{
    NSString *basePath = [CCUtility getDocumentBaseDirectory];
    _mallPlistPath = [NSString stringWithFormat:@"%@/MallIp.plist",basePath];
    _propertyPlistPath = [NSString stringWithFormat:@"%@/PropertyIp.plist",basePath];
    _sellerPlistPath = [NSString stringWithFormat:@"%@/SellerIp.plist",basePath];
}
/**
 *  保存plist 数据
 *
 *  @param array  数据源
 *  @param ipType 类型
 */
- (void)savePlistData:(NSArray *)array ipType:(DeBugIpType)ipType{
    NSString *plistPath = @"";
    switch (ipType) {
        case DeBugIpTypeOfMall: {
            plistPath = _mallPlistPath;
            break;
        }
        case DeBugIpTypeOfProperty: {
            plistPath = _propertyPlistPath;
            break;
        }
        case DeBugIpTypeOfSellertApp: {
            plistPath = _sellerPlistPath;
            break;
        }
    }
    if (plistPath.length) {
        [array writeToFile:plistPath atomically:YES];
    }
}
/**
 *  获取plist 数据
 *
 *  @param ipType 类型
 *
 *  @return 数组
 */
- (NSArray *)obtainPlistData:(DeBugIpType)ipType{
    NSString *plistPath = @"";
    switch (ipType) {
        case DeBugIpTypeOfMall: {
            plistPath = _mallPlistPath;
            break;
        }
        case DeBugIpTypeOfProperty: {
            plistPath = _propertyPlistPath;
            break;
        }
        case DeBugIpTypeOfSellertApp: {
            plistPath = _sellerPlistPath;
            break;
        }
    }
    if (plistPath.length) {
        return [[NSArray array] initWithContentsOfFile:plistPath];
    }
    return @[];
}
#pragma mark - //****************** 事件 action ******************//
/**
 *  点击事件
 */
-(void)segmentAction:(UISegmentedControl *)sender{
    _ipScrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex * CGRectGetWidth(_ipScrollView.frame), 0);
}
/**
 *  点击选择的回调
 */
- (void)clickSelectAction:(NSString *)ipName ipType:(DeBugIpType)ipType dataArray:(NSArray *)dataArray{
    NSMutableArray *listArray = [[NSMutableArray alloc] init];
    [listArray addObjectsFromArray:dataArray];
    if (ipName && ipName.length && ![dataArray containsObject:ipName]) {
        [listArray addObject:ipName];
        [self savePlistData:listArray ipType:ipType];
    }
    BOOL openNotification = [PublicToolManager getSettingOfDebug];
    NSString *notifictionName = @"";
    // 发起通知 地址改变了
    switch (ipType) {
        case DeBugIpTypeOfMall: {
            [[CCHttpRequestUrlManager shareManager] saveDebugMallPrefixUrl:ipName];
            notifictionName = kMallIpChangeNotification;
            break;
        }
        case DeBugIpTypeOfProperty: {
            [[CCHttpRequestUrlManager shareManager] saveDebugPropertyPrefixUrl:ipName];
            notifictionName = kPropertyIpChangeNotification;
            break;
        }
        case DeBugIpTypeOfSellertApp: {
            [[CCHttpRequestUrlManager shareManager] saveDebugSellerPrefixUrl:ipName];
            notifictionName = kSellertIpChangeNotifiction;
            break;
        }
    }
    if (notifictionName.length && openNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notifictionName object:nil];
    }
    if ([self.navigationController respondsToSelector:@selector(popNavigationItemAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}
/**
 *  点击删除
 */
- (void)clickDeleteAction:(DeBugIpType) ipType dataArray:(NSArray *)dataArray{
    [self savePlistData:dataArray ipType:ipType];
}

#pragma mark - //****************** UI ******************//
/**
 *  创建UI
 */
- (void)setupUI{
    [self.view addSubview:self.segmented];
    [self.view addSubview:self.ipScrollView];
    [self setupSubView];
}
/**
 *  创建UI
 */
- (void)setupSubView{
    for (NSInteger i = 0; i < 3; i ++ ) {
        DeBugIPView *ipView = [[DeBugIPView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.ipScrollView.frame), 0,CGRectGetWidth(self.ipScrollView.frame) , CGRectGetHeight(self.ipScrollView.frame))];
        ipView.ipType = i ;
        ipView.listArray = [self obtainPlistData:ipView.ipType];
        __weak typeof(self) weakSelf = self;
        ipView.tableSelectBlock = ^void(NSString *ipName,DeBugIpType ipType,NSArray *dataArray){
            __weak typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf clickSelectAction:ipName ipType:ipType dataArray:dataArray];
            }
        };
        ipView.tableDeleteBlock = ^void(DeBugIpType ipType,NSArray *dataArray){
            __weak typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf clickDeleteAction:ipType dataArray:dataArray];
            }
        };
        [self.ipScrollView addSubview:ipView];
    }
}

#pragma mark - //****************** getter ******************//
- (UISegmentedControl *)segmented{
    if (!_segmented) {
        _segmented = [[UISegmentedControl alloc] initWithItems:@[@"商城",@"物业",@"商家"]];
        [_segmented addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventAllEvents];
        _segmented.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    }
    return _segmented;
}

- (UIScrollView *)ipScrollView{
    if (!_ipScrollView) {
        _ipScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.view.frame) - 40)];
    }
    return _ipScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



