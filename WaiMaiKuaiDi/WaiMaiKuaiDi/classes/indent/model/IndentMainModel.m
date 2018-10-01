//
//  IndentMainModel.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "IndentMainModel.h"

@implementation IndentMainModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"rows":[OrderInfoModel class],
             };
}

@end
