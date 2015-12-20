//
//  BaiduMapViewController.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/19.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "BaiduMapViewController.h"
#import "CustomAnnotionView.h"


@interface BaiduMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (strong, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *paopaoView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@end

@implementation BaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"百度地图";
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.zoomLevel = 12;//地图级别
    
    CLLocationCoordinate2D coor = _locService.userLocation.location.coordinate;
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.2, 0.2));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
    //当前位置显示在可视范围内
    BMKCoordinateRegion region;
    region.center.latitude = 34.782879;
    region.center.longitude = 113.726475;
    region.span.latitudeDelta = 0.08;
    region.span.longitudeDelta = 0.08;
    _mapView.region = region;
    
        
    

    
    
}
#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];

        if (newAnnotationView == nil) {
            newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        }
        UIView *paopaoLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 41)];
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"man"]];
        image.center = paopaoLeftView.center;
        [paopaoLeftView addSubview:image];
        newAnnotationView.leftCalloutAccessoryView = paopaoLeftView;
        UIButton *paopaoRightView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 41)];
        
        [paopaoRightView setImage:[UIImage imageNamed:@"bnavi"] forState:UIControlStateNormal];
        
        newAnnotationView.rightCalloutAccessoryView = paopaoRightView; 
        
        return newAnnotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    //设置标注点
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 34.702;
    coordinate.longitude = 113.726;
    pointAnnotation.coordinate = coordinate;
    pointAnnotation.title = @"云峰";
    pointAnnotation.subtitle = @"峰会天下";
    

    [_mapView addAnnotation:pointAnnotation];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _userLocation = userLocation;
    [_mapView updateLocationData:userLocation];
}
- (IBAction)myLocation:(id)sender {
    //当前位置显示在可视范围内
    BMKCoordinateRegion region;
    region.center.latitude = _userLocation.location.coordinate.latitude;
    region.center.longitude = _userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    _mapView.region = region;

}
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    
}

@end
