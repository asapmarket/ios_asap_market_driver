//
//  IndentRunOderCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRunCodeModel.h"

@interface IndentRunOderCell : UITableViewCell

@property (nonatomic, strong) HomeRunCodeItem *item;

+(CGFloat)cellHeightWithModel:(HomeRunCodeItem *)model;

@property (nonatomic, copy) void (^grabButtonBlock)(HomeRunCodeItem *item);

@end
