//
//  YWFireAnimController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/8.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWFireAnimController.h"
#import <QuartzCore/QuartzCore.h>

@interface YWFireAnimController ()
//发射器对象
@property (nonatomic,strong) CAEmitterLayer * fireEmitter;
@property (nonatomic,strong) UIImageView * candleV;

@end

@implementation YWFireAnimController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (CAEmitterLayer *)fireEmitter {
    if (!_fireEmitter) {
        _fireEmitter = [CAEmitterLayer layer];
    }
    return _fireEmitter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    //发射器在 xy 平面的中心位置
    self.fireEmitter.emitterPosition = self.view.center;
    //发射器的形状
    self.fireEmitter.emitterShape    = kCAEmitterLayerCircle;
    //发射器的渲染模式
    self.fireEmitter.renderMode      = kCAEmitterLayerAdditive;
    
    //发射单元 --火焰
    CAEmitterCell *fire = [CAEmitterCell emitterCell];
    //粒子的创建速率,默认为1/s
    fire.birthRate = 200;
    //粒子的存活时间
    fire.lifetime  = 0.2;
    //粒子的生存时间容差
    fire.lifetimeRange = 0.5;
    fire.color = [UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1].CGColor;
    fire.contents = (__bridge id _Nullable)([UIImage imageNamed:@"fire"].CGImage);
    fire.name = @"fire";
    //粒子的速度
    fire.velocity = 35;
    //粒子动画的速度容差
    fire.velocityRange = 10;
    //粒子在xy平面的发射角度
    fire.emissionLongitude = (CGFloat)(M_PI + M_PI_2);
    //粒子发射角度的容差
    fire.emissionRange = (CGFloat)(M_PI_2);
    //缩放速度
    fire.scaleSpeed = 0.3;
    self.fireEmitter.emitterCells = @[fire];
    [self.view.layer addSublayer:self.fireEmitter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
