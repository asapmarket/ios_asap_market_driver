//
//  BaseViewCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/16.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) BaseModel *model;

@end
