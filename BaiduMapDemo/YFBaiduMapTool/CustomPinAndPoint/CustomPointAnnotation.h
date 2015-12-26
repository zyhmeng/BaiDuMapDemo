//
//  CustomPointAnnotation.h
//  BaiduMapDemo
//
//  Created by zyh on 15/12/21.
//  Copyright © 2015年 zyh. All rights reserved.
//

/**
 *   CustomPointAnnotation,实例化对象后直接调用该类的icon属性就可以设置大头针的Image，这样可以直接设置pinAnnotationView里面的image属性，比较方便。
 *
 */
#import <Foundation/Foundation.h>

@interface CustomPointAnnotation : NSObject<BMKAnnotation>
/**
 *  大头针的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/**
 *  大头针标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  大头针的子标题
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 *  图标
 */
@property (nonatomic, copy) UIImage *icon;

@end
