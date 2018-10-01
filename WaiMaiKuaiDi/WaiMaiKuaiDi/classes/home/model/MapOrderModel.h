//
//  MapOrderModel.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/18.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapOrderModel : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;

@end
