//
//  MapOrderBaseModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/18.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MapOrderBaseModel.h"

@implementation MapOrderBaseModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[MapOrderModel class],
             };
}

@end
