//
//  YFBaiduMapTool.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/22.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "YFBaiduMapTool.h"
#import "BaiduMapViewController.h"
#import "CustomPinAnnotationView.h"
#import "CustomPointAnnotation.h"

@implementation YFBaiduMapTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yfBaiduMapViewShowDataList = [[NSMutableArray alloc]init];
    }
    return self;
}
#pragma mark - BMKMapViewDelegate
//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        static NSString *pinAnnotation = @"pinAnnotation";
        CustomPinAnnotationView *pinAnnotationView = (CustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinAnnotation];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[CustomPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pinAnnotation];
        }
        pinAnnotationView.annotation = annotation;
        id object;
        UIView *calloutView = [self.yfBaiduMapToolDelegate yfBaiDuMapCustomCalloutViewWith:object];
        BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:calloutView];
        ((CustomPinAnnotationView *)pinAnnotationView).paopaoView = nil;
        ((CustomPinAnnotationView *)pinAnnotationView).paopaoView = paopaoView;
        
        return pinAnnotationView;
    }
    return nil;
}

//当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
//    id object = [self.yfBaiduMapShowDataList objectAtIndex:];
    id object;
    [self.yfBaiduMapToolDelegate yfBaiduMapSelectedCalloutView:object];
}
//显示大头针位置和图片时调用这个接口
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    self.yfBaiduMapViewShowDataList = [self.yfBaiduMapToolDelegate yfBaiduMapShowPinAnnotationWith:nil];
    for (NSDictionary *dict in self.yfBaiduMapViewShowDataList) {
        self.baiduMapModel = [[YFBaiduMapModel alloc]initWithConfigMapModel:dict];
        CustomPointAnnotation *customPoint = [[CustomPointAnnotation alloc]init];
        CLLocationCoordinate2D coordinate2;
        coordinate2.latitude = [self.baiduMapModel.latitude floatValue];
        coordinate2.longitude = [self.baiduMapModel.longitude floatValue];
        customPoint.coordinate = coordinate2;
        customPoint.icon = [UIImage imageNamed:self.baiduMapModel.icon];
        [mapView addAnnotation:customPoint];
    }
}
@end