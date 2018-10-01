//
//  RunOrderDetailCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunOrderDetailModel.h"

@class RunOrderDetailCell;

@protocol RunOrderDetailCellDelegate <NSObject>

- (void)addressDidClick:(RunOrderDetailModel *)mainModel;

- (void)bugButtonClick:(RunOrderDetailModel *)model;

@end

@interface RunOrderDetailCell : UITableViewCell

@property (nonatomic, strong) RunOrderDetailModel *model;

@property (nonatomic, strong) id<RunOrderDetailCellDelegate>delegate;

+ (CGFloat)cellHeightWithModel:(RunOrderDetailModel *)model;

@property (nonatomic, copy) void (^imageViewDidTouchBlock)(RunOrderDetailModel *detailModel);


@end
