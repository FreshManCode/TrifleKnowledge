//
//  YWDrawLineController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/8.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWDrawLineController.h"

@interface YWDrawLineController ()

@end

@implementation YWDrawLineController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, kScreen_Width - 100, kScreen_Height - 150)];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:tempView.frame];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth   = 2;
    shapeLayer.lineJoin    = kCALineJoinRound;
    shapeLayer.path        = bezierPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration  = 5.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = @(0);
    pathAnimation.toValue   = @(1);
    pathAnimation.autoreverses = YES;
    pathAnimation.fillMode  = kCAFillModeForwards;
    pathAnimation.repeatCount = HUGE_VAL;
    [shapeLayer addAnimation:pathAnimation forKey:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
