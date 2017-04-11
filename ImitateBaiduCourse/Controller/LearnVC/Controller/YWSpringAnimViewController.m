//
//  YWSpringAnimViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/8.
//  Copyright © 2017年 能伍网络. All rights reserved.
//  弹簧动画

#import "YWSpringAnimViewController.h"

@interface YWSpringAnimViewController ()

@end

@implementation YWSpringAnimViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(10, 200, 50, 50)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.x"];
    spring.damping = 5;
    spring.mass    = 1;
    spring.stiffness = 100;
    spring.initialVelocity = 0;
    spring.fromValue = @(testView.layer.position.x);
    spring.toValue   = @(testView.layer.position.y);
    spring.autoreverses = YES;
    spring.repeatCount = HUGE_VALF;
    spring.duration = spring.settlingDuration;
    [testView.layer addAnimation:spring forKey:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
