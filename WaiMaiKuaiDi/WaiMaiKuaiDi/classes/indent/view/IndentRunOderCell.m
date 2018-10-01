//
//  IndentRunOderCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import "IndentRunOderCell.h"
#import "StringHeight.h"
#import "StringColor.h"

#define BGWidth (SCREEN_WIDTH-20)
#define BGHeight (_bgView.bounds.size.height)

@interface IndentRunOderCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *indentNo;

@property (nonatomic, strong) UILabel *remarkLabel;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIButton *grabButton;
@property (nonatomic, strong) UIView *imageBgV;

@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *indentStatus;
@property (nonatomic, strong) UIView *circle2;

@end
@implementation IndentRunOderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ThemeBgColor;
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.layer.cornerRadius = 5;
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImageView.image = [UIImage imageNamed:NSLocalizedString(kRecieve, nil)];
        [_bgView addSubview:_leftImageView];
        
        _title = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _title.numberOfLines = 0;
        [_bgView addSubview:_title];
        
        _remarkLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:14] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        _remarkLabel.numberOfLines = 0;
        [_bgView addSubview:_remarkLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
        [_bgView addSubview:_line];
        
        _indentNo = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        [_bgView addSubview:_indentNo];
        
        _grabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_grabButton setTitle:NSLocalizedString(kRobOrder, nil) forState:UIControlStateNormal];
        [_grabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_grabButton setBackgroundColor:ButtonColor];
        [_grabButton addTarget:self action:@selector(grabButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_grabButton];
        
        _footerView = [[UIView alloc] initWithFrame:CGRectZero];
        _footerView.backgroundColor = ThemeBgColor;
        [self addSubview:_footerView];
        
        _imageBgV = [[UIView alloc] initWithFrame:CGRectZero];
        [_bgView addSubview:_imageBgV];
        
        _time = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        [_bgView addSubview:_time];
        
        _circle2 = [[UIView alloc] initWithFrame:CGRectZero];
        _circle2.backgroundColor = ButtonColor;
        _circle2.layer.cornerRadius = 2.5f;
        [_bgView addSubview:_circle2];
        
        _indentStatus = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
        [_bgView addSubview:_indentStatus];
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _leftImageView.frame = CGRectMake(15, 10, 27, 27);
    
}

- (void)setItem:(HomeRunCodeItem *)item{
    _item = item;
    CGFloat height = 15;
    
    CGFloat titleH = [StringHeight heightFromString:item.cust_address withFont:15 constraintToWidth:BGWidth-75];
    _title.frame = CGRectMake(55, height, BGWidth-75, titleH);
    _title.text = item.cust_address;
    if (titleH == 0) {
        titleH = 15;
    }
    height += titleH;
    height += 20;
    
    CGFloat remarkH = [StringHeight heightFromString:item.remark withFont:15 constraintToWidth:BGWidth-75];

    _remarkLabel.frame = CGRectMake(55, height, BGWidth-75, remarkH);
    _remarkLabel.text = item.remark;
    
    height += remarkH;
    height += 10;
    _imageBgV.frame = CGRectMake(0, height, BGWidth, (SCREEN_WIDTH-80)/5.0+10);
    if (item.imgs.count > 0) {
        _imageBgV.hidden = NO;
        for (int i=0; i< item.imgs.count; i++) {
            RunImgsModel *img = item.imgs[i];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10+(10+(SCREEN_WIDTH-80)/5.0)*i, 0, (SCREEN_WIDTH-80)/5.0, (SCREEN_WIDTH-80)/5.0)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:img.path]];
            [_imageBgV addSubview:imageV];
        }
    }else{
        _imageBgV.hidden = YES;
    }
    
    height += ((SCREEN_WIDTH-80)/5.0+10);
    
    _indentNo.frame = CGRectMake(10, height, BGWidth-20, 15);
    _indentNo.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(kOrderNO, nil),item.order_id] index:NSLocalizedString(kOrderNO, nil).length textColor:[UIColor hexStringToColor:@"#333333"]];
    
    height += 25;
    
    NSString *stateStr = [self state:item.state];
    
    _time.frame = CGRectMake(10, height, SCREEN_WIDTH-120, 15);
    _time.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@:%@",NSLocalizedString(kOrderTime,nil),item.create_time] index:NSLocalizedString(kOrderTime,nil).length+1 textColor:[UIColor hexStringToColor:@"#333333"]];
    
    _indentStatus.frame = CGRectMake(BGWidth-5-(stateStr.length*13+15>120?120:stateStr.length*13+15), height-25, stateStr.length*13+15>120?120:stateStr.length*13+15, 40);
    
    if ([_item.pay_state integerValue] == 1){
        _indentStatus.text = item.payment_method;
    }else{
        _indentStatus.text = stateStr;
    }
    
    _circle2.frame = CGRectMake(BGWidth-_indentStatus.frame.size.width-20, height+17.5-25, 5, 5);
    
    height += 25;
    
    _grabButton.frame = CGRectMake(0, height, BGWidth, 45);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_grabButton.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _grabButton.bounds;
    maskLayer.path = maskPath.CGPath;
    _grabButton.layer.mask = maskLayer;
    
    height += 45;
    
    _bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, height);
    _footerView.frame = CGRectMake(0, height, SCREEN_WIDTH, 10);
    
    if ([item.state isEqualToString:@"1"]) {
        [_grabButton setBackgroundColor:ButtonColor];
        [_grabButton setTitle:NSLocalizedString(@"FeedbackThePrice", nil) forState:UIControlStateNormal];
        _grabButton.userInteractionEnabled = YES;
        
    }else if ([item.state isEqualToString:@"3"]){
       
        [_grabButton setBackgroundColor:ButtonColor];
        [_grabButton setTitle:NSLocalizedString(kOrderEnd, nil) forState:UIControlStateNormal];
        _grabButton.userInteractionEnabled = YES;
       
    }else if ([item.state isEqualToString:@"9"]){
        [_grabButton setTitle:NSLocalizedString(@"CancelOrder", nil) forState:UIControlStateNormal];
        [_grabButton setBackgroundColor:[UIColor hexStringToColor:@"#b3b3b3"]];
        _grabButton.userInteractionEnabled = NO;
    }else if ([item.state isEqualToString:@"8"]){
        [_grabButton setBackgroundColor:ButtonColor];
        [_grabButton setTitle:NSLocalizedString(kOnRoad, nil) forState:UIControlStateNormal];
        _grabButton.userInteractionEnabled = YES;
    }else if ([item.state isEqualToString:@"4"]){
        [_grabButton setBackgroundColor:ButtonColor];
        [_grabButton setTitle:NSLocalizedString(kOrderEnd, nil) forState:UIControlStateNormal];
        _grabButton.userInteractionEnabled = NO;
    }
}

+ (CGFloat)cellHeightWithModel:(HomeRunCodeItem *)model{
    CGFloat height = 15;
    CGFloat titleH = [StringHeight heightFromString:model.cust_address withFont:15 constraintToWidth:BGWidth-75];
    height += titleH;
    height += 30;
    height += ((SCREEN_WIDTH-80)/5.0+40);
    height += 80;
    
    CGFloat remarkH = [StringHeight heightFromString:model.remark withFont:15 constraintToWidth:BGWidth-75];

    height += remarkH;
    return height;
}
- (NSString *)state:(NSString *)state{
    NSString *stateStr;
    if ([state isEqualToString:@"0"]) {
        stateStr = NSLocalizedString(kOrderSuccess, nil);
    }else if ([state isEqualToString:@"1"]){
        stateStr = NSLocalizedString(kDeliveryOrder, nil);
    }else if ([state isEqualToString:@"2"]){
        stateStr = NSLocalizedString(kIsTake, nil);
    }else if ([state isEqualToString:@"3"]){
        stateStr = NSLocalizedString(kOnRoad, nil);
    }else if ([state isEqualToString:@"4"]){
        stateStr = NSLocalizedString(kOrderEnd, nil);
    }else if ([state isEqualToString:@"8"]){
        stateStr = NSLocalizedString(@"ISFeedBack", nil);
    }else if ([state isEqualToString:@"9"]){
        stateStr = NSLocalizedString(@"CancelOrder", nil);
    }
    return stateStr;
}

- (void)grabButtonClick{
    if (self.grabButtonBlock) {
        self.grabButtonBlock(_item);
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
