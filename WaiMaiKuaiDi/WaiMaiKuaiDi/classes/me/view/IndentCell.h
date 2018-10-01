//
//  IndentCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/23.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@class IndentCell;

@protocol  IndentCellDelegate <NSObject>

- (void)endButtonClickWithModel:(OrderInfoModel *)model;

@end

@interface IndentCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *indentNo;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *indentStatus;
@property (nonatomic, strong) UILabel *distributionTime;

@property (nonatomic, strong) UIView *circle1;
@property (nonatomic, strong) UIView *circle2;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIButton *endButton;

@property (nonatomic, weak)id<IndentCellDelegate>delegate;

@property (nonatomic, strong) OrderInfoModel *infoModel;

+(CGFloat)cellHeightWithModel:(OrderInfoModel *)model;


@end
