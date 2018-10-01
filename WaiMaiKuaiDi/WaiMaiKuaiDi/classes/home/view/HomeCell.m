//
//  HomeCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeCell.h"
#import "StringHeight.h"
#import "StringColor.h"

#define BGWidth (SCREEN_WIDTH-20)
#define BGHeight (_bgView.bounds.size.height)
@interface HomeCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *indentNo;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *circle1;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIButton *grabButton;


@end

@implementation HomeCell

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
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
        [_bgView addSubview:_line];
        
        _indentNo = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        [_bgView addSubview:_indentNo];
        
        _timeLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        [_bgView addSubview:_timeLabel];
    
        _grabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_grabButton setTitle:NSLocalizedString(kRobOrder, nil) forState:UIControlStateNormal];
        [_grabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_grabButton setBackgroundColor:ButtonColor];
        [_grabButton addTarget:self action:@selector(grabButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_grabButton];

        _footerView = [[UIView alloc] initWithFrame:CGRectZero];
        _footerView.backgroundColor = ThemeBgColor;
        [self addSubview:_footerView];
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _leftImageView.frame = CGRectMake(15, 10, 27, 27);
    
}

- (void)setInfoModel:(OrderInfoModel *)infoModel{
    _infoModel = infoModel;
    CGFloat height = 15;
    
    CGFloat titleH = [StringHeight heightFromString:infoModel.cust_address withFont:15 constraintToWidth:BGWidth-75];
    _title.frame = CGRectMake(55, height, BGWidth-75, titleH);
    _title.text = infoModel.cust_address;
    if (titleH == 0) {
        titleH = 15;
    }
    height += titleH;
    height += 10;
    
    NSArray *storeArray = infoModel.store_list;
    height += [self createStoreAddrLabel:storeArray height:height];
    
    _line.frame = CGRectMake(10, height, BGWidth-20, 1);
    
    height += 11;
    
    _timeLabel.frame = CGRectMake(10, height, BGWidth-20, 15);
    if (infoModel.distribution_time) {
        _timeLabel.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"DistributionTime", nil),infoModel.distribution_time] index:NSLocalizedString(@"DistributionTime", nil).length textColor:[UIColor hexStringToColor:@"#333333"]];
    }else{
        _timeLabel.text = @"";
    }
    
    
    height += 25;
    
    _indentNo.frame = CGRectMake(10, height, BGWidth-20, 15);
    _indentNo.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(kOrderNO, nil),infoModel.order_id] index:NSLocalizedString(kOrderNO, nil).length textColor:[UIColor hexStringToColor:@"#333333"]];
    
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
//    height += 10;
    
}

- (CGFloat)createStoreAddrLabel:(NSArray *)storearray height:(CGFloat)height{
    CGFloat storeH = 0;
    if (storearray.count == 0) {
        return 0;
    }
    for (int i=0; i<storearray.count; i++) {
        StoreInfoModel *model = storearray[i];
        NSString *nameText = nil;
        NSString *address = nil;
        if ([LanguageManager shareManager].language == 0) {
            nameText = model.store_name_en;
            address = model.store_address_en;
        }else{
            nameText = model.store_name_cn;
            address = model.store_address_cn;
        }
        CGFloat nameH= [StringHeight heightFromString:nameText withFont:13 constraintToWidth:nameText.length*13>78?78:nameText.length*13];
        UILabel *name = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        
        CGFloat circleX = 78;
        
        CGFloat locationW = BGWidth - (65+circleX+33);
        CGFloat locatonH = [StringHeight heightFromString:address withFont:13 constraintToWidth:locationW];
        
        if (nameH > locatonH) {
            locatonH = nameH;
        }else{
            nameH = locatonH;
        }
        
        name.frame = CGRectMake(55, height+storeH, 78, nameH);
        name.numberOfLines = 0;
        name.text = nameText;
        [_bgView addSubview:name];
        
        UILabel *location = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        location.numberOfLines = 0;
        
        
        location.frame = CGRectMake(65+circleX+23, height+storeH, locationW, locatonH);
        location.text = address;
        [_bgView addSubview:location];
        
        
        
        
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(65+circleX, height+storeH+nameH/2.0-3, 3, 3)];
        circle.backgroundColor = ButtonColor;
        circle.layer.cornerRadius = 1.5f;
        [_bgView addSubview:circle];
        
        
        storeH += nameH;
        
        storeH += 10;
    }
    
    return storeH;
}

+ (CGFloat)cellHeightWithModel:(OrderInfoModel *)model{
    CGFloat height = 15;
    CGFloat titleH = [StringHeight heightFromString:model.cust_address withFont:15 constraintToWidth:BGWidth-75];
    height += titleH;
    height += 10;
    NSArray *storeArray = model.store_list;
    if (storeArray.count ==0) {
        height += 10;
    }else{
        for (StoreInfoModel *model in storeArray) {
            NSString *nameText = nil;
            NSString *address = nil;
            if ([LanguageManager shareManager].language == 0) {
                nameText = model.store_name_en;
                address = model.store_address_en;
            }else{
                nameText = model.store_name_cn;
                address = model.store_address_cn;
            }
            CGFloat circleX = 78;
            
            CGFloat nameH= [StringHeight heightFromString:nameText withFont:13 constraintToWidth:nameText.length*13>78?78:nameText.length*13];
            
            CGFloat locationW = BGWidth - (65+circleX+33);
            CGFloat locatonH = [StringHeight heightFromString:address withFont:13 constraintToWidth:locationW];
            
            if (nameH >= locatonH) {
                height += nameH;
            }else{
                height += locatonH;
            }
            height += 10;
        }
    }
    height += 11;
    if ([model.state isEqualToString:NSLocalizedString(kCompleted, nil)]){
        height += 0;
    }else{
        height += 45;
    }
    height += 25;
    height += 25;
    return height;
}

- (void)setStatus:(NSString *)status{
    _status = status;
    if ([status isEqualToString:@"0"] || status == nil) {
        [_grabButton setBackgroundColor:[UIColor hexStringToColor:@"#b3b3b3"]];
        _grabButton.userInteractionEnabled = NO;
    }else{
        [_grabButton setBackgroundColor:ButtonColor];
        _grabButton.userInteractionEnabled = YES;
    }
}

- (void)grabButtonClick{
    if ([self.delegate respondsToSelector:@selector(grapButtonClickWithModel:)]) {
        [self.delegate grapButtonClickWithModel:_infoModel];
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
