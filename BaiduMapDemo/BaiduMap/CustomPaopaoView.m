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
        [paopaoView setFrame:CGRectMake(0, 0, 185, 70)];
        paopaoView.layer.cornerRadius = 30;
        [self addSubview:paopaoView];
    }
    return self;
}

@end
