//
//  HomeCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@class HomeCell;

@protocol HomeCellDelegate <NSObject>

- (void)grapButtonClickWithModel:(OrderInfoModel *)infoModel;

@end

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) NSString *status;

@property (nonatomic, weak) id<HomeCellDelegate>delegate;

@property (nonatomic, strong) OrderInfoModel *infoModel;

+(CGFloat)cellHeightWithModel:(OrderInfoModel *)model;

@end
