//
//  HomeRunCodeModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeRunCodeModel : NSObject

@property (nonatomic, strong) NSMutableArray *rows;

@end

@interface HomeRunCodeItem : NSObject

@property (nonatomic, strong) NSString *cust_address;
@property (nonatomic, strong) NSString *extm_id;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *pay_state;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSString *payment_method;
@property (nonatomic, strong) NSString *payment_type;

@end

@interface RunImgsModel : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong)NSString *sort;

@end
