//
//  BaiduMapViewController.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/19.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "BaiduMapViewController.h"
#import "CustomPointAnnotation.h"
#import "PaopaoViewDetail.h"
#import "YFBaiduMapModel.h"
#import "CustomPaopaoView.h"


@interface BaiduMapViewController ()



@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKUserLocation *userLocation;

@property (nonatomic, strong)YFBaiduMapTool *yfBaiduMapTool;

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



#pragma mark - 设置相关代理
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    
    //设置代理
    self.yfBaiduMapTool= [[YFBaiduMapTool alloc]init];
    self.yfBaiduMapTool.yfBaiduMapToolDelegate = self;
    self.mapView.delegate = self.yfBaiduMapTool;
    NSDictionary *dict = @{@"latitude":@"34.782879",@"longitude":@"113.726475",@"icon":@"start",@"locationIcon":@"man",@"title":@"云峰",@"subtitle":@"绿地峰会天下"};
    
    NSDictionary *dict1 = @{@"latitude":@"34.780000",@"longitude":@"113.706400",@"icon":@"man",@"locationIcon":@"man",@"title":@"地图位置",@"subtitle":@"显示位置"};
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    [mutableArray addObject:dict];
    [mutableArray addObject:dict1];
    
    
    for (NSDictionary *dict in mutableArray) {
        YFBaiduMapModel *mapModel = [[YFBaiduMapModel alloc]init];
        [mapModel setValuesForKeysWithDictionary:dict];
        [self.yfBaiduMapTool.yfBaiduMapViewShowDataList addObject:mapModel];
    }

    
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


#pragma mark - YFBaiduMapToolDelegate
#pragma mark 创建CustomCalloutView并返回
- (UIView *)yfBaiDuMapCustomCalloutViewWith:(id)object andAnnotationView:(BMKAnnotationView *)annotationView
{
    YFBaiduMapModel *mapModel = object;
    
    CustomPaopaoView *paopaoView = [[CustomPaopaoView alloc]initWithFrame:CGRectMake(0, 0, 185, 70)];
    paopaoView.title.text = mapModel.title;
    paopaoView.subtitle.text = mapModel.subtitle;
    annotationView.image = [UIImage imageNamed:mapModel.icon];
    return paopaoView;
    
}

#pragma mark  这里设置大头针的位置
- (CLLocationCoordinate2D)yfBaiduMapShowPointWith:(id)object
{
    YFBaiduMapModel *mapModel = object;
        
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([mapModel.latitude doubleValue], [mapModel.longitude doubleValue]);
    return coordinate;
}
#pragma mark  点击paopaoView响应事件
- (void)yfBaiduMapSelectedCalloutView:(id)object
{
    YFBaiduMapModel *mapModel = object;
    PaopaoViewDetail *paopaoVC = [[PaopaoViewDetail alloc]init];
    
    paopaoVC.locationTitle = mapModel.title;
    paopaoVC.locationSubtitle = mapModel.subtitle;
    paopaoVC.locationLatitude = self.userLocation.location.coordinate.latitude;
    paopaoVC.locationLongitude = self.userLocation.location.coordinate.longitude;
    
    [self.navigationController pushViewController:paopaoVC animated:YES];
}

@end
