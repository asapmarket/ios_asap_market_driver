//
//  MeServer.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeModel.h"

@interface MeServer : NSObject

+ (void)upDateNickName:(NSString *)nickName Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+(void)meUploadFormDataArray:(NSArray *)formDataArray success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)upDateHeadImage:(NSString *)headImage Success:(void (^)(CodeModel *result))success failure:(void(^)(NSError *error))failure;

+ (void)updatePwdWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd Success:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)onTheWaySuccess:(void (^)(id result))success failure:(void(^)(NSError *error))failure;

@end
