//
//  OrderInfoModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreInfoModel.h"

@interface OrderInfoModel : NSObject

//邮编
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *cust_address;
@property (nonatomic, strong) NSString *order_time;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *is_urge;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSMutableArray *store_list;
@property (nonatomic, strong) NSString *distribution_time;
                                    
@end
