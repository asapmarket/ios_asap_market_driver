//
//  DetailHeaderCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMainModel.h"

@class DetailHeaderCell;

@protocol DetailHeaderCellDelegate <NSObject>

- (void)addressDidClick:(DetailMainModel *)mainModel;

@end

@interface DetailHeaderCell : UITableViewCell

@property (nonatomic, strong) id<DetailHeaderCellDelegate>delegate;

@property (nonatomic, strong) DetailMainModel *model;

+ (CGFloat)cellHeightWithModel:(DetailMainModel *)model;

@end
