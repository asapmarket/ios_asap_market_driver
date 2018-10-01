//
//  DetailMainModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "DetailMainModel.h"

@implementation DetailMainModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"store_list":[DetailStoreModel class],
             };
}

- (void)setPayment_method:(NSString *)payment_method{
    _payment_method = payment_method;
    if ([payment_method isEqualToString:@"0"]) {
        _payment_method = @"visa";
    }else if ([payment_method isEqualToString:@"1"]){
        _payment_method = @"paypal";
    }else if ([payment_method isEqualToString:@"2"]){
        _payment_method = @"Apple Pay";
    }else if ([payment_method isEqualToString:@"4"]){
        _payment_method = NSLocalizedString(kCashPayments, nil);
    }else if([payment_method isEqualToString:@"3"]){
        _payment_method = NSLocalizedString(kPayWithCard, nil);
    }else if ([payment_method isEqualToString:@"5"]){
        _payment_method = NSLocalizedString(kRewardPoint, nil);
    }
    
}

- (void)setState:(NSString *)state{
    _state = state;
    if ([state isEqualToString:@"0"]) {
        _state = NSLocalizedString(kOrderSuccess, nil);
    }else if ([state isEqualToString:@"1"]){
        _state = NSLocalizedString(kDeliveryOrder, nil);
    }else if ([state isEqualToString:@"2"]){
        _state = NSLocalizedString(kIsTake, nil);
    }else if ([state isEqualToString:@"3"]){
        _state = NSLocalizedString(kOnRoad, nil);
    }else{
        _state = NSLocalizedString(kOrderEnd, nil);
    }
}

@end
