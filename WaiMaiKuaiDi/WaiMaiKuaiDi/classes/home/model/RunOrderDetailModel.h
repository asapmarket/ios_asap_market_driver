//
//  RunOrderDetailModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeRunCodeModel.h"

@interface RunOrderDetailModel : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *numState;
@property (nonatomic, strong) NSString *exp_id;
@property (nonatomic, strong) NSString *exp_name;
@property (nonatomic, strong) NSString *exp_lat;
@property (nonatomic, strong) NSString *exp_lng;
@property (nonatomic, strong) NSString *total_money;
@property (nonatomic, strong) NSString *creat_time;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *cust_address;
@property (nonatomic, strong) NSString *cust_name;
@property (nonatomic, strong) NSString *cust_phone;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSMutableArray *imgs;

@property (nonatomic, strong) NSString *payment_method; //支付方式
@property (nonatomic, strong) NSString *order_time; //支付时间
@property (nonatomic, assign) double addr_lat;
@property (nonatomic, assign) double addr_lng;
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, assign) NSInteger pay_state;

@end
