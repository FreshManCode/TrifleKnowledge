//
//  YWMeunView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/10.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWMeunView.h"
#import "YWAnimationManager.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface YWMeunView () <CAAnimationDelegate>
#else
@interface YWMeunView ()
#endif

@property (nonatomic,strong) NSMutableArray *animationQueue;

@end

@implementation YWMeunView

- (id)initWithFrame:(CGRect)frame {
    CGRect real_frame = CGRectInset(frame, -30, -30);
    if (self = [super initWithFrame:real_frame]) {
        _animationQueue = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    _menuLayer = [YWMeunLayer layer];
    _menuLayer.frame = self.bounds;
    _menuLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_menuLayer];
    [_menuLayer setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    switch (touch.tapCount) {
        case 1:
            [self openAnimation];
            break;
            
        default:
            break;
    }
}

- (void)openAnimation {
    CAKeyframeAnimation *openAnimation1 = [[YWAnimationManager sharedAnimateManager]
                                           createBasicAnimation:@"xAxisPercent"
                                           duration:0.3
                                           fromValue:@(0)
                                           toVaule:@(1)];
    openAnimation1.delegate = (id) self;
    
    CAKeyframeAnimation *openAnimation2 = [[YWAnimationManager sharedAnimateManager]
                                           createBasicAnimation:@"xAxisPercent"
                                           duration:0.3
                                           fromValue:@(0)
                                           toVaule:@(1)];
    openAnimation2.delegate = (id) self;
    
    CAKeyframeAnimation *openAnimation3 = [[YWAnimationManager sharedAnimateManager]
                                           createSpringAnimation:@"xAxisPercent"
                                           duration:1.0
                                           usingSpringWithDamping:0.5
                                           initialSpringVelocity:3.0
                                           fromValue:@(0)
                                           toValue:@(1)];
    openAnimation3.delegate = (id) self;
    [_animationQueue addObject:openAnimation1];
    [_animationQueue addObject:openAnimation2];
    [_animationQueue addObject:openAnimation3];
    //执行动画1
    [self.menuLayer addAnimation:openAnimation1 forKey:@"openAnimation1"];
    //动画期间不允许用户进行点击
    self.userInteractionEnabled = NO;
    _menuLayer.animateStage = STAGE1;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if ([anim isEqual:[self.menuLayer animationForKey:@"openAnimation1"]]) {
            [self.menuLayer removeAllAnimations];
            [self.menuLayer addAnimation:[_animationQueue objectAtIndex:1] forKey:@"openAnimation2"];
            self.menuLayer.animateStage = STAGE2;
        }else if ([anim isEqual:[self.menuLayer animationForKey:@"openAnimation2"]]) {
            [self.menuLayer removeAllAnimations];
            [self.menuLayer addAnimation:[_animationQueue objectAtIndex:2] forKey:@"openAnimation3"];
            self.menuLayer.animateStage = STAGE3;
        }else if ([anim isEqual:[self.menuLayer animationForKey:@"openAnimation3"]]) {
            self.menuLayer.xAxisPercent = 1.0f;
            [self.menuLayer removeAllAnimations];
            self.userInteractionEnabled = YES;
        }
    }
}


@end
