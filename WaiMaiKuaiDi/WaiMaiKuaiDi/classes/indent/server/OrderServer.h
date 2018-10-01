//
//  OrderServer.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMainModel.h"
#import "IndentMainModel.h"
#import "FeedBackPriceParam.h"

@interface OrderServer : NSObject

//订单页
+ (void)getExpOrderCodeListWithPage:(int)page keyword:(NSString *)keyword state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone Success:(void (^)(BaseMainModel *result))success failure:(void(^)(NSError *error))failure;


+ (void)getOrderListUrlWithPage:(int)page keyword:(NSString *)keyword zip_code:(NSString *)zipCode state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone Success:(void (^)(IndentMainModel *result))success failure:(void(^)(NSError *error))failure;

//取件
+ (void)pickupFoodsWithOrderId:(NSString *)orderId foodId:(NSString *)foodId storeId:(NSString *)storeId Success:(void (^)(NSString *result))success failure:(void(^)(NSError *error))failure;

+ (void)sentToWithOrderId:(NSString *)order_id Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)payOrderWithOrderId:(NSString *)orderId Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postFeedBackPriceWithParam:(FeedBackPriceParam *)param Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

@end
