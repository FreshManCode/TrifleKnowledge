//
//  YWKeyframeAnimController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/8.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWKeyframeAnimController.h"

@interface YWKeyframeAnimController ()

@end

@implementation YWKeyframeAnimController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, SCREENWIDTH - 100, kScreen_Height - 150)];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:tempView.frame];
    UIView *animateView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 70, 70)];
    animateView.layer.cornerRadius  = 70 / 2.0;
    animateView.layer.masksToBounds = YES;
    animateView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animateView];
    
    CAKeyframeAnimation *orbitAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    orbitAnimate.duration = 5;
    orbitAnimate.path = bezierPath.CGPath;
    orbitAnimate.calculationMode = kCAAnimationCubicPaced;
    orbitAnimate.fillMode = kCAFillModeForwards;
    orbitAnimate.repeatCount = HUGE_VALF;
    orbitAnimate.rotationMode = kCAAnimationRotateAutoReverse;
    [animateView.layer addAnimation:orbitAnimate forKey:nil];
    
    //画出椭圆的轨道
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //轨道颜色
    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    //轨道区域的填充色
    shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth   = 0.5;
    shapeLayer.lineJoin    = kCALineJoinRound;
    shapeLayer.lineCap     = kCALineCapRound;
    shapeLayer.path        = bezierPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
