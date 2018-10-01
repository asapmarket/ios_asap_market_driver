//
//  DetailCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_titleLabel];
        
        _descLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_descLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 54.5, SCREEN_WIDTH-20, 0.5)];
        line.backgroundColor = ThemeBgColor;
        [self addSubview:line];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 20, 79, 15);
    _descLabel.frame = CGRectMake(89, 20, SCREEN_WIDTH-109, 15);
}

- (void)configWithTitle:(NSString *)title desc:(NSString *)desc index:(NSUInteger)index{
    _titleLabel.text = title;
    _descLabel.text = desc;
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
