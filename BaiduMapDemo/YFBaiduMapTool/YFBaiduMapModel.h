//
//  YFBaiduMapModel.h
//  BaiduMapDemo
//
//  Created by zyh on 15/12/20.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBaiduMapModel : NSObject
/**
 *  纬度
 */
@property (nonatomic, assign) NSString *latitude;
/**
 *  经度
 */
@property (nonatomic, assign) NSString *longitude;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *locationIcon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;


-(YFBaiduMapModel *)configMapModel:(NSDictionary *)dict;

- (instancetype)initWithConfigMapModel:(NSDictionary *)dict;
@end
