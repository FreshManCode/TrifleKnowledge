//
//  LoopViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/31.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "LoopViewController.h"

@interface LoopViewController ()
@property (nonatomic,strong) UIImageView  *logoView;
@property (nonatomic,strong) UIImageView  *circleView;
@property (nonatomic,strong) CAShapeLayer *circleLayer;

@end

@implementation LoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, SCREENHEIGHT-80, SCREENWIDTH - 40, 20)];
    [slider addTarget:self action:@selector(changeLayer:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
//    [self.logoView addSubview:self.circleView];
//    [self.view addSubview:self.logoView];
}

- (void)viewDidLayoutSubviews {
    self.logoView.center = self.view.center;
    self.logoView.bounds = CGRectMake(0, 0, 30, 30);
    self.circleView.frame = self.logoView.bounds;
}
- (void)viewDidAppear:(BOOL)animated {
//    [self.circleView.layer addAnimation:[self getTransformAnimation] forKey:nil];
    // 由于logoView 的frame 写在 viewDidLayoutSubviews方法中,故只能在viewDidAppear中添加circleLayer,否则不显示
    [self.view addSubview:self.logoView];
    [self.logoView.layer addSublayer:self.circleLayer];
    
}

- (CABasicAnimation *)getTransformAnimation {
    //指定对transform.rotation属性做动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration          = 2.0f; //设置动画持续时间
    animation.byValue           = @(M_PI *2);//设定旋转角度,单位是弧度
    animation.fillMode          = kCAFillModeForwards; //设定动画结束后,不恢复初始状态之设置一
    animation.repeatCount       = 1000; //设定动画执行次数
    animation.removedOnCompletion = NO; //设定动画结束后,不恢复初始状态之设置二
    return animation;
}


- (UIImageView *)logoView {
    if (!_logoView) {
        _logoView = [[UIImageView alloc]init];
        _logoView.image = [UIImage imageNamed:@"zhi"];
    }
    return _logoView;
}

- (UIImageView *)circleView {
    if (!_circleView) {
        _circleView = [[UIImageView alloc]init];
        _circleView.image = [UIImage imageNamed:@"circle"];
    }
    return _circleView;
}
- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [self getShape];
    }
    return _circleLayer;
}


- (CAShapeLayer *)getShape {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.logoView.bounds]; //先写剧本
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = bezierPath.CGPath; //安排剧本
    shapeLayer.fillColor     = [UIColor clearColor].CGColor; //填充色要为透明，不然会遮挡下面的图层
    shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    shapeLayer.lineWidth     = 1.5f;
//    shapeLayer.strokeStart   = 0.0f;
    shapeLayer.strokeEnd     = 0.0f;
    shapeLayer.frame         = self.logoView.bounds;
    return shapeLayer;
}

- (void)changeLayer:(UISlider *)slider {
    self.circleLayer.strokeEnd = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
