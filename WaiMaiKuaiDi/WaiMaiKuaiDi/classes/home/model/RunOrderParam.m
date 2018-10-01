//
//  RunOrderParam.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/27.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunOrderParam.h"

@implementation RunOrderParam

- (NSString *)token{
    return [UrlsManager token];
}

- (NSString *)user_id{
    return [UrlsManager userID];
}

@end
