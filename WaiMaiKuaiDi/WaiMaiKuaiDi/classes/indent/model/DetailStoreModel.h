//
//  DetailStoreModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailFoodModel.h"

@interface DetailStoreModel : NSObject

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSString *store_name_cn;
@property (nonatomic, strong) NSString *store_name_en;
@property (nonatomic, strong) NSString *store_address_cn;
@property (nonatomic, strong) NSString *store_address_en;
@property (nonatomic, strong) NSMutableArray *foods_list;

@end
