//
//  CustomRefreshHeader.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/31.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "CustomRefreshHeader.h"

#pragma mark - Const
CGRect kZZZLogoViewBounds = {0,0,25,25};

@interface CustomRefreshHeader ()
@property (nonatomic,strong) UIImageView  *logoView;
@property (nonatomic,strong) UIImageView  *circleView;
@property (nonatomic,strong) CAShapeLayer *circleLayer;
@property (nonatomic,assign) BOOL hasRefresh;
@end

@implementation CustomRefreshHeader
#pragma mark----- 在这里做一些初始化配置(比如添加子控件)

/**
 *  说明:该方法,不能放布局相关的内容,因为在调用prepare是在视图初始化的时候,这个时候MJRefresh还没加入到View Hierarchy
 */
- (void)prepare {
    [super prepare];
    [self.logoView addSubview:self.circleView];
    [self.logoView.layer addSublayer:self.circleLayer];
    self.hasRefresh = NO; //初始化的时候,肯定是没有刷新过的
    [self addSubview:self.logoView];
}


#pragma mark -----在这里设置子控件的尺寸和位置
/**
 *  该方法中:MJRefreshView的 Frame.origin = (0,_self.mj_h),所以调整Y值的时候注意正负
 */
- (void)placeSubviews {
    [super placeSubviews ];
    self.logoView.center  = CGPointMake(self.mj_w / 2.0, self.mj_h / 2.0 +10);
    // +10 是为了logoView在中心点往下一点的位置,方便观看
    self.logoView.bounds  = kZZZLogoViewBounds;
    self.circleView.frame = self.logoView.bounds;
}

#pragma mark----- setter & getter
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
        _circleView.hidden = YES; //刷新时候的图片,开始的时候不需要显示出来
    }
    return _circleView;
}

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [self getShapeWithBounds:kZZZLogoViewBounds];
    }
    return _circleLayer;
}

- (CAShapeLayer *)getShapeWithBounds:(CGRect)bounds {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:bounds]; //先写剧本
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = bezierPath.CGPath; //安排剧本
    shapeLayer.fillColor     = [UIColor clearColor].CGColor; //填充色要为透明，不然会遮挡下面的图层
    shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    shapeLayer.lineWidth     = 1.5f;
    shapeLayer.strokeEnd     = 0.0f;
    shapeLayer.frame         = bounds;
    return shapeLayer;
}

// 设置动态响应
/*
 我们只需要做两种事情:
 (1) 将下拉位移量与我们的strokeEnd属性关联
 关联这件事情,MJRefresh已经帮我们处理来了前半部分,我们只需要在相应的方法里写个等式就可以了
 (2)处理状态
 .Idle :我们要设置各个组件是否隐藏 (将circleLayer按照下拉的程度画圆,不添加转圈的 )
 .Pulling :不要处理
 .Refreshing :把CircleLayer隐藏,把CircleLayer 显示并做旋转动画
 注意:我们需要在endRefreshing方法中,手动移除动画(因为我们在动画定义的部分为了动画的流畅性,设置了animaion.removedOnCompletion = NO),不然CircleView上的动画会一直运行.
 
 */


#pragma mark -----监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState ;
    switch (state) {
        case MJRefreshStateIdle:
            self.circleView.hidden  = YES;
            self.circleLayer.hidden = NO;
            break;
        case MJRefreshStatePulling:
            break;
        case MJRefreshStateRefreshing: {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            self.circleLayer.hidden = YES;
            [CATransaction begin];
            [CATransaction commit];
            
            self.circleView.hidden  = NO;
            [self.circleView.layer addAnimation:[self getTransformAnimation] forKey:nil];
            self.hasRefresh = YES; //刷新过了
        }
            break;
        default:
            break;
    }
    
}

- (CABasicAnimation *)getTransformAnimation {
    //指定对transform.rotation属性做动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration          = 2.0f; //设置动画持续时间
    animation.byValue           = @(M_PI *2);//设定旋转角度,单位是弧度 (顺时针旋转)
    animation.fillMode          = kCAFillModeForwards; //设定动画结束后,不恢复初始状态之设置一
    animation.repeatCount       = 1000; //设定动画执行次数
    animation.removedOnCompletion = NO; //设定动画结束后,不恢复初始状态之设置二
    return animation;
}


- (CABasicAnimation *)getUnclockwiseTransformAnimation {
    //指定对transform.rotation属性做动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration          = 2.0f; //设置动画持续时间
    animation.byValue           = @(M_PI * -2);//设定旋转角度,单位是弧度 (逆时针旋转)
    animation.fillMode          = kCAFillModeForwards; //设定动画结束后,不恢复初始状态之设置一
    animation.repeatCount       = 1000; //设定动画执行次数
    animation.removedOnCompletion = NO; //设定动画结束后,不恢复初始状态之设置二
    return animation;

}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    if (self.hasRefresh) { //刷新返回的时候,strokeEnd = 1.0f;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeEnd = 1.0f;
        [CATransaction commit];
        self.hasRefresh = NO; //重置状态为未刷新
    } else {
         self.circleLayer.strokeEnd = pullingPercent ;
    }
   
}

- (void)endRefreshing {
    [self.circleView.layer removeAllAnimations];
    [super endRefreshing];
}

@end
