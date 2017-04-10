//
//  QQMenuCellTableViewCell.m
//  LYSTipView
//
//  Created by jk on 2017/4/10.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "QQMenuCellTableViewCell.h"

@interface QQMenuCellTableViewCell ()

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLB;

@property(nonatomic,strong)UIView *line;

@end

@implementation QQMenuCellTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initConfig];
    }
    return self;
}

-(void)initConfig{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLB];
    [self.contentView addSubview:self.line];
}

-(UIImageView*)iconView{
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.contentMode = UIViewContentModeCenter;
    }
    return _iconView;
}

-(UILabel*)titleLB{
    if (!_titleLB) {
        _titleLB = [UILabel new];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.font = [UIFont systemFontOfSize:14];
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.numberOfLines = 1;
        _titleLB.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLB;
}

-(UIView*)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}

-(void)setItem:(NSDictionary *)item{
    _item = item;
    self.iconView.image = [UIImage imageNamed:[item objectForKey:@"image"]];
    self.titleLB.text = [item objectForKey:@"title"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    self.titleLB.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.iconView.frame) + 20.f, self.bounds.size.height);
    self.line.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
