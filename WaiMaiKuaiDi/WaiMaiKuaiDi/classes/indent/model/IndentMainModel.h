//
//  IndentMainModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfoModel.h"
#import "StoreInfoModel.h"
@interface IndentMainModel : NSObject
//总条数
@property (nonatomic, strong) NSString *total;
//总页数
@property (nonatomic, strong) NSString *total_page;

@property (nonatomic, strong) NSMutableArray *rows;
@end
