//
//  TakeDetailCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/18.
//  Copyright © 2017年 王. All rights reserved.
//

#import "TakeDetailCell.h"
#import "StringColor.h"
#import "StringHeight.h"
#import "MultiParamButton.h"
#import "CreateButton.h"

@interface TakeDetailCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UIView *line;

@end

@implementation TakeDetailCell

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

- (void)setModel:(DetailMainModel *)model{
    
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
    
    height += [self heightWithStoreArray:model.store_list height:height];
    
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    
    height += 10;
}

- (CGFloat)heightWithStoreArray:(NSArray *)storeArray height:(CGFloat)height{
    CGFloat storeH = 0;
    
    if (storeArray.count == 0) {
        return storeH;
    }
    
    for (int i=0; i<storeArray.count; i++) {
        DetailStoreModel *storeModel = storeArray[i];
        
        NSString *storeName;
        NSString *storeAddr;
        if ([LanguageManager shareManager].language == 0) {
            storeName = storeModel.store_name_en;
            storeAddr = storeModel.store_address_en;
        }else{
            storeName = storeModel.store_name_cn;
            storeAddr = storeModel.store_address_cn;
        }
        CGFloat nameW = storeName.length*13>78?78:storeName.length*13;
        CGFloat nameH = [StringHeight heightFromString:storeName withFont:13 constraintToWidth:nameW];
        
        CGFloat locationW = SCREEN_WIDTH - (65+78+38);
        CGFloat locatonH = [StringHeight heightFromString:storeAddr withFont:13 constraintToWidth:locationW];
        if (nameH > locatonH) {
            locatonH = nameH;
        }else{
            nameH = locatonH;
        }

        UILabel *name = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        name.frame = CGRectMake(55, height+storeH, 78, nameH);
        name.numberOfLines = 0;
        name.text = storeName;
        [_bgView addSubview:name];
        
        
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(65+78, height+(nameH)/2-3+storeH, 3, 3)];
        circle.backgroundColor = ButtonColor;
        circle.layer.cornerRadius = 1.5f;
        [_bgView addSubview:circle];
        
        UILabel *location = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        location.numberOfLines = 0;
        
        location.frame = CGRectMake(65+78+28, height+storeH, locationW, nameH);
        location.text = storeAddr;
        [_bgView addSubview:location];
        
        
        storeH += nameH;
        
        storeH += [self heightWithFoodArray:storeModel.foods_list height:(height+storeH) offsetY:(65+78+23) storeIndex:i];
        
    }
    
    return storeH;
}

- (CGFloat)heightWithFoodArray:(NSArray *)foodArray height:(CGFloat)height offsetY:(CGFloat) offsetY storeIndex:(int)storeIndex{
    CGFloat foodH = 10;
    if (foodArray.count == 0){
        return foodH;
    }
    for (int i=0; i<foodArray.count; i++) {
        DetailFoodModel *model = foodArray[i];
        NSString *foodName;
        if ([LanguageManager shareManager].language == 0) {
            foodName = model.foods_name_en;
        }else{
            foodName = model.foods_name_cn;
        }
        NSString *foodStr = [NSString stringWithFormat:@"%@ *%@",foodName,model.foods_quantity];
        UILabel *foodNameLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        foodNameLabel.numberOfLines = 2;
        foodNameLabel.frame = CGRectMake(offsetY, height+foodH, SCREEN_WIDTH-offsetY-10, 34);
        foodNameLabel.text = foodStr;
        [_bgView addSubview:foodNameLabel];
        
        foodH += 44;
    }
    
    return foodH;
}

+ (CGFloat)cellHeightWithModel:(DetailMainModel *)model{
    CGFloat height = 15;
    CGFloat titleH = [StringHeight heightFromString:model.cust_address withFont:15 constraintToWidth:SCREEN_WIDTH-175];
    if (titleH == 0) {
        titleH = 15;
    }
    height += titleH;
    height += 10;
    height += 11;
    
    CGFloat storeH = 0;
    
    if (model.store_list.count == 0) {
        return height;
    }
    
    for (DetailStoreModel *storeModel in model.store_list) {
        
        NSString *storeName;
        NSString *storeAddr;
        if ([LanguageManager shareManager].language == 0) {
            storeName = storeModel.store_name_en;
            storeAddr = storeModel.store_address_en;
        }else{
            storeName = storeModel.store_name_cn;
            storeAddr = storeModel.store_address_cn;
        }

        
        CGFloat nameW = storeName.length*13>78?78:storeName.length*13;
        CGFloat nameH = [StringHeight heightFromString:storeName withFont:13 constraintToWidth:nameW];
        
        CGFloat locationW = SCREEN_WIDTH - (65+78+33);
        CGFloat locatonH = [StringHeight heightFromString:storeAddr withFont:13 constraintToWidth:locationW];
        
        if (nameH >= locatonH && nameH != 0) {
            storeH += nameH;
        }else if (locatonH != 0){
            storeH += locatonH;
        }else{
            storeH += 13;
        }
        
        if (storeModel.foods_list.count > 0) {
            storeH += 54*storeModel.foods_list.count;
        }else{
            storeH += 10;
        }
    }
    
    height += storeH;
    
    height += 10;
    
    return height;
}

- (void)titleTap{
    if ([self.delegate respondsToSelector:@selector(addressDidClick:)
         ]) {
        [self.delegate addressDidClick:_model];
    }
}

- (void)buttonClick:(MultiParamButton *)btn{
    if (!btn.isSelected) {
        [btn setTitle:NSLocalizedString(kTaked, nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.selected = YES;
        
        NSLog(@"indentInfo = %@", btn.multiParamDic);
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
