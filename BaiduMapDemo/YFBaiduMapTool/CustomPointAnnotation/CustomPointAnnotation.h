//
//  CustomPointAnnotation.h
//  BaiduMapDemo
//
//  Created by zyh on 15/12/21.
//  Copyright © 2015年 zyh. All rights reserved.
//

/**
 *   记录取出数据模型时的indexPath，让大头针，气泡和气泡点击的数据一致
 *
 */
#import <Foundation/Foundation.h>

@interface CustomPointAnnotation : NSObject<BMKAnnotation>

/**
 *  大头针的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/**
 *  记录数据的索引
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
