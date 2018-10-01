//
//  TransmitModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransmitModel : NSObject

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *pay_method;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *cust_phone;

@end
