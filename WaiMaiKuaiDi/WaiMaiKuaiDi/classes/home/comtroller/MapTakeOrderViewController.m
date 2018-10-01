//
//  MapTakeOrderViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/8/18.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MapTakeOrderViewController.h"
#import "TakeOrderDetailViewController.h"
#import "MyCLLocation.h"
#import "MapOrderBaseModel.h"
#import <GoogleMaps/GoogleMaps.h>
#import <QuartzCore/QuartzCore.h>
#import "HomeServer.h"

@interface MapTakeOrderViewController ()<GMSMapViewDelegate>

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) MapOrderBaseModel *baseModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *trackData;
@property (nonatomic, strong)     GMSPolyline *polyline;

@end

@implementation MapTakeOrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(kMapRecieveOrder, nil);
}

- (void)initData{
    [HomeServer getMapOrderListSuccess:^(MapOrderBaseModel *result) {
        _baseModel = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            _dataArray = _baseModel.rows;
            [self initView];
        });
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)initView{
    
    if (_dataArray.count == 0) {
        return;
    }
    MapOrderModel *orderModel = _dataArray[0];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:orderModel.lat
                                                            longitude:orderModel.lng
                                                                 zoom:14];
    
    _mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
    _trackData = [[NSMutableArray alloc] init];
    
    GMSMutablePath *gmsPath = [GMSMutablePath path];
    
    for (MapOrderModel *model in _dataArray) {
        [gmsPath addLatitude:model.lat longitude:model.lng];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:model.lat longitude:model.lng];
        [_trackData addObject:loc];
    }
    
    for (int i = 0; i < [gmsPath count]; i++) {
        MapOrderModel *model = _dataArray[i];
        CLLocationCoordinate2D location = [gmsPath coordinateAtIndex: i];
        GMSMarker *marker = [GMSMarker markerWithPosition:location];
        marker.title = model.order_id;
        marker.icon = [UIImage imageNamed:@"order_icon"];
        marker.map = _mapView;
    }
    
    _polyline = [GMSPolyline polylineWithPath:gmsPath];
    _polyline.strokeWidth = 0.00000001;
    _polyline.map = _mapView;
    
    
    [_polyline setSpans:[self gradientSpans]];

}

- (NSArray *)gradientSpans {
    NSMutableArray *colorSpans = [NSMutableArray array];
    NSUInteger count = _trackData.count;
    UIColor *prevColor;
    for (NSUInteger i = 0; i < count; i++) {
        
        UIColor *toColor = [UIColor clearColor];
        
        if (prevColor == nil) {
            prevColor = toColor;
        }
        
        GMSStrokeStyle *style = [GMSStrokeStyle gradientFromColor:prevColor toColor:toColor];
        [colorSpans addObject:[GMSStyleSpan spanWithStyle:style]];
        
        prevColor = toColor;
    }
    return colorSpans;
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    NSLog(@"order_id:%@",marker.title);
    TakeOrderDetailViewController *detail = [[TakeOrderDetailViewController alloc] init];
    detail.order_id = marker.title;
    detail.onwork = _baseModel.onwork;
    [self.navigationController pushViewController:detail animated:YES];
        
    return YES;
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
