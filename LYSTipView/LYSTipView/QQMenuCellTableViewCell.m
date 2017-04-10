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
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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
