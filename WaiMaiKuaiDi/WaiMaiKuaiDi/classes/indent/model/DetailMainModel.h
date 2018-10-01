//
//  DetailMainModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailStoreModel.h"
#import "DetailFoodModel.h"

@interface DetailMainModel : NSObject

@property (nonatomic, strong) NSString *order_id;    //订单号
@property (nonatomic, strong) NSString *cust_phone;  //手机号码
@property (nonatomic, strong) NSString *payment_method; //支付方式
@property (nonatomic, strong) NSString *order_time; //支付时间
@property (nonatomic, strong) NSString *create_time; 
@property (nonatomic, strong) NSString *state; // 订单状态
@property (nonatomic, strong) NSString *cust_address; //订单地址
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *pay_state;

@property (nonatomic, strong) NSString *total_money;
@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *distribution_time;


@property (nonatomic, strong) NSMutableArray *store_list;

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;

@end
