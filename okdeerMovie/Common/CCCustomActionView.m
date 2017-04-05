//
//  CCCustomActionView.m
//  CloudCity
//
//  Created by 雷祥 on 16/1/29.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomActionView.h"
#import "CCCustomActionTableViewCell.h"

#define kCellHeight 56      //cell,确定按钮，标题view的高度
#define kCloseBtnWidth 45   //关闭按钮的宽高
#define kSpaceHeight    10  //空格高度

@interface CCCustomActionView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *tableView;  /**< 展示数据的tableView */
@property (nonatomic,weak) UILabel *titleLabel;     /**< 标题的tableView */
@property (nonatomic,weak) UIButton *closeBtn;      /**< 关闭按钮 */
@property (nonatomic,weak) UIButton *comfirmBtn;    /**< 确定按钮 */
@property (nonatomic,copy) ClickBtnBlock comfirmBlock;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;    /**< 选中的indexPath */
@property (nonatomic,weak) UIView *contentBackView; /**< 显示标题和按钮的内容view，上下动画用 */
@end

@implementation CCCustomActionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {


        UIView *contentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - kCellHeight * 5 - kSpaceHeight , frame.size.width, kCellHeight * 5 + kSpaceHeight)];
        contentBackView.backgroundColor = [UIColor clearColor];
        _contentBackView = contentBackView;
        [self addSubview:contentBackView];

        //title
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , frame.size.width, kCellHeight)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self creatLineLayerToView:titleView];

        [_contentBackView addSubview:titleView];

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
        titleLabel.textColor = UIColorFromHex(COLOR_666666);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:CCNumberTypeOf16];
        [titleView addSubview:titleLabel];
        _titleLabel = titleLabel;

        //tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleView.bottom, titleView.width, kCellHeight * 3) style:(UITableViewStylePlain)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableFooterView = [[UIView alloc] init];

        [_contentBackView addSubview:tableView];
        _tableView = tableView;

        for (NSInteger i = 0; i < 2; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kCellHeight * (i + 1) + titleView.bottom, frame.size.width, ScreenGridViewHeight)];
            lineView.backgroundColor = UIColorFromHex(COLOR_E2E2E2);
            [_contentBackView addSubview:lineView];
        }

        //closeBtn  关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [closeBtn setFrame:CGRectMake(frame.size.width - kCloseBtnWidth - CCNumberTypeOf10, titleView.top - kCloseBtnWidth / 2, kCloseBtnWidth, kCloseBtnWidth)];
        [closeBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
        [closeBtn setTitleColor:UIColorFromHex(COLOR_999999) forState:(UIControlStateNormal)];
        [closeBtn.titleLabel setFont:[UIFont systemFontOfSize:CCNumberTypeOf14]];
        [closeBtn setSystemCorneradius:kCloseBtnWidth / 2 withColor:nil withBorderWidth:0];
        closeBtn.backgroundColor = [UIColor whiteColor];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_contentBackView addSubview:closeBtn];
        _closeBtn = closeBtn;

        //comfirmBtn    确认按钮
        UIButton *comfirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        comfirmBtn.frame = CGRectMake(0, tableView.bottom + kSpaceHeight, frame.size.width, kCellHeight);
        [comfirmBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        [comfirmBtn setTitleColor:UIColorFromHex(COLOR_666666) forState:(UIControlStateNormal)];
        comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:CCNumberTypeOf18];
        comfirmBtn.backgroundColor = [UIColor whiteColor];
        [comfirmBtn addTarget:self action:@selector(comfirmBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_contentBackView addSubview:comfirmBtn];
        _comfirmBtn = comfirmBtn;

        _selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
    }

    return self;
}

/**
 *  设置标题
 *
 *  @param title
 */
- (void)setTitle:(NSString *)title {
    _title = [title copy];
    _titleLabel.text = title;
}

-(void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    [self.comfirmBtn setTitle:_btnTitle forState:(UIControlStateNormal)];
}

/**
 *  设置数据源
 *
 *  @param dataSource
 */
-(void)setDataSource:(NSArray<CCNameAndIdModel *> *)dataSource {
    _dataSource = dataSource;
    [_tableView reloadData];
    if (dataSource.count > 0) {
        _selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [_tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:(UITableViewScrollPositionMiddle)];
    }
}

/**
 *  返回cell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const cellId = @"CCCustomActionTableViewCell";
    CCCustomActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CCCustomActionTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.hidenLine = YES;
    if (self.dataSource.count + 1 > indexPath.row && indexPath.row > 0) {
        CCNameAndIdModel *model = (CCNameAndIdModel *)self.dataSource[indexPath.row - 1];
        cell.content = model.name;
    }
    else {
        cell.content = @"";
    }
    return cell;
}

/**
 *  cell分割线
 *
 *  @param view
 *
 *  @return
 */
- (CALayer *)creatLineLayerToView:(UIView *)view {
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [UIColorFromHex(COLOR_E2E2E2) CGColor];
    lineLayer.frame = CGRectMake(0, view.height - ScreenGridViewHeight, self.frame.size.width, ScreenGridViewHeight);
    [view.layer addSublayer:lineLayer];
    return lineLayer;
}

/**
 *  返回的行数
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 2;
}

/**
 *  celld的高度
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

/**
 *  点击cell
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.row == 0 || indexPath.row == self.dataSource.count + 1)) {
        [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    }
    else if (indexPath.row == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    }
    else if (indexPath.row == self.dataSource.count + 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count inSection:0];
        [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    }
}

/**
 *  设置目标位置，整行滚动
 *
 *  @param scrollView
 *  @param velocity
 *  @param targetContentOffset
 */
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint point = *targetContentOffset;
    NSInteger row = (NSInteger)point.y / kCellHeight;
    CGFloat scrollHeight = (NSInteger)point.y % (NSInteger)kCellHeight;
    NSInteger scrollRow = 0;
    if (scrollHeight > kCellHeight / 2) {
        scrollRow = row + 1;
    }
    else {
        scrollRow = row;
    } 
//    CGPoint toPoint = CGPointMake(0, scrollRow * kCellHeight);
    *targetContentOffset = CGPointMake(0, scrollRow * kCellHeight);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint scrollPoint = scrollView.contentOffset;
    NSInteger row = (scrollPoint.y + kCellHeight / 2) / kCellHeight + 1;
    _selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [_tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)setComfirmBtnClickBlock:(ClickBtnBlock)clickBlock {
    _comfirmBlock = [clickBlock copy];
}


-(void)comfirmBtnClick:(UIButton *)sender {
    if (_comfirmBlock) {
        if (_selectedIndexPath.row > 0) {
            BOOL ok = _comfirmBlock(self,_selectedIndexPath.row - 1);
            if (ok) {
                [self closeBtnClick:nil];
            }
        }
    }
}


- (void)closeBtnClick:(id)sender {
    [self hide];
}


-(void)showInView:(UIView *)superView withSelectIndex:(NSInteger)index{
    if (superView) {
        _contentBackView.frame = CGRectMake(0, self.height,_contentBackView.width , _contentBackView.height);
        self.hidden = NO;
        if (self.dataSource.count > index && index >= 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index + 1 inSection:0];   //因为第0排没有数据所以是index + 1
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionMiddle)];
        }
        [superView addSubview:self];
        self.frame = superView.bounds;
        [UIView animateWithDuration:0.4 animations:^{
            _contentBackView.frame = CGRectMake(0,self.height - _contentBackView.height, _contentBackView.width, _contentBackView.height);
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }];
    }
}

-(void)hide {
    if (self.superview) {
        [UIView animateWithDuration:0.4 animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            _contentBackView.frame = CGRectMake(0, self.height,_contentBackView.width , _contentBackView.height);
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}


@end
