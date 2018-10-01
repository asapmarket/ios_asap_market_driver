//
//  DetailFoodModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailFoodSpecModel.h"

@interface DetailFoodModel : NSObject

@property (nonatomic, strong) NSString *foods_id;
@property (nonatomic, strong) NSString *foods_name_cn;
@property (nonatomic, strong) NSString *foods_name_en;
@property (nonatomic, strong) NSString *foods_quantity;
@property (nonatomic, strong) NSString *pickup_state; //0：未取件 1：已取件

@property (nonatomic, strong) NSMutableArray *spec_list;

@end
