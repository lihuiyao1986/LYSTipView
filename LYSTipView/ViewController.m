//
//  ViewController.m
//  LYSTipView
//
//  Created by jk on 2017/4/9.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSTipView.h"

@interface ViewController (){
    UIButton *_btn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 120, self.view.bounds.size.width, 44);
    [_btn setTitle:@"开始" forState:UIControlStateNormal];
    _btn.layer.borderColor = [UIColor redColor].CGColor;
    _btn.layer.borderWidth = 1;
    _btn.layer.cornerRadius = 5.f;
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnClicked:(UIButton*)sender{
    LYSTipView *_tipView = [LYSTipView new];
    _tipView.viewXOffset = 50.f;
    _tipView.viewYOffset = CGRectGetMaxY(sender.frame);
    _tipView.itemH = 30.f;
    _tipView.items = @[@"d",@"1",@"2"];
    _tipView.tableW = 120.f;
    _tipView.triangleXOffset = 20.f;
    _tipView.triangleHeight = 10.f;
    [_tipView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
