//
//  CashPayCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/10/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CashPayCell.h"

@implementation CashPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ThemeBgColor;
        _titleLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:12] textColor:[UIColor hexStringToColor:@"#ff2323"] textAlignment:NSTextAlignmentLeft];
        _titleLabel.text = NSLocalizedString(kCashText, nil);
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
        
        _confirmReceipt = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmReceipt.frame = CGRectZero;
        _confirmReceipt.backgroundColor = ButtonColor;
        [_confirmReceipt setTitle:NSLocalizedString(kConfirmReceipt,nil) forState:UIControlStateNormal];
        _confirmReceipt.layer.cornerRadius = 5;
        [_confirmReceipt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmReceipt addTarget:self action:@selector(confirmReceiptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmReceipt];
        [self bringSubviewToFront:_confirmReceipt];
        

        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 0, SCREEN_HEIGHT-20, 30);
    _confirmReceipt.frame = CGRectMake(10, 35, SCREEN_WIDTH-20, 45);

}

- (void)confirmReceiptBtnClick:(UIButton *)btn{
    if  ([self.delegate respondsToSelector:@selector(confirmReceiptButtonClick:)]){
        [self.delegate confirmReceiptButtonClick:btn];
    }
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
