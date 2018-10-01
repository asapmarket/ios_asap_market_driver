//
//  OrderListViewController.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BaseViewController.h"
#import "TransmitModel.h"

@interface OrderListViewController : BaseViewController

@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) TransmitModel *transmitModel;
@property (nonatomic, strong) NSString *keywork;
@property (nonatomic, assign) BOOL isFinish;

@end
