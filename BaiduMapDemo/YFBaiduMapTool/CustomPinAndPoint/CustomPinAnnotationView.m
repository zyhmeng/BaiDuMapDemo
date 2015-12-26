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



//- (void)setAnnotation:(id<MKAnnotation>)annotation
- (void)setAnnotation:(CustomPointAnnotation *)annotation
{
    [super setAnnotation:annotation];
    
    //     处理自己特有的操作
    self.image = annotation.icon;
    
}


@end
