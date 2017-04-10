//
//  LYSTipView.h
//  LYSTipView
//
//  Created by jk on 2017/4/9.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LYSTipView : UIView

@property(nonatomic,assign)CGFloat triangleXOffset;

@property(nonatomic,assign)CGFloat viewXOffset;

@property(nonatomic,assign)CGFloat viewYOffset;

@property(nonatomic,copy)NSArray *items;

@property(nonatomic,assign)CGFloat itemH;

@property(nonatomic,assign)CGFloat triangleHeight;

@property(nonatomic,assign)CGFloat tableW;

-(void)show;

-(void)hide:(void(^)())finishBlock;
@end
