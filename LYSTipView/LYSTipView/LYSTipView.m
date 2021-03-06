//
//  LYSTipView.m
//  LYSTipView
//
//  Created by jk on 2017/4/9.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSTipView.h"

@interface LYSTipView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)CAShapeLayer *triangleView;

@property(nonatomic,strong)UIView *containerView;

@end

NSTimeInterval const duration = 0.25;

@implementation LYSTipView

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)initConfig{
    [self setDefaults];
    self.backgroundColor = [self colorWithHexString:@"000000" alpha:0.3];
    [self addSubview:self.containerView];
    self.containerView.transform = CGAffineTransformMakeScale(0, 0);
    [self updateTriangle];
}


#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

-(void)setDefaults{
    _bgColor = [UIColor redColor];
    _maxCount = -1;
    _itemClazz = [UITableViewCell class];
    _itemH = 30.f;
    _tableW = 100.f;
    _triangleHeight = 10.f;
    _triangleXOffset = -30.f;
    _bgColor = [UIColor whiteColor];
    _dismissOutside = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.maxCount == -1 ? self.items.count : MIN(self.maxCount, self.items.count);
    self.containerView.frame = CGRectMake(self.viewXOffset, self.viewYOffset, self.tableW, self.itemH * count + self.triangleHeight);
    self.tableView.frame = CGRectMake(0,self.triangleHeight, self.tableW,self.itemH * count);
}

-(UIView*)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        [_containerView addSubview:self.tableView];
        [_containerView.layer addSublayer:self.triangleView];
    }
    return _containerView;
}

-(void)setItemClazz:(Class)itemClazz{
    _itemClazz = itemClazz;
    [self.tableView registerClass:_itemClazz forCellReuseIdentifier:NSStringFromClass(self.itemClazz)];
}

#pragma mark - 列表视图
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = self.bgColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.layer.cornerRadius = 5;
        _tableView.clipsToBounds = YES;
        [_tableView registerClass:self.itemClazz forCellReuseIdentifier:NSStringFromClass(self.itemClazz)];
    }
    return _tableView;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    [self.tableView reloadData];
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor =  bgColor;
    self.triangleView.fillColor = self.bgColor.CGColor;
    self.tableView.backgroundColor = self.bgColor;
    [self.tableView reloadData];
}

-(CAShapeLayer*)triangleView{
    if (!_triangleView) {
        _triangleView = [CAShapeLayer layer];
        _triangleView.fillColor = self.bgColor.CGColor;
    }
    return _triangleView;
}


-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self showAnimation];
}

-(void)hide:(void(^)())finishBlock{
    [self dismissAnimation:finishBlock];
}

-(void)setTriangleXOffset:(CGFloat)triangleXOffset{
    _triangleXOffset = triangleXOffset;
    if (_triangleXOffset >= self.tableW / 2) {
        _triangleXOffset = self.tableW / 2 - 20.f;
    }else if(_triangleXOffset <= - self.tableW / 2){
        _triangleXOffset = - self.tableW / 2 + 20.f;
    }
    [self updateTriangle];
}

-(void)setTriangleHeight:(CGFloat)triangleHeight{
    _triangleHeight = triangleHeight;
    [self updateTriangle];
}

-(void)setTableW:(CGFloat)tableW{
    _tableW = tableW;
    [self updateTriangle];
}

-(void)updateTriangle{
    
    CGFloat l_ = self.triangleHeight / tan(M_PI / 3);
    CGPoint p1 = CGPointMake(self.tableW / 2 + self.triangleXOffset, 0);
    CGPoint p2 = CGPointMake(p1.x - l_, p1.y + self.triangleHeight);
    CGPoint p3 = CGPointMake(p1.x + l_, p1.y + self.triangleHeight);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    
    self.triangleView.path = path.CGPath;
}


- (void)showAnimation {
    __weak typeof (self)MyWeakSelf = self;
    self.containerView.layer.anchorPoint = CGPointMake(0.5 + self.triangleXOffset / self.tableW , 0);
    [UIView animateWithDuration:duration animations:^{
        MyWeakSelf.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

-(CGFloat)containerViewH{
    return self.itemH * self.items.count + self.triangleHeight;
}

- (void)dismissAnimation:(void(^)())finishBlock{
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:duration animations:^{
      MyWeakSelf.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finishBlock) {
            finishBlock();
        }
        [MyWeakSelf removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.containerView.frame, touchPoint)) {
        if (self.dismissOutside) {
            [self hide:nil];
        }
    }
}

#pragma mark -- UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.itemClazz)];
    cell.backgroundColor = self.bgColor;
    if (self.HandleCell) {
        self.HandleCell(cell,self.items[indexPath.row]);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof (self)MyWeakSelf = self;
    [self hide:^{
        if(MyWeakSelf.ItemDidSelected){
            MyWeakSelf.ItemDidSelected(MyWeakSelf.items[indexPath.row]);
        }
    }];
}


@end
