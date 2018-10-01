//
//  RunUpdateOrderStateParam.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunUpdateOrderStateParam.h"

@implementation RunUpdateOrderStateParam

- (NSString *)token{
    return [UrlsManager token];
}

- (NSString *)user_id{
    return [UrlsManager userID];
}

@end
