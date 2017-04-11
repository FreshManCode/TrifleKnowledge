//
//  YWBasicAnimController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/7.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWBasicAnimController.h"

@interface YWBasicAnimController () <CAAnimationDelegate>

@end

@implementation YWBasicAnimController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
}

- (void)setUpSubviews {
    //--------旋转动画----------
    
    CGFloat offset    = 25;
    CGFloat viewWidth = (kScreen_Width - 4 * offset ) / 3.0;
    
    UIView *rotationViewX = [[UIView alloc]initWithFrame:CGRectMake(offset, 100, viewWidth, viewWidth)];
    rotationViewX.backgroundColor = [UIColor redColor];
    [self.view addSubview:rotationViewX];
    CABasicAnimation *basicAnimationX = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    basicAnimationX.beginTime = 0;
    basicAnimationX.toValue   = @(2 * M_PI);
    basicAnimationX.duration  = 1.5;
    basicAnimationX.repeatCount  = MAXFLOAT;
    [rotationViewX.layer addAnimation:basicAnimationX forKey:nil];
    
    UIView *rotationViewY = [[UIView alloc]initWithFrame:CGRectMake(offset * 2 + viewWidth, 100, viewWidth, viewWidth)];
    rotationViewY.backgroundColor = [UIColor redColor];
    [self.view addSubview:rotationViewY];
    CABasicAnimation *basicAnimationY = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    basicAnimationY.beginTime = 0;
    basicAnimationY.toValue   = @(2 * M_PI);
    basicAnimationY.duration  = 1.5;
    basicAnimationY.repeatCount = MAXFLOAT;
    [rotationViewY.layer addAnimation:basicAnimationY forKey:nil];
    
    
    UIView *rotationViewZ = [[UIView alloc]initWithFrame:CGRectMake(offset * 3 + 2 *viewWidth,100 , viewWidth, viewWidth)];
    rotationViewZ.backgroundColor = [UIColor redColor];
    [self.view addSubview:rotationViewZ];
    CABasicAnimation *basicAnimationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimationZ.beginTime = 0;
    basicAnimationZ.toValue   = @(2 * M_PI);
    basicAnimationZ.duration  = 1.5;
    basicAnimationZ.repeatCount = MAXFLOAT;
    [rotationViewZ.layer addAnimation:basicAnimationZ forKey:nil];
    
    //----------平移动画--------
    CGFloat moveY = 100 + offset  + viewWidth;
    UIView *moveView = [[UIView alloc]initWithFrame:CGRectMake(offset, moveY, viewWidth, viewWidth)];
    moveView.backgroundColor = [UIColor redColor];
    [self.view addSubview:moveView];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    添加动画给动画设置key-value 对;用来区分代理方法中不同的动画
    [moveAnimation setValue:@"moveAnimation" forKey:@"AnimationKey"];
    moveAnimation.fromValue    = [NSValue valueWithCGPoint:CGPointMake(viewWidth / 2.0 , moveY + viewWidth / 2.0 )];
    moveAnimation.toValue      = [NSValue valueWithCGPoint:CGPointMake(kScreen_Width - viewWidth / 2.0, moveY + viewWidth / 2.0 )];
    moveAnimation.duration     = 1.5;
    moveAnimation.repeatCount  = HUGE_VALF; //重复执行
    moveAnimation.autoreverses = YES;
    moveAnimation.delegate     = self;
    
//    以下两句代码 控制view 动画结束后,停留在动画结束的位置 (防止动画结束后回到初始状态)
//    moveAnimation.fillMode = kCAFillModeForwards;
//    [moveAnimation setRemovedOnCompletion:NO];
    [moveView.layer addAnimation:moveAnimation forKey:nil];
    
//    为什么动画结束后返回原状态?
/*    首先我们需要搞明白一点的是,layer动画运行的过程是怎样的?其实在给我们一个视图添加layer动画时,真正移动并不是我们的视图本身,而是presenttation layer 的一个缓存.动画开始时presentation layer 开始移动,原始layer隐藏,动画结束时,present layer从屏幕上移除,原始
    layer 显示.这就解释了为什么我们的视图在动画结束后又回到了原来的状态,因为他根本没动过.
    这个同样解释了为什么在动画移动的过程中我们不能对其进行任何操作.所以我们在完成动画之后,最好将我们的layer属性设置为我们的最终状态属性,然后将presentation layer 移除掉.
 
 
 */
    
    //---------背景色颜色变化动画--------
    
    CGFloat colorY = 100 + 2 * (offset + viewWidth);
    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(offset, colorY, viewWidth, viewWidth)];
    colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:colorView];
    
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnimation.fromValue    = (__bridge id _Nullable)([UIColor redColor].CGColor);
    colorAnimation.toValue      = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    //动画结束时是否执行逆动画
    colorAnimation.autoreverses = YES;
    colorAnimation.repeatCount  = MAXFLOAT;
    colorAnimation.duration     = 2;
    [colorView.layer addAnimation:colorAnimation forKey:nil];
    
    //---------内容变化动画-------------
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(offset + (offset + viewWidth), colorY, viewWidth, viewWidth)];
    imageView.image  = [UIImage imageNamed:@"from"];
    [self.view addSubview:imageView];
    CABasicAnimation *imageAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    imageAnimation.toValue  = (__bridge id _Nullable)([UIImage imageNamed:@"to"].CGImage);
    imageAnimation.duration = 1.5;
    imageAnimation.autoreverses = YES;
    imageAnimation.repeatCount = HUGE_VALF;
    [imageView.layer addAnimation:imageAnimation forKey:nil];
    
    //---------圆角变化动画-------
    UIView *cornerView = [[UIView alloc]initWithFrame:CGRectMake(offset + (offset + viewWidth ) * 2, colorY, viewWidth, viewWidth)];
    cornerView.backgroundColor = [UIColor redColor];
    cornerView.layer.masksToBounds = YES;
    [self.view addSubview:cornerView];
    
    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnimation.toValue   = @(viewWidth / 2.0);
    cornerAnimation.fromValue = @(2);
    cornerAnimation.duration  = 2.5;
    //是否执行逆动画 ,如果设置为YES,就在动画结束时逆向执行一遍,不能保持结束后的状态
    cornerAnimation.autoreverses = NO;
    cornerAnimation.repeatCount  = 1;
    //动画完成后不删除动画
    cornerAnimation.fillMode = kCAFillModeForwards;
    cornerAnimation.removedOnCompletion = NO;
    [cornerView.layer addAnimation:cornerAnimation forKey:nil];

    
    //--------比例缩放动画----------
    CGFloat scaleY = colorY + (offset +viewWidth);
    UIView *scaleView = [[UIView alloc]initWithFrame:CGRectMake(offset, scaleY, viewWidth, viewWidth)];
    scaleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scaleView];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0.3);
    scaleAnimation.toValue   = @(1.2);
    scaleAnimation.duration  = 2.0;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = HUGE_VALF;
    [scaleView.layer addAnimation:scaleAnimation forKey:nil];
    
    //---------比例缩放动画X---------
    UIView *scaleViewX = [[UIView alloc]initWithFrame:CGRectMake(offset * 2 + viewWidth, scaleY, viewWidth, viewWidth)];
    scaleViewX.backgroundColor = [UIColor redColor];
    [self.view addSubview:scaleViewX];
    
    CABasicAnimation *scaleAnimationX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleAnimationX.duration  = 2.0;
    scaleAnimationX.toValue   = @(1.2);
    scaleAnimationX.fromValue = @(0.15);
    scaleAnimationX.autoreverses = YES;
    scaleAnimationX.repeatCount = HUGE_VALF;
    [scaleViewX.layer addAnimation:scaleAnimationX forKey:nil];
    
    
    //--------比例缩放动画Y-------
    UIView *scaleViewY = [[UIView alloc]initWithFrame:CGRectMake(offset * 3 +viewWidth * 2, scaleY, viewWidth, viewWidth)];
    scaleViewY.backgroundColor = [UIColor redColor];
    [self.view addSubview:scaleViewY];
    CABasicAnimation *scaleAnimaionY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleAnimaionY.fromValue = @(0.2);
    scaleAnimaionY.toValue   = @(1.2);
    scaleAnimaionY.repeatCount = HUGE_VALF;
    scaleAnimaionY.duration  = 1.5;
    scaleAnimaionY.autoreverses = YES;
    [scaleViewY.layer addAnimation:scaleAnimaionY forKey:nil];
    
    
    //----指定大小缩放--------
    CGFloat boundY = scaleY + offset +viewWidth;
    UIView *boundView = [[UIView alloc]initWithFrame:CGRectMake(offset, boundY, viewWidth, viewWidth)];
    boundView.backgroundColor = [UIColor redColor];
    [self.view addSubview:boundView];
    CABasicAnimation *boundAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundAnimation.toValue   = [NSValue valueWithCGRect:CGRectMake(0, 0, viewWidth * 0.05, viewWidth * 0.05)];
    boundAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, viewWidth * 1.2, viewWidth * 1.2)];
    boundAnimation.duration  = 2;
    boundAnimation.autoreverses = YES;
    boundAnimation.repeatCount = HUGE_VALF;
    [boundView.layer addAnimation:boundAnimation forKey:nil];
    
    //------透明动画-----------
    UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(offset * 2 + viewWidth, boundY, viewWidth, viewWidth)];
    alphaView.backgroundColor = [UIColor redColor];
    [self.view addSubview:alphaView];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(1.0);
    alphaAnimation.toValue   = @(0.0);
    alphaAnimation.duration  = 1.0f;
    alphaAnimation.autoreverses = YES;
    alphaAnimation.repeatCount = HUGE_VALF;
    [alphaView.layer addAnimation:alphaAnimation forKey:nil];
}
// 多个动画的时候如何在代理方法中区分不同的动画

//动画开始时
- (void)animationDidStart:(CAAnimation *)anim {
    //局部变量的layer 找对应的animation
    if ([[anim valueForKey:@"AnimationKey"] isEqualToString:@"moveAnimation"]) {
        NSLog(@"位移动画开始了");
    }
    
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画结束了");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
