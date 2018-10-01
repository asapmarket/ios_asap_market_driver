//
//  HomeRunCodeModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import "HomeRunCodeModel.h"

@implementation HomeRunCodeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[HomeRunCodeItem class],
             };
}

@end

@implementation HomeRunCodeItem

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imgs":[RunImgsModel class],
             };
}

- (void)setPayment_method:(NSString *)payment_method{
    _payment_type = payment_method;
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

@end

@implementation RunImgsModel

@end
