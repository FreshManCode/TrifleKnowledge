//
//  YWAnimationManager.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/10.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWAnimationManager.h"

@implementation YWAnimationManager
+ (instancetype)sharedAnimateManager {
    static YWAnimationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YWAnimationManager alloc]init];
    });
    return manager;
}

- (CAKeyframeAnimation *)createBasicAnimation:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toVaule:(id)toValue {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    animation.values   = [self basicAnimationValue:fromValue toValue:toValue duration:duration];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (CAKeyframeAnimation *)createSpringAnimation:(NSString *)keyPath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue
                                       toValue:(id)toValue{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    CGFloat dampingFactor  = 10.0;
    CGFloat velocityFactor = 10.0;
    NSMutableArray *values = [self springAnimationValues:fromValue toValue:toValue usingSpringWithDamping:damping * dampingFactor initialSpringVelocity:velocity * velocityFactor duration:duration];
    animation.values   = values;
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

- (NSMutableArray *)basicAnimationValue:(id)fromValue toValue:(id)toValue duration:(CFTimeInterval)duration {
    NSInteger numOfFrames = 60 * duration;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i =0 ; i <numOfFrames; i ++) {
        [values addObject:@(0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame < numOfFrames; frame ++) {
        CGFloat x = (CGFloat)frame/(CGFloat)numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * x;
        values[frame] = @(value);
    }
    
    return values;
}

- (NSMutableArray *)springAnimationValues:(id)fromValue toValue:(id)toValue usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity duration:(CGFloat)duration {
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (int i =0; i< numOfFrames; i++) {
        [values addObject:@(0)];
    }
    
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger  frame = 0; frame < numOfFrames; frame ++) {
        CGFloat x = (CGFloat)frame /(CGFloat)numOfFrames;
        CGFloat value = [toValue floatValue] - diff * (pow(M_E, -damping * x) * cos(velocity *x));
        //y = 1 -e^{-5x} * cos(30x)
        values[frame] = @(value);
    }
    
    return values;
    
}

@end
