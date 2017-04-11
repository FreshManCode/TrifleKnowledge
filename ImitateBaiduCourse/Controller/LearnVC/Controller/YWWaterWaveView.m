//
//  YWWaterWaveView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/8.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWWaterWaveView.h"

@interface YWWaterWaveView ()
@property (nonatomic,strong) CADisplayLink * waveDisplaylink;
@property (nonatomic,strong) CAShapeLayer * firstWaveLayer;
@property (nonatomic,strong) CAShapeLayer * secondWaveLayer;

@end

@implementation YWWaterWaveView {
    //水纹振幅
    CGFloat _waveA ;
    //水纹周期
    CGFloat _wavew ;
    //位移
    CGFloat _offSetX;
    //当前波浪高度Y
    CGFloat _currentK;
    //水纹速度
    CGFloat _waveSpeed;
    //水纹路宽度
    CGFloat _waterWaveWidth;
    //波浪颜色
    UIColor *_firstWaveColor;
}

- (CADisplayLink *)waveDisplaylink {
    if (!_waveDisplaylink) {
        _waveDisplaylink = [[CADisplayLink alloc]init];
    }
    return _waveDisplaylink;
}

- (CAShapeLayer *)firstWaveLayer {
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];;
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondWaveLayer {
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
    }
    return _secondWaveLayer;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.masksToBounds = YES;
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    //波浪宽
    _waterWaveWidth = self.bounds.size.width;
    //波浪颜色
    _firstWaveColor = [UIColor greenColor];
    //波浪速度
    _waveSpeed = 0.4 / M_PI;
    //设置闭环的颜色
    _firstWaveLayer.fillColor = [UIColor colorWithRed:73/255.0 green:142/255.0 blue:178/255.0 alpha:0.5].CGColor;
    //设置边缘线的颜色
    _secondWaveLayer.strokeStart = 0.0;
    _secondWaveLayer.strokeEnd   = 0.8;
    [self.layer addSublayer:_firstWaveLayer];
    [self.layer addSublayer:_secondWaveLayer];
    
    //设置波浪流动速度
    _waveSpeed = 0.05;
    //设置振幅
    _waveA = 8;
    //设置周期
    _wavew = 2.0 * (M_PI) /self.bounds.size.width;
    //设置波浪纵向位置
    _currentK = self.bounds.size.height / 2; //屏幕居中
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)getCurrentWave:(CADisplayLink *)displayLink {
    //实时位移
    _offSetX += _waveSpeed;
    [self setCurrentFirstWaveLayerPath];
    
}

- (void)setCurrentFirstWaveLayerPath {
    
    
    
    
}


@end
