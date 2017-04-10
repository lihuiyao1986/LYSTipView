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

@property(nonatomic,strong)UIColor *bgColor;

@property(nonatomic,assign)NSInteger maxCount;

@property(nonatomic,assign)Class itemClazz;

@property(nonatomic,assign)BOOL dismissOutside;

@property(nonatomic,copy)void(^ItemDidSelected)(NSDictionary* item);

@property(nonatomic,copy)void(^HandleCell)(UITableViewCell *cell,NSDictionary* item);

-(void)show;

-(void)hide:(void(^)())finishBlock;
@end
