//
//  OrderInfoModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderInfoModel.h"

@implementation OrderInfoModel


+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"store_list":[StoreInfoModel class],
             };
}

- (void)setState:(NSString *)state{
    _state = state;
    if ([state isEqualToString:@"0"]){
        _state = NSLocalizedString(kOrderSuccess, nil);
    }else if([state isEqualToString:@"1"]){
        _state = NSLocalizedString(kTakeOrderSuccess, nil);
    }else if ([state isEqualToString:@"2"]){
        _state = NSLocalizedString(kTake, nil);

    }else if([state isEqualToString:@"3"]){
        _state = NSLocalizedString(kOnRoad, nil);

    }else{
        _state = NSLocalizedString(kCompleted, nil);
    }
}


@end
