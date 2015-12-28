//
//  CustomPaopaoView.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/22.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "CustomPaopaoView.h"

@implementation CustomPaopaoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *paopaoView = [[NSBundle mainBundle]loadNibNamed:@"CustomPaopaoView" owner:self options:nil][0];
        paopaoView.layer.cornerRadius = 30;
        [self setFrame:frame];
        self.subtitle = [[UILabel alloc]initWithFrame:CGRectMake(55, 44, 130, 21)];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(55, 8, 130, 21)];
        [paopaoView addSubview:self.title];
        [paopaoView addSubview:self.subtitle];
        [self addSubview:paopaoView];
    }
    return self;
}

@end
