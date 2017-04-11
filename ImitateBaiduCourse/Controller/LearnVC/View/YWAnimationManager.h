//
//  YWAnimationManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/10.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWAnimationManager : NSObject
+ (instancetype)sharedAnimateManager;
//Normal Anim --- 线性函数
- (CAKeyframeAnimation *)createBasicAnimation:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toVaule:(id)toValue;

//Spring Anim --- 弹性曲线
- (CAKeyframeAnimation *)createSpringAnimation:(NSString *)keyPath duration:(CFTimeInterval)duration usingSpringWithDamping:(CGFloat)damping initialSpringVelocity:(CGFloat)velocity fromValue:(id)fromValue
                                       toValue:(id)toValue;


@end
