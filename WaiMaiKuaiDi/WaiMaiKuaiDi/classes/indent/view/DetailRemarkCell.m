//
//  DetailRemarkCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/10/12.
//  Copyright © 2017年 王. All rights reserved.
//

#import "DetailRemarkCell.h"
#import "StringHeight.h"

@implementation DetailRemarkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_titleLabel];
        
        _descLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        _descLabel.numberOfLines = 0;
        [self addSubview:_descLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = ThemeBgColor;
        [self addSubview:_lineView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 20, 79, 15);
    _descLabel.frame = CGRectMake(89, 0, SCREEN_WIDTH-109, self.bounds.size.height-10);
    _lineView.frame = CGRectMake(0, self.bounds.size.height-10, SCREEN_WIDTH, 10);
}

- (void)configWithTitle:(NSString *)title desc:(NSString *)desc index:(NSUInteger)index{
    _titleLabel.text = title;
    _descLabel.text = desc;
}

+ (CGFloat)cellHeightWithRemark:(NSString *)remark{
    CGFloat height = 65;
    if (remark.length == 0) {
        height = 65;
    }else{
        CGFloat nameH = [StringHeight heightFromString:remark withFont:15 constraintToWidth:SCREEN_WIDTH-109];
        height = nameH + 45;
    }
    
    return height;
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
