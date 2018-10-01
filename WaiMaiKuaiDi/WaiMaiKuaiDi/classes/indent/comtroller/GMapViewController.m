//
//  GMapViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/29.
//  Copyright © 2017年 王. All rights reserved.
//

#import "GMapViewController.h"
#import "MyCLLocation.h"
#import "DataModels.h"
#import "WHttpTool.h"
@import GoogleMaps;

@interface GMapViewController ()<GMSMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) NSArray *endLocationArray;
@property (nonatomic, strong) LocationClass *location;
@property (nonatomic, strong) Routes *routes;
@property (nonatomic, strong) Legs *legs;
@property (nonatomic, strong) StartLocation *startLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation GMapViewController{
    GMSMapView *_mapView;
    GMSGeocoder *_geocoder;
    
    UIWebView *webView;
}

- (void)initLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
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
        [_locationManager startUpdatingLocation];
        [_locationManager startUpdatingHeading];
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_locationManager stopUpdatingHeading];
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
    _locationManager = nil;
    [_mapView removeFromSuperview];
    _mapView.delegate = nil;
    _mapView = nil;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kGPS, nil);
    [self initLocationManager];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count > 0){
        CLLocation *loc = [locations firstObject];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:loc.coordinate.latitude                                                                longitude:loc.coordinate.longitude
                                                                     zoom:14];
        _mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
        _mapView.myLocationEnabled = YES;
        [self.view addSubview: _mapView];

        [self driveWithLoc:loc];
    }
}



- (void)driveWithLoc:(CLLocation *)loc{
    NSString *url = [NSString stringWithFormat:kMapUrl,loc.coordinate.latitude, loc.coordinate.longitude, _lat, _lng];
    
    [WHttpTool getMapWithURL:url params:nil success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _location = [LocationClass modelObjectWithDictionary:json];
            if (_location.routes.count > 0) {
                _routes = _location.routes[_location.routes.count/2];
                if (_routes.legs.count > 0) {
                    _legs = _routes.legs[0];
                    _startLocation = _legs.startLocation;
                    _endLocationArray = _legs.steps;
                    
                    GMSMutablePath *path = [GMSMutablePath path];
                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_startLocation.lat, _startLocation.lng);
                    [path addCoordinate:coordinate];
                    CLLocationCoordinate2D endlocation;

                    {
                        for (Steps *step in _endLocationArray) {
                            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(step.endLocation.lat, step.endLocation.lng);
                            [path addCoordinate:coordinate];
                            
                        }
                        Steps  *end = [_endLocationArray lastObject];
                        endlocation = CLLocationCoordinate2DMake(end.endLocation.lat, end.endLocation.lng);
                    }
                    
                    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                    polyline.strokeColor = ButtonColor;
                    polyline.strokeWidth = 6.f;
                    polyline.geodesic = YES;
                    polyline.map = _mapView;
                    
                    
                    
                    GMSMarker *endMarker = [GMSMarker markerWithPosition:endlocation];
                    endMarker.icon = [UIImage imageNamed:@"order_icon"];
                    endMarker.map = _mapView;
                    
                    
                }
            }
            
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
