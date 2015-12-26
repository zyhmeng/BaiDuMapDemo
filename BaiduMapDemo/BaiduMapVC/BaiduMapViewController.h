//
//  BaiduMapViewController.h
//  BaiduMapDemo
//
//  Created by zyh on 15/12/19.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBaiduMapTool.h"
#import "ViewController.h"


@interface BaiduMapViewController : UIViewController<BMKLocationServiceDelegate,YFBaiduMapToolDelegate>

@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@end
