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
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)BaiduMap:(id)sender {
    BaiduMapViewController *mapViewVC = [[BaiduMapViewController alloc]init];
    
    [self.navigationController pushViewController:mapViewVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
