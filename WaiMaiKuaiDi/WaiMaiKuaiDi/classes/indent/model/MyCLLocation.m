//
//  MyCLLocation.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/9.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyCLLocation.h"

static MyCLLocation *myCLLocation = nil;

@interface MyCLLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) void(^complete)(CLLocation *location);

@end

@implementation MyCLLocation

+ (MyCLLocation *)shareManager{
    static MyCLLocation *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (nil == manager) {
            manager = [[MyCLLocation alloc] init];
        }
    });
    return manager;
}

- (id)init{
    self = [super init];
    if (self) {
        if ([CLLocationManager locationServicesEnabled]) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager requestAlwaysAuthorization];
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.distanceFilter = 10;
            if([[[UIDevice currentDevice] systemVersion]floatValue] >=8) {
                [_locationManager requestAlwaysAuthorization];
            }
            if([[[UIDevice currentDevice] systemVersion]floatValue] >=9) {
                _locationManager.allowsBackgroundLocationUpdates=YES;
            }
            _locationManager.pausesLocationUpdatesAutomatically = NO;
            _locationManager.activityType = CLActivityTypeFitness;
        }
    }
    return self;
}

- (void)startLocation:(void (^)(CLLocation *))complete{
    self.complete = complete;
    [_locationManager startUpdatingLocation];
    [_locationManager startUpdatingHeading];
}

- (void)stopLocation{
    [_locationManager stopUpdatingLocation];
    [_locationManager startUpdatingHeading];
}

- (void)startMonitoringSignificantLocationChanges:(void (^)(CLLocation *))complete{
    
    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopMonitoringSignificantLocationChanges{
    [_locationManager stopMonitoringSignificantLocationChanges];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (self.complete) {
        if (locations.count > 0){
            _location = [locations firstObject];
            self.complete([locations firstObject]);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

































@end
