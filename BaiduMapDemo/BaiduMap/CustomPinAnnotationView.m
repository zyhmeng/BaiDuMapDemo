//
//  CustomPintAnnotationView.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/21.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "CustomPinAnnotationView.h"
#import "CustomPointAnnotation.h"

@implementation CustomPinAnnotationView

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        // 初始化
        // 设置大头针标题是否显示
        self.canShowCallout = YES;
        
    }
    return self;
}

+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView
{
    static NSString *identifier = @"anno";
    
    // 1.从缓存池中取
    CustomPinAnnotationView *annoView = (CustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    // 2.如果缓存池中没有, 创建一个新的
    if (annoView == nil) {
        
        annoView = [[CustomPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
    }
    
    return annoView;
}

//- (void)setAnnotation:(id<MKAnnotation>)annotation
- (void)setAnnotation:(CustomPointAnnotation *)annotation
{
    [super setAnnotation:annotation];
    
    //     处理自己特有的操作
    self.image = annotation.icon;
    
}


@end
