//
//  RunUpdateOrderStateParam.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2018/3/28.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunUpdateOrderStateParam : NSObject

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *state;
@end
