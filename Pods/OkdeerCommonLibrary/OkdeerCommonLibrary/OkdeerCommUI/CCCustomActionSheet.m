//
//  CCCustomActionSheet.m
//  CloudCity
//
//  Created by Mac on 16/2/23.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CCCustomActionSheet.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "CCCategorHeader.h"
#import "OkdeerCommUIHeader.h"
#import "UIView+CCView.h"

#define kCellHeight 56
#define kAnimationBeginDuration 0.25
#define kAnimationEndDuration 0.17

@interface CCCustomActionCell : UITableViewCell
{
    CALayer *_line;
    UIColor *_defaultColor;
    UIColor *_selectedColor;
}
@property (nonatomic, strong) UILabel *actionTitleLabel;    /**< 标题label */
@property (nonatomic, strong) UILabel *subTitleLabel;       /**< 副标题label */
@end

@implementation CCCustomActionCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier defaultTitleColor:(UIColor *)defaultColor selectedTitleColor:(UIColor *)selectedColor lineColor:(UIColor *)lineColor titleFont:(UIFont *)titleFont {
        self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {

        self.actionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kUIFullWidth, kCellHeight)];
        self.actionTitleLabel.backgroundColor = [UIColor clearColor];
        
        _defaultColor = defaultColor ? : UIColorFromHex(0x666666);
        _selectedColor = selectedColor;
        lineColor = lineColor ? : UIColorFromHex(COLOR_E2E2E2);
        titleFont = titleFont ? : FONTDEFAULT(16.0);
        
        self.actionTitleLabel.textColor = _defaultColor;
        self.actionTitleLabel.font = titleFont;
        self.actionTitleLabel.textAlignment = NSTextAlignmentCenter;
        _line = [CALayer layer];
        _line.backgroundColor = lineColor.CGColor;
        _line.frame = CGRectMake(0, kCellHeight - 1, kUIFullWidth, 1);
        
        [self addSubview:self.actionTitleLabel];
        [self.layer addSublayer:_line];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (_selectedColor){
        [self.actionTitleLabel setTextColor:selected ? _selectedColor : _defaultColor];
    }
}

@end


@interface CCCustomActionSheet ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    UIWindow *_backgroundWindow;
    UITapGestureRecognizer *_hideWindowGes;
}
@end

@implementation CCCustomActionSheet

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)actionSheetWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock {
    CCCustomActionSheet *actionSheet = [[CCCustomActionSheet alloc] initWithTitles:titles actionBlock:actionBlock];
    return actionSheet;
}

+ (instancetype)actionSheetWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock cellClassStr:(NSString *)cellClassStr cellHeight:(CGFloat)cellHeight{
    CCCustomActionSheet *actionSheet = [[CCCustomActionSheet alloc] initWithTitles:titles actionBlock:actionBlock cellClassStr:cellClassStr cellHeight:cellHeight];
    return actionSheet;
}

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock cellClassStr:(NSString *)cellClassStr cellHeight:(CGFloat)cellHeight{
    self = [super init];
    if (self){
        _actionTitles = titles;
        _actionBlock = actionBlock;
        _cellClassStr = cellClassStr;
        _cellHeight = cellHeight;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock defaultTitleColor:(UIColor *)defaultColor selectedTitleColor:(UIColor *)selectedColor {
    
    self = [super init];
    if (self){
        _actionTitles = titles;
        _actionBlock = actionBlock;
        _defaultTitleColor = defaultColor;
        _selectedTitleColor = selectedColor;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles actionBlock:(void (^)(NSUInteger))actionBlock {
    self = [self initWithTitles:titles subTitles:nil actionBlock:actionBlock];
    return self;
}

/**
 *  带副标题的默认初始化方式
 *
 *  @param titles      标题
 *  @param subTitles   副标题
 *  @param actionBlock 点击事件
 *
 *  @return
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles subTitles:(NSArray *)subTitles actionBlock:(void (^)(NSUInteger))actionBlock {
    self = [super init];
    if (self) {
        _actionTitles = titles;
        _subTitles = subTitles;
        _actionBlock = actionBlock;
        [self setupUI];
    }

    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setActionTitles:(NSArray *)actionTitles {
    _actionTitles = actionTitles;
    CGFloat height = _actionTitles.count * kCellHeight + 5 + 60;
    _titlesList.frame = CGRectMake(0, 0, kUIFullWidth, height);
    self.frame = CGRectMake(0, kUIFullHeight - height, kUIFullWidth, height);
    [_titlesList reloadData];
}

- (void)setupUI {
    
    CGFloat height = self.actionTitles.count * ((self.cellClassStr.length && self.cellHeight) ? self.cellHeight : kCellHeight) + 5 + 60;
    _titlesList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIFullWidth, height) style:UITableViewStylePlain];
    _titlesList.delegate = self;
    _titlesList.dataSource = self;
    _titlesList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _titlesList.showsHorizontalScrollIndicator = NO;
    _titlesList.showsVerticalScrollIndicator = NO;
    _titlesList.scrollEnabled = NO;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIFullWidth, 65)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIFullWidth, 5)];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake( 0, 5, kUIFullWidth, 60);
    [cancelBtn setTitle:self.cancelTitle?:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:self.cancelTitleColor ?:UIColorFromHex(0x8CC63F)  forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = self.cancelTitleFont ?:FONTDEFAULT(18.0);
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:line];
    [footer addSubview:cancelBtn];
    _titlesList.tableFooterView = footer;
    
    self.frame = CGRectMake(0, kUIFullHeight - height, kUIFullWidth, height);
    [self addSubview:_titlesList];
    [self addToWindow];
    
}

- (void)addToWindow {
    _backgroundWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backgroundWindow.windowLevel = UIWindowLevelAlert;
    _backgroundWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    _hideWindowGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
    [_backgroundWindow addGestureRecognizer:_hideWindowGes];
    _hideWindowGes.delegate = self;
    
    [_backgroundWindow addSubview:self];
    [_backgroundWindow makeKeyAndVisible];
    _backgroundWindow.y = kUIFullHeight;
}

- (void)removeWindow {
    [_backgroundWindow resignKeyWindow];
    _backgroundWindow.hidden = YES;
    _backgroundWindow = nil;
}

- (void)cancelAction{
    [self animationWithCompletionBlock:nil location:kUIFullHeight];
}

/**
 *  房间列表弹出或隐藏动画
 *
 *  @param block    动画结束后回调
 *  @param location 动画中房间列表需改变的y坐标
 */
- (void)animationWithCompletionBlock:(void (^)(NSUInteger))block location:(CGFloat)location{
    [UIView animateWithDuration:location ? kAnimationEndDuration : kAnimationBeginDuration animations:^{
        _backgroundWindow.y = location;
    } completion:^(BOOL finished) {
        if (finished) {
            if (block) {
                [self removeFromSuperview];
                [self removeWindow];            //iOS7上会重复出现，在此移除掉，再次点击时重新创建
                block(_titlesList.indexPathForSelectedRow.row);
            }
        }
    }];
}

/**
 *  显示/隐藏 房间列表VIew
 */
- (void)setDisplay:(BOOL)isDisplay {
    _isDisplay = isDisplay;
    if (!_backgroundWindow || !self.superview) {
        [self addToWindow];
    }
    [self animationWithCompletionBlock:_isDisplay ? nil : _actionBlock location:_isDisplay? 0 : kUIFullHeight];
}

#pragma mark - UITableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _actionTitles.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.cellClassStr.length && self.cellHeight) ? self.cellHeight : kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (_cellClassStr && _cellClassStr.length){             //  支持自定的Cell
            cell = [NSClassFromString(_cellClassStr) alloc];
            if ([cell isKindOfClass:[UITableViewCell class]]) {
                cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
//            cell = (UITableViewCell *)(objc_msgSend(cell, @selector(initWithStyle:reuseIdentifier:), UITableViewCellStyleDefault, cellID));
        }else {
            cell = [[CCCustomActionCell alloc] initWithReuseIdentifier:cellID defaultTitleColor:self.defaultTitleColor selectedTitleColor:self.selectedTitleColor lineColor:self.lineColor titleFont:self.titleFont];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setValue:self.actionTitles[indexPath.row] forKeyPath:@"actionTitleLabel.text"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.actionTitles.count && indexPath.row >= 0){
        [self setDisplay:NO];
    }
}

- (void)dealloc {
    [self removeWindow];
}

#pragma mark - UIGestureRecognizer代理

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    static CGPoint point;
    point= [touch locationInView:_backgroundWindow];
    if (CGRectContainsPoint(self.frame, point) && [gestureRecognizer isEqual:_hideWindowGes]){     //   处理Window的手势对tableView的操作干扰
        return NO;
    }
    return YES;
}


@end
