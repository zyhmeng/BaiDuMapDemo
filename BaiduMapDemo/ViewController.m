//
//  ViewController.m
//  BaiduMapDemo
//
//  Created by zyh on 15/12/19.
//  Copyright © 2015年 zyh. All rights reserved.
//

#import "ViewController.h"
#import "BaiduMapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)BaiduMap:(id)sender {
    BaiduMapViewController *mapViewVC = [[BaiduMapViewController alloc]init];
    [self.navigationController pushViewController:mapViewVC animated:YES];
    
    
}


@end
