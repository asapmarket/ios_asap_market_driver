//
//  BaseViewCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/16.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BaseViewCell.h"
#import "StringColor.h"

@interface BaseViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation BaseViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BaseViewCell";
    BaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BaseViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    return cell;
}

- (void)setModel:(BaseModel *)model{
    _codeLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(kCode, nil),model.zip_code];
    NSString *countStr = [NSString stringWithFormat:@"%@%@",model.count,NSLocalizedString(kBill, nil)];
    _countLabel.attributedText = [StringColor setTextColorWithString:countStr index:model.count.length font:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#808080"]];
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
