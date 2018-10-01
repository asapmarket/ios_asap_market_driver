//
//  HomeModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/27.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfoModel.h"
#import "StoreInfoModel.h"

@interface HomeModel : NSObject

//总条数
@property (nonatomic, strong) NSString *total;
//总页数
@property (nonatomic, strong) NSString *total_page;

@property (nonatomic, strong) NSMutableArray *rows;

@property (nonatomic, strong) NSString *onwork; //0:下班 1：上班(上班状态才能抢单)

@end
