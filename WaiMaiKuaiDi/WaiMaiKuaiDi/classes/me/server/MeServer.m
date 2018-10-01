//
//  MeServer.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MeServer.h"
#import "WHttpTool.h"

@implementation MeServer

+ (void)upDateNickName:(NSString *)nickName Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getUpDateNickNameUrlWithNickName:nickName];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)meUploadFormDataArray:(NSArray *)formDataArray success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure
{
    NSLog(@"URL:%@",kUploadURL);
    [WHttpTool postWithURL:kUploadURL params:nil formDataArray:formDataArray success:^(id json) {
        CodeModel *result = [CodeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)upDateHeadImage:(NSString *)headImage Success:(void (^)(CodeModel *result))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getUpdateHeadUrlWithHead_image:headImage];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        CodeModel *result = [CodeModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void) updatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd Success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getUpdatePwdWithOldPwd:oldPwd newPwd:newPwd];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)onTheWaySuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getOnTheWayUrl];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
