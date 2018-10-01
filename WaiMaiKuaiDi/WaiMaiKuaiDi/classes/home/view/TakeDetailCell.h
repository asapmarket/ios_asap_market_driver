//
//  TakeDetailCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/18.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMainModel.h"

@class TakeDetailCell;

@protocol TakeDetailCellDelegate <NSObject>

- (void)addressDidClick:(DetailMainModel *)mainModel;

@end

@interface TakeDetailCell : UITableViewCell

@property (nonatomic, strong) id<TakeDetailCellDelegate>delegate;

@property (nonatomic, strong) DetailMainModel *model;

+ (CGFloat)cellHeightWithModel:(DetailMainModel *)model;
@end
