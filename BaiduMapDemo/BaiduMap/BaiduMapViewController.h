//
//  BaiduMapViewController.h
//  BaiduMapDemo
//
//  Created by zyh on 15/12/19.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBaiduMap.h"
#import "ViewController.h"


@interface BaiduMapViewController : UIViewController<BMKLocationServiceDelegate,YFBaiduMapDelegate>

@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@end
