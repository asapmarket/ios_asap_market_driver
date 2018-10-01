//
//  MyRTLocation.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyRTLocation.h"

@interface MyRTLocation ()

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;

@end

@implementation MyRTLocation{
    GMSMapView *_mapView;
    BOOL _firstLocationUpdate;
}


+ (MyRTLocation *)shareLocation{
    static MyRTLocation *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (nil == manager) {
            manager = [[MyRTLocation alloc] init];
        }
    });
    return manager;
}

- (id)init{
    self = [super init];
    if (self) {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                                longitude:151.2086
                                                                     zoom:12];
        
        _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        _mapView.settings.compassButton = YES;
        _mapView.settings.myLocationButton = YES;
        
        // Listen to the myLocation property of GMSMapView.
        [_mapView addObserver:self
                   forKeyPath:@"myLocation"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
                
        // Ask for My Location data after the map has already been added to the UI.
        dispatch_async(dispatch_get_main_queue(), ^{
            _mapView.myLocationEnabled = YES;
        });
 
    }
    return self;
}

- (void)dealloc {
    [_mapView removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!_firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        _firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        _mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
        _lat = location.coordinate.latitude;
        _lng = location.coordinate.longitude;
        if (_successBlock) {
            _successBlock(location.coordinate.latitude, location.coordinate.longitude);
        }
        NSLog(@"myLocation:latitude= %f longitude = %f",location.coordinate.latitude, location.coordinate.longitude);
    }else{
        
    }
}

@end
