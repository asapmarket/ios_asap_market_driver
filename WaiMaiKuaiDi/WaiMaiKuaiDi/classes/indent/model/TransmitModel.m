//
//  TransmitModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "TransmitModel.h"

@implementation TransmitModel
//@property (nonatomic, strong) NSString *keyword;
//@property (nonatomic, strong) NSString *state;
//@property (nonatomic, strong) NSString *start_time;
//@property (nonatomic, strong) NSString *end_time;
//@property (nonatomic, strong) NSString *pay_method;
//@property (nonatomic, strong) NSString *order_id;
//@property (nonatomic, strong) NSString *cust_phone;

- (NSString *)keyword{
    if (!_keyword) {
        _keyword = @"";
    }
    return _keyword;
}

- (NSString *)state{
    if (!_state) {
        _state = @"";
    }
    return _state;
}

- (NSString *)end_time{
    if (!_end_time) {
        _end_time = @"";
    }
    return _end_time;
}

- (NSString *)order_id{
    if (!_order_id) {
        _order_id = @"";
    }
    return _order_id;
}

- (NSString *)start_time{
    if (!_start_time) {
        _start_time = @"";
    }
    return _start_time;
}

- (NSString *)cust_phone{
    if (!_cust_phone) {
        _cust_phone = @"";
    }
    return _cust_phone;
}

- (NSString *)pay_method{
    if (!_pay_method) {
        _pay_method = @"";
    }
    return _pay_method;
}


@end
