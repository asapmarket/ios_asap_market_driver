//
//  BaseMainModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/16.
//  Copyright © 2017年 王. All rights reserved.
//

#import "BaseMainModel.h"

@implementation BaseMainModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[BaseModel class],
             };
}

@end
