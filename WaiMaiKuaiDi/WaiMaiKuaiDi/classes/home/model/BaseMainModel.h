//
//  BaseMainModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/16.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BaseMainModel : NSObject

//总条数
@property (nonatomic, strong) NSString *total;
//总页数
@property (nonatomic, strong) NSString *total_page;

@property (nonatomic, strong) NSMutableArray *rows;

@end
