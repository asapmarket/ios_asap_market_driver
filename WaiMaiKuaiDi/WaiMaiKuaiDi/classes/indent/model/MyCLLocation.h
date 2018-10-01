//
//  MyCLLocation.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/9.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyCLLocation : NSObject

+ (MyCLLocation *)shareManager;

@property (nonatomic, strong) CLLocation *location;

/**
 开始定位
 
 @param complete 定位结果
 */
- (void)startLocation:(void(^)(CLLocation *location))complete;


/**
 停止定位
 */
- (void)stopLocation;

/**
 开始系统托管定位
 
 @param complete 定位结果
 */
- (void)startMonitoringSignificantLocationChanges:(void(^)(CLLocation *location))complete;



/**
 结束系统托管定位
 */
- (void)stopMonitoringSignificantLocationChanges;






















@end
