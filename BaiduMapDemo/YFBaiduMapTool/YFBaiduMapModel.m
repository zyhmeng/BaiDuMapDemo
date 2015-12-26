//
//  YFBaiduMapModel.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/20.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "YFBaiduMapModel.h"

@implementation YFBaiduMapModel

- (YFBaiduMapModel *)configMapModel:(NSDictionary *)dict
{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

- (instancetype)initWithConfigMapModel:(NSDictionary *)dict;
{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
@end
