//
//  OrderCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell ()

@property (nonatomic, strong) UIImageView *orderImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _orderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _orderImageView.image = [UIImage imageNamed:@"order"];
        [self addSubview:_orderImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = NSLocalizedString(kOrderManager,nil);
        [self addSubview:_titleLabel];
        
        _rightIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightIcon.image = [UIImage imageNamed:@"right_icon"];
        [self addSubview:_rightIcon];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _orderImageView.frame = CGRectMake(TableBorder, (self.bounds.size.height-13.5)/2.0, 13.5, 16);
    
    _titleLabel.frame = CGRectMake(TableBorder+23.5, CellBorder+1, SCREEN_WIDTH-120, 35);
    
    _rightIcon.frame = CGRectMake(SCREEN_WIDTH-16, 18.5, 6, 17.5);
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    [super setFrame:frame];
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
