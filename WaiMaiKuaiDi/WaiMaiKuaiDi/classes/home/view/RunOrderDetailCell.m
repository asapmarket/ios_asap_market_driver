//
//  RunOrderDetailCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderDetailCell.h"
#import "StringColor.h"
#import "StringHeight.h"
#import "MultiParamButton.h"
#import "CreateButton.h"

#define BGWidth (SCREEN_WIDTH-20)
#define BGHeight (_bgView.bounds.size.height)

@interface RunOrderDetailCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIButton *bugButton;
@property (nonatomic, strong) UIView *imageBgV;

@end

@implementation RunOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ThemeBgColor;
        
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_bgView addSubview:_leftImageView];
        
        _title = [UILabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        _title.userInteractionEnabled = YES;
        _title.numberOfLines = 0;
        [_bgView addSubview:_title];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTap)];
        [_title addGestureRecognizer:tap];
        
        _distance = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentRight];
        [_bgView addSubview:_distance];
        
        _remarkLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:14] textColor:[UIColor hexStringToColor:@"#4d4d4d"] textAlignment:NSTextAlignmentLeft];
        _remarkLabel.numberOfLines = 0;
        [_bgView addSubview:_remarkLabel];
        
        _imageBgV = [[UIView alloc] initWithFrame:CGRectZero];
        [_bgView addSubview:_imageBgV];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#cccccc"];
        [_bgView addSubview:_line];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _leftImageView.frame = CGRectMake(15, 10, 27, 27);
    
}

- (void)setModel:(RunOrderDetailModel *)model{
    _model = model;
    CGFloat height = 15;
    
    _leftImageView.image = [UIImage imageNamed:@"receive"];
    
    _distance.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(kDistance, nil),model.distance] index:NSLocalizedString(kDistance, nil).length textColor:ButtonColor];
    _distance.frame = CGRectMake(SCREEN_WIDTH-110, height+1, 100, 13);
    
    CGFloat titleH = [StringHeight heightFromString:model.cust_address withFont:15 constraintToWidth:SCREEN_WIDTH-175];
    _title.frame = CGRectMake(55, height, SCREEN_WIDTH-175, titleH);
    _title.text = model.cust_address;
    
    if (titleH == 0) {
        titleH = 15;
    }
    
    height += titleH;
    height += 10;
    
    _line.frame = CGRectMake(10, height, SCREEN_WIDTH-20, 1);
    height += 11;
    
    CGFloat remarkH = [StringHeight heightFromString:model.remark withFont:15 constraintToWidth:SCREEN_WIDTH-40];
    
    _remarkLabel.frame = CGRectMake(20, height, SCREEN_WIDTH-40, remarkH);
    _remarkLabel.text = model.remark;
    height += remarkH;
   
    height+= 15;
    _imageBgV.frame = CGRectMake(10, height, BGWidth, (SCREEN_WIDTH-80)/5.0+10);
    if (model.imgs.count > 0) {
        _imageBgV.hidden = NO;
        for (int i=0; i< model.imgs.count; i++) {
            RunImgsModel *img = model.imgs[i];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10+(10+(SCREEN_WIDTH-80)/5.0)*i, 0, (SCREEN_WIDTH-80)/5.0, (SCREEN_WIDTH-80)/5.0)];
            imageV.userInteractionEnabled = YES;
            [imageV sd_setImageWithURL:[NSURL URLWithString:img.path]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTouch)];
            [imageV addGestureRecognizer:tap];
            [_imageBgV addSubview:imageV];
        }
    }else{
        _imageBgV.hidden = YES;
    }
    height += ((SCREEN_WIDTH-80)/5.0+20);
//    height += 15;
    
    if ([model.numState isEqualToString:@"1000"]){
        if (!_bugButton){
            _bugButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_bugButton setTitle:NSLocalizedString(@"BuyComplete", nil) forState:UIControlStateNormal];
            _bugButton.frame = CGRectMake(70, height, BGWidth-120, 34);
            [_bugButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_bugButton setBackgroundColor:ButtonColor];
            _bugButton.layer.cornerRadius = 6;
            [_bugButton addTarget:self action:@selector(bugButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [_bgView addSubview:_bugButton];
        }
        _bugButton.frame = CGRectMake(70, height, BGWidth-120, 34);
        
        
        height += 44;
    }else{
        _bugButton.hidden = YES;
    }
    
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
}

- (void)imageViewDidTouch{
    if (self.imageViewDidTouchBlock) {
        self.imageViewDidTouchBlock(_model);
    }
}

+ (CGFloat)cellHeightWithModel:(RunOrderDetailModel *)model{
    CGFloat height = 15;
    CGFloat titleH = [StringHeight heightFromString:model.cust_address withFont:15 constraintToWidth:SCREEN_WIDTH-175];
    if (titleH == 0) {
        titleH = 15;
    }
    height += titleH;
    height += 10;
    height += 11;
    height+= 15;
    height += ((SCREEN_WIDTH-80)/5.0+20);
    if ([model.numState isEqualToString:@"10000"]) {
        height += 44;
    }
    height += 10;
    CGFloat remarkH = [StringHeight heightFromString:model.remark withFont:15 constraintToWidth:SCREEN_WIDTH-40];
    height += remarkH;
    return height;
}

- (void)bugButtonClick{
    if ([self.delegate respondsToSelector:@selector(bugButtonClick:)]) {
        [self.delegate bugButtonClick:_model];
    }
}

- (void)titleTap{
    if ([self.delegate respondsToSelector:@selector(addressDidClick:)
         ]) {
        [self.delegate addressDidClick:_model];
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
