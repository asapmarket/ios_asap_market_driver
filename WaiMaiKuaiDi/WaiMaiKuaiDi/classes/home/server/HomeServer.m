//
//  HomeServer.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/19.
//  Copyright © 2017年 王. All rights reserved.
//

#import "HomeServer.h"
#import "WHttpTool.h"

@implementation HomeServer

+ (void)uploadLocationWithLat:(double)lat lng:(double)lng Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager updateLocationWithLat:lat lng:lng];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getHomePageInfoWithPage:(int)page Success:(void (^)(BaseMainModel *))success failure:(void (^)(NSError *))failure {
    NSString *url = [UrlsManager getHomePageUrlWithPage:page];
    
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        BaseMainModel *result = [BaseMainModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getOrderListByZipCodeWithZipCode:(NSString *)zipCode page:(int)page Success:(void (^)(HomeModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getOrderListByZipCodeWithPage:page zipCode:zipCode];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        HomeModel *result = [HomeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getOrderDetailWithOrderId:(NSString *)orderId Success:(void (^)(DetailMainModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getOrderDetailUrlWithOrderId:orderId];
    
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        DetailMainModel *result = [DetailMainModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)takeOrderWithOrderId:(NSString *)orderId Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getTakeOrdersUrlWithOrderId:orderId];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getMapOrderListSuccess:(void (^)(MapOrderBaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getMapOrderList];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        MapOrderBaseModel *result = [MapOrderBaseModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postHomeRunOrderListWithParam:(RunOrderParam *)param Success:(void (^)(BaseMainModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunHomeOrderUrl params:param.mj_keyValues success:^(id json) {
        BaseMainModel *result = [BaseMainModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postHomeRunCodeListWithParam:(RunOrderParam *)param Success:(void (^)(HomeRunCodeModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunHomeCodeUrl params:param.mj_keyValues success:^(id json) {
        HomeRunCodeModel *result = [HomeRunCodeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postTakeRunOrderWithParam:(RunOrderDetailParam *)param Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunTakeOrderUrl params:param.mj_keyValues success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postRunOrderDetailWithParam:(RunOrderDetailParam *)param Success:(void (^)(RunOrderDetailModel *))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kRunTakeOrderDetailUrl params:param.mj_keyValues success:^(id json) {
        RunOrderDetailModel *model = [RunOrderDetailModel mj_objectWithKeyValues:json];
        success(model);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postUpdateRunOrderStateWithParam:(RunUpdateOrderStateParam *)param Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [WHttpTool postWithURL:kUpDateRunOrderStateUrl params:param.mj_keyValues success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
