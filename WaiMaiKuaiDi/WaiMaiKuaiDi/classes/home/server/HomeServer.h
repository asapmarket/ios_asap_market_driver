//
//  HomeServer.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/19.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMainModel.h"
#import "HomeModel.h"
#import "DetailMainModel.h"
#import "MapOrderBaseModel.h"
#import "RunOrderParam.h"
#import "HomeRunCodeModel.h"
#import "RunOrderDetailParam.h"
#import "RunOrderDetailModel.h"
#import "RunUpdateOrderStateParam.h"

@interface HomeServer : NSObject

//首页接口
+ (void)getHomePageInfoWithPage:(int)page Success:(void (^)(BaseMainModel *result))success failure:(void(^)(NSError *error))failure;

//首页邮编订单接口
+ (void)getOrderListByZipCodeWithZipCode:(NSString *)zipCode page:(int)page Success:(void (^)(HomeModel *result))success failure:(void(^)(NSError *error))failure;

//订单详情
+ (void)getOrderDetailWithOrderId:(NSString *)orderId Success:(void (^)(DetailMainModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)takeOrderWithOrderId:(NSString *)orderId Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)getMapOrderListSuccess:(void (^)(MapOrderBaseModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)uploadLocationWithLat:(double)lat lng:(double)lng Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

//跑腿订单接口
+ (void)postHomeRunOrderListWithParam:(RunOrderParam *)param Success:(void (^)(BaseMainModel *result))success failure:(void(^)(NSError *error))failure;

//跑腿订单code接口
+ (void)postHomeRunCodeListWithParam:(RunOrderParam *)param Success:(void (^)(HomeRunCodeModel *result))success failure:(void(^)(NSError *error))failure;

//跑腿接单
+ (void)postTakeRunOrderWithParam:(RunOrderDetailParam *)param Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postRunOrderDetailWithParam:(RunOrderDetailParam *)param Success:(void (^)(RunOrderDetailModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)postUpdateRunOrderStateWithParam:(RunUpdateOrderStateParam *)param Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

@end
