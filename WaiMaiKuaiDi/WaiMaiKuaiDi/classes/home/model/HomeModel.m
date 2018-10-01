//
//  HomeModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[OrderInfoModel class],
             };
}

@end
