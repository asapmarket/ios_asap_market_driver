//
//  DetailStoreModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "DetailStoreModel.h"

@implementation DetailStoreModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"foods_list":[DetailFoodModel class],
             };
}
@end
