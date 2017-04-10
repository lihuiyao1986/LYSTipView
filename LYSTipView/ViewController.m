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
    _tipView.dismissOutside = NO;
    _tipView.viewYOffset = CGRectGetMaxY(sender.frame);
    _tipView.items = @[@{@"title":@"liyansheng1"},@{@"title":@"liyansheng2"},@{@"title":@"liyansheng3"},@{@"title":@"liyansheng4"},@{@"title":@"liyansheng5"}];
    _tipView.bgColor = [UIColor blueColor];
    _tipView.HandleCell = ^(UITableViewCell *cell,NSDictionary *item){
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.text = [item objectForKey:@"title"];
    };
    _tipView.ItemDidSelected = ^(NSDictionary *item){
        NSLog(@"you selected %@",[item objectForKey:@"title"]);
    };
    [_tipView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
