//
//  DetailRemarkCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/10/12.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailRemarkCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *lineView;
- (void)configWithTitle:(NSString *)title desc:(NSString *)desc index:(NSUInteger)index;

+ (CGFloat)cellHeightWithRemark:(NSString *)remark;

@end
