//
//  CashPayCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/10/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CashPayCell;

@protocol CashPayCellDelegate <NSObject>

- (void)confirmReceiptButtonClick:(UIButton *)button;

@end

@interface CashPayCell : UITableViewCell

@property (nonatomic, weak) id<CashPayCellDelegate>delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confirmReceipt;

@end
