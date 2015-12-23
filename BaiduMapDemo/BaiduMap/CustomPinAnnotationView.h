//
//  CustomPinAnnotationView.h
//  BaiduMapDemo
//
//  Created by zyh on 15/12/21.
//  Copyright © 2015年 zyh. All rights reserved.
//



@interface CustomPinAnnotationView : BMKPinAnnotationView
/**
 *  快速创建方法
 *
 *  @param mapView 地图
 *
 *  @return 大头针
 */
+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView;

@end
