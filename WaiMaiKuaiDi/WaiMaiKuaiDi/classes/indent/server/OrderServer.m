//
//  OrderServer.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderServer.h"
#import "WHttpTool.h"

@implementation OrderServer

+ (void)getExpOrderCodeListWithPage:(int)page keyword:(NSString *)keyword state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone Success:(void (^)(BaseMainModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getExpOrderCodeListUrlWithPage:page keyword:keyword state:state start_time:start_time end_time:end_time pay_method:pay_method order_id:orderId cust_phone:cust_phone];
    
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        BaseMainModel *result = [BaseMainModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

+ (void)getOrderListUrlWithPage:(int)page keyword:(NSString *)keyword zip_code:(NSString *)zipCode state:(NSString *)state start_time:(NSString *)start_time end_time:(NSString *)end_time pay_method:(NSString *)pay_method order_id:(NSString *)orderId cust_phone:(NSString *)cust_phone Success:(void (^)(IndentMainModel *))success failure:(void (^)(NSError *))failure{
    
    NSString *url = [UrlsManager getOrderListUrlWithPage:page keyword:keyword zip_code:zipCode state:state start_time:start_time end_time:end_time pay_method:pay_method order_id:orderId cust_phone:cust_phone];
    
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        IndentMainModel *result = [IndentMainModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)pickupFoodsWithOrderId:(NSString *)orderId foodId:(NSString *)foodId storeId:(NSString *)storeId Success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getPickupOrderFoodsUrlWithOrderId:orderId foodId:foodId storeId:storeId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json[@" order_state "]); //1:所有商品取件完成
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)sentToWithOrderId:(NSString *)order_id Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getSentToUrlWithOrderId:order_id];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)payOrderWithOrderId:(NSString *)orderId Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getPayOrderUrlWithOrderId:orderId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postFeedBackPriceWithParam:(FeedBackPriceParam *)param Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kFeedBackOrderPriceUrl params:param.mj_keyValues success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

















@end
