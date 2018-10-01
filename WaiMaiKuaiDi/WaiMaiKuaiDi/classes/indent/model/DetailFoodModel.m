//
//  DetailFoodModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "DetailFoodModel.h"

@implementation DetailFoodModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"spec_list":[DetailFoodSpecModel class],
             };
}

@end
