//
//  BaiduMapViewController.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/19.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "BaiduMapViewController.h"
#import "CustomPointAnnotation.h"
#import "PaopaoViewClicked.h"
#import "CustomPinAnnotationView.h"
#import "CustomPaopaoView.h"
#import "ViewController.h"

@interface BaiduMapViewController ()



@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, copy) NSString *paopaoViewTitle;
@property (nonatomic, copy) NSString *paopaoViewSubtitle;
@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@property (nonatomic, copy) UIImage *pinImage;
@property (nonatomic, strong)YFBaiduMap *baiduMap;
@end

@implementation BaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"百度地图";
    
    //设置地图定位的一些配置
    [self setupBaiduMapPositionConfig];
    
    //设置地图当前显示位置和范围
    [self setupCurrentCoordinateRegin];
    
}


#pragma mark - 设置地图定位的一些配置
- (void)setupBaiduMapPositionConfig
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.zoomLevel = 12;//地图级别

}
#pragma mark - 设置地图当前显示位置和范围
- (void)setupCurrentCoordinateRegin
{
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
        static NSString *myAnnotation = @"myAnnotation";
        
        BMKPinAnnotationView *newAnnotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:myAnnotation];
        if (newAnnotationView == nil) {
            newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:myAnnotation];
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
    }else if ([annotation isKindOfClass:[CustomPointAnnotation class]])
    {
        
        CustomPinAnnotationView *customPintView = [CustomPinAnnotationView annotationViewWithMap:mapView];
        customPintView.annotation = annotation;
        
        CustomPaopaoView *customPaopaoView = [[CustomPaopaoView alloc]initWithFrame:CGRectMake(0, 0, 185, 70)];
        BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:customPaopaoView];
        ((CustomPinAnnotationView *)customPintView).paopaoView = nil;
        ((CustomPinAnnotationView *)customPintView).paopaoView = paopaoView;
        return customPintView;
    }
    
    return nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    //设置标注点
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 34.602;
    coordinate.longitude = 113.725;
    pointAnnotation.coordinate = coordinate;
    pointAnnotation.title = @"云峰";
    pointAnnotation.subtitle = @"绿地峰会天下";
    [_mapView addAnnotation:pointAnnotation];
    
    CustomPointAnnotation *customPoint = [[CustomPointAnnotation alloc]init];
    CLLocationCoordinate2D coordinate2;
    coordinate2.latitude = 34.702;
    coordinate2.longitude = 113.726;
    customPoint.coordinate = coordinate2;
    customPoint.icon = [UIImage imageNamed:@"start"];
    [_mapView addAnnotation:customPoint];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    //设置代理
    self.baiduMap = [[YFBaiduMap alloc]init];
    self.baiduMap.YFDelegate = self;
    self.mapView.delegate = self.baiduMap;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark - 百度地图位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _userLocation = userLocation;
    [_mapView updateLocationData:userLocation];
}
#pragma mark - 我的位置点击事件
- (IBAction)myLocation:(id)sender {
    //当前位置显示在可视范围内
    BMKCoordinateRegion region;
    region.center.latitude = _userLocation.location.coordinate.latitude;
    region.center.longitude = _userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    _mapView.region = region;
        
}

#pragma mark - 点击paopaoView响应事件
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    PaopaoViewClicked *paopaoVC = [[PaopaoViewClicked alloc]init];
    paopaoVC.locationLatitude = self.userLocation.location.coordinate.latitude;
    paopaoVC.locationLongitude = self.userLocation.location.coordinate.longitude;
    paopaoVC.locationIcon = [UIImage imageNamed:@"man"];
    paopaoVC.locationTitle = @"云峰";
    paopaoVC.locationSubtitle = @"绿地峰会天下";
    [self.navigationController pushViewController:paopaoVC animated:YES];
    
}

#pragma mark - YFBaiduMapDelegate
- (UIView *)customCalloutViewWithView
{
    CustomPaopaoView *paopaoView = [[CustomPaopaoView alloc]initWithFrame:CGRectMake(0, 0, 185, 70)];
    return paopaoView;
}


@end
