//
//  FeedBackPriceParam.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/29.
//  Copyright © 2018年 王. All rights reserved.
//

#import "FeedBackPriceParam.h"

@implementation FeedBackPriceParam

- (NSString *)token{
    return [UrlsManager token];
}

- (NSString *)user_id{
    return [UrlsManager userID];
}

@end
