//
//  DetailHeaderCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "DetailHeaderCell.h"
#import "StringColor.h"
#import "StringHeight.h"
#import "MultiParamButton.h"
#import "CreateButton.h"
#import "OrderServer.h"

@interface DetailHeaderCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UIView *line;


@end

@implementation DetailHeaderCell

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
    
    _leftImageView.image = [UIImage imageNamed:NSLocalizedString(kRecieve, nil)];

    _distance.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@%.2fkm",NSLocalizedString(kDistance, nil),[model.distance doubleValue]] index:NSLocalizedString(kDistance, nil).length textColor:ButtonColor];
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
    
    [self heightWithStoreArray:model.store_list height:height];

    height += [self storeHeightWithModel:model];
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    
    height += 10;
}

- (CGFloat)storeHeightWithModel:(DetailMainModel *)model{
    CGFloat storeH = 0;
    
    if (model.store_list.count == 0) {
        return storeH;
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
        
        CGFloat locationW = SCREEN_WIDTH - (65+nameW+33);
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
    return storeH;
}

- (void)heightWithStoreArray:(NSArray *)storeArray height:(CGFloat)height{
    CGFloat storeH = 0;
    
    if (storeArray.count == 0) {
        return;
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

        CGFloat nameW = storeName.length*13>78?78:storeModel.store_name_cn.length*13;
        CGFloat nameH = [StringHeight heightFromString:storeName withFont:13 constraintToWidth:nameW];
        
        CGFloat locationW = SCREEN_WIDTH - (65+78+33);
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
        
    
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(65+78, height+storeH + nameH/2.0-3, 3, 3)];
        circle.backgroundColor = ButtonColor;
        circle.layer.cornerRadius = 1.5f;
        [_bgView addSubview:circle];
        
        UILabel *location = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        location.numberOfLines = 0;
        
        
        location.frame = CGRectMake(65+78+23, height+storeH, locationW, nameH);
        location.text = storeAddr;
        [_bgView addSubview:location];
        
        storeH += nameH;

        [self heightWithFoodArray:storeModel.foods_list height:(height+storeH) offsetY:(65+78+23) storeIndex:i];
        if (storeModel.foods_list.count > 0) {
            storeH += 54*storeModel.foods_list.count;
        }else{
            storeH += 10;
        }
    }
    
}

- (void)heightWithFoodArray:(NSArray *)foodArray height:(CGFloat)height offsetY:(CGFloat) offsetY storeIndex:(int)storeIndex{
    CGFloat foodH = 10;
    if (foodArray.count == 0){
        return;
    }
    for (int i=0; i<foodArray.count; i++) {
        DetailFoodModel *model = foodArray[i];
        
        NSString *foodName;
        if ([LanguageManager shareManager].language == 0) {
            foodName = model.foods_name_en;
        }else{
            foodName = model.foods_name_cn;
        }
        
        NSString *foodStr = [NSString stringWithFormat:@"%@%@ *%@",foodName,[self specStrWithArray:model.spec_list],model.foods_quantity];
        UILabel *foodNameLabel = [UILabel createLabelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
        foodNameLabel.numberOfLines = 2;
        foodNameLabel.frame = CGRectMake(offsetY, height+foodH, SCREEN_WIDTH-offsetY-82, 34);
        foodNameLabel.text = foodStr;
        [_bgView addSubview:foodNameLabel];

        if ([model.pickup_state isEqualToString:@"0"]) {
            
            DetailStoreModel *storeModel = _model.store_list[storeIndex];
            DetailFoodModel *foodModel = storeModel.foods_list[i];
            NSDictionary *indentDick = @{@"storeModel":storeModel, @"foodModel":foodModel};
            
            MultiParamButton *btn = [CreateButton creatButtonWithFrame:CGRectMake(SCREEN_WIDTH-72, height+foodH, 62, 34) title:NSLocalizedString(kTake, nil) backCoclor:ButtonColor tittleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] target:self action: @selector(buttonClick:)];
            btn.tag = 10000+i+storeIndex;
            btn.multiParamDic = indentDick;
            btn.selected = NO;
            [_bgView addSubview:btn];
        }else{
            MultiParamButton *btn = [CreateButton creatButtonWithFrame:CGRectMake(SCREEN_WIDTH-72, height+foodH, 62, 34) title:NSLocalizedString(kTaked, nil) backCoclor:[UIColor whiteColor] tittleColor:[UIColor hexStringToColor:@"#999999"] font:[UIFont systemFontOfSize:13] target:nil action:nil];
            btn.tag = 10000+i+storeIndex;
            [_bgView addSubview:btn];
        }
        
        foodH += 49;
    }
    
}

- (NSString *)specStrWithArray:(NSMutableArray *)array{
    NSString *str = @"";
    if (array.count == 0) {
        return str;
    }else{
        for (DetailFoodSpecModel *model in array) {
            if ([LanguageManager shareManager].language == 0) {
                if (str.length == 0) {
                    str = [NSString stringWithFormat:@"_%@", model.spec_name_en];
                }else{
                    str = [NSString stringWithFormat:@"%@,%@",str, model.spec_name_en];
                }
            }else{
                if (str.length == 0) {
                    str = [NSString stringWithFormat:@"_%@", model.spec_name_cn];
                }else{
                    str = [NSString stringWithFormat:@"%@,%@",str, model.spec_name_cn];
                }
            }
        }
        return str;
    }
    return str;
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
        return storeH;
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
        
        CGFloat locationW = SCREEN_WIDTH - (65+nameW+33);
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
        DetailFoodModel *foodModel = [btn.multiParamDic objectForKey:@"foodModel"];
        DetailStoreModel *storeModel = [btn.multiParamDic objectForKey:@"storeModel"];

        [OrderServer pickupFoodsWithOrderId:_model.order_id foodId:foodModel.foods_id storeId:storeModel.store_id Success:^(id result) {
            [btn setTitle:NSLocalizedString(kTaked, nil) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.selected = YES;
            NSLog(@"%@",result);
        } failure:^(NSError *error) {
            
        }];
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
