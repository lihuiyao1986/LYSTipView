//
//  ViewController.m
//  LYSTipView
//
//  Created by jk on 2017/4/9.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSTipView.h"
#import "QQMenuCellTableViewCell.h"

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
    _tipView.itemH = 50.f;
    _tipView.tableW = 150.f;
    _tipView.dismissOutside = YES;
    _tipView.viewYOffset = CGRectGetMaxY(sender.frame);
    _tipView.items = @[@{@"title":@"liyansheng1",@"image":@"right_menu_addFri"},@{@"title":@"liyansheng2",@"image":@"right_menu_addFri"},@{@"title":@"liyansheng3",@"image":@"right_menu_addFri"},@{@"title":@"liyansheng4",@"image":@"right_menu_addFri"},@{@"title":@"liyansheng5",@"image":@"right_menu_addFri"}];
    _tipView.itemClazz = [QQMenuCellTableViewCell class];
    _tipView.HandleCell = ^(UITableViewCell *cell,NSDictionary *item){
        ((QQMenuCellTableViewCell*)cell).item = item;
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
