//
//  YFBaiduMap.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/22.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "YFBaiduMap.h"
#import "BaiduMapViewController.h"
#import "CustomPinAnnotationView.h"
#import "CustomPointAnnotation.h"

@implementation YFBaiduMap

-(instancetype)initWithPointLatitude:(CGFloat)latitude pointLongitude:(CGFloat)longitude pointImage:(NSString *)pointImageStr calloutTitle:(NSString *)title calloutSubtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
        self.pointImage = [UIImage imageNamed:pointImageStr];
        self.calloutTitle = title;
        self.calloutSubtitle = subtitle;
    }
    return self;
}
#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        static NSString *pinAnnotation = @"pinAnnotation";
        CustomPinAnnotationView *pinAnnotationView = (CustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinAnnotation];
        if (pinAnnotationView == nil) {
            pinAnnotationView = [[CustomPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pinAnnotation];
        }
        pinAnnotationView.annotation = annotation;
        UIView *calloutView = [self.YFDelegate customCalloutViewWithView];
        BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:calloutView];
        ((CustomPinAnnotationView *)pinAnnotationView).paopaoView = nil;
        ((CustomPinAnnotationView *)pinAnnotationView).paopaoView = paopaoView;
        
        
        return pinAnnotationView;
    }
    return nil;
}
@end