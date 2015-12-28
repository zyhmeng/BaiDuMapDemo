//
//  YFBaiduMapTool.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/22.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "YFBaiduMapTool.h"
#import "BaiduMapViewController.h"
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
#pragma mark 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    static NSString *pinAnnotation = @"pinAnnotation";
    BMKPinAnnotationView *pinAnnotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinAnnotation];
    if (pinAnnotationView == nil) {
        pinAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pinAnnotation];
    }
    CustomPointAnnotation *pointAnnotation = (CustomPointAnnotation *)annotation;
        
    UIView *calloutView = [self.yfBaiduMapToolDelegate yfBaiDuMapCustomCalloutViewWith:[self.yfBaiduMapViewShowDataList objectAtIndex:pointAnnotation.indexPath.row] andAnnotationView:pinAnnotationView];
    NSInteger row = pointAnnotation.indexPath.row;
    self.index = [NSIndexPath indexPathForRow:row inSection:0];

    BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:calloutView];
    ((BMKPinAnnotationView *)pinAnnotationView).paopaoView = nil;
    ((BMKPinAnnotationView *)pinAnnotationView).paopaoView = paopaoView;
    
    return pinAnnotationView;
    
}

#pragma mark 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    
    [self.yfBaiduMapToolDelegate yfBaiduMapSelectedCalloutView:[self.yfBaiduMapViewShowDataList objectAtIndex:self.index.row]];
    
}

#pragma mark 地图初始化完毕时会调用此接口,在这里我们显示大头针的位置
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    if (self.yfBaiduMapViewShowDataList != 0&&self.yfBaiduMapViewShowDataList.count>0) {
        
        for (int i = 0; i < self.yfBaiduMapViewShowDataList.count; i++) {
            
            CLLocationCoordinate2D coordinate = [self.yfBaiduMapToolDelegate yfBaiduMapShowPointWith:[self.yfBaiduMapViewShowDataList objectAtIndex:i]];
            
            CustomPointAnnotation *customPoint = [[CustomPointAnnotation alloc]init];
            ;
            customPoint.coordinate = coordinate;
            customPoint.indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            [mapView addAnnotation:customPoint];
        }
        
    }
}
@end