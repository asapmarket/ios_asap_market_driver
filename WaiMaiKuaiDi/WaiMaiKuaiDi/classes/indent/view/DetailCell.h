//
//  DetailCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

- (void)configWithTitle:(NSString *)title desc:(NSString *)desc index:(NSUInteger)index;

@end
