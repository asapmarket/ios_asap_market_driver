//
//  RunOrderParam.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunOrderParam : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *page_size;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *pay_method;
@property (nonatomic, strong) NSString *start_time;
@property (nonatomic, strong) NSString *cust_phone;
@property (nonatomic, strong) NSString *exp_id;
@property (nonatomic, strong) NSString *zip_code;


@end
