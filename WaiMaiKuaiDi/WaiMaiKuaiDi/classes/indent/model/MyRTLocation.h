//
//  MyRTLocation.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyRTLocation : NSObject

@property (nonatomic,copy) void(^successBlock)(double latitude, double longitude);

+ (MyRTLocation *)shareLocation;


/**
 开始定位

 @param complete 定位结果
 */
- (void)startLocation:(void(^)(CLLocation *location))complete;













@end
