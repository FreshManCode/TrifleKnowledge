//
//  LearnAnimationVC.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/7.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "BaseViewController.h"

@interface LearnAnimationVC : BaseViewController
/*                                    CABasicAnimation
               CAPropertyAnimation    CAKeyFrameAnimation
 CAAnimation   CATransition
               CAAnimationGroup
 
 
 */

//CABasicAnimation
// 1.动画的属性和解释
/*
 duration       : 动画的持续时间
 repeatCount    : 动画持续次数
 repeatDuration : 设置动画的时间,在该时间内动画一直执行,不计其数.
 beginTime      : 指定动画开始的时间.从刚开始延迟几秒的话,设置为:CACurrentMediaTime() + 秒数的方式.
 timingFunction : 设置动画的速度变化
 fillMode       : 动画在开始和结束时的动作,默认值是KCAFillModeRemoved
 autoreverses   : 动画结束时是否执行逆动画.
 fromValue      : 所改变属性的起始值
 toValue        : 所改变属性的结束时的值
 byValue        : 所改变属性相同起始值的该变量.
 
 2.属性值的解释
 kCAMediaTimingFuncationLinear --在整个动画时间内动画都是以一个相同的速度来改变.也就是匀速运动.一个线性的计时函数,同样也是CAAnimation
 的timingFunction属性为空的时候的默认函数.线性步调对于那些立即加速并且保持匀速到达终点的场景会有意义(例如射出枪膛的子弹)
 
 kCAMediaTimingFunctionEaseIn: 动画开始时会变慢,之后动画会加速.一个慢慢加速然后突然停止的方法.对于之前提到的自由落体的来说很合适,或者比如
 对准一个目标的导弹的发射.
 
 kCAMediaTimingFunctionEaseOut:动画在开始时会比较快,之后动画速度减慢.它以一个全速开始,然后慢慢减速停止.
 
 kCAMediaTimingFunctionEaseInEaseOut: 动画在开始和结束时速度较慢,中间时间段内速度较快.创建了一个慢慢加速然后再慢慢减速的过程.这是现实世界大多数物体移动的方式,也是大多数动画来说最好的选择.如果可以用一种缓冲函数的话,那就必须是它了.
 实际上当使用UIView的动画方法时,他的确是默认的,但当创建CAAnimation的时候,就需要手动设置它了.
 
 kCAMediaTimingFunctionDefault: 它和kCaMediaTimingFunctionEaseInEaseOut 很类似,但是加速和减速的过程都稍微有些慢.它和
 kCAMediaTimingFunctionEaseInEaseOut的区别很难察觉.可能是苹果觉得它对于隐式动画来说更合适(然后对UIKit就改变了想法,而是使用
 kCAMediaTimingFunctionEaseInEaseOut作为默认效果),虽然它的名字说是默认的,但还是要记住当创建显式的CAAnimation他并不是默认选项(换句话说,默认的图层行为动画用
 KCAMediaTimingFunctionDefault作为他们的计时方法)
 
 
 
 
 fillMode

 kCAFillModeForwards:动画开始之后layer的状态将保持在动画的最后一帧,而removedOnCompletion的默认属性值是YES,所以为了使动画结束
 之后layer保持结束状态,应该removedOnCompletion 设置为NO
 
 kCAFillModeBackwards:将会立即执行动画的第一帧,不论是否设置了beginTime属性.观察发现,设置该值,刚开始视图不见,还不知道应用在哪里.
 
 kCAFillModeBoth :该值是kCAFillModeForwars 和 kCAFillModeBackwards的组合状态
 
 kCAFillModeRemoved :动画将在设置的beginTime 开始执行(如没有设置beginTime属性,则动画立即执行),动画执行完成后将会layer的改
 变恢复原装
 
 
 3.使用心得
 尽量不要设置removedOnCompletion = false,因为配合CAAnimationDelegate 会带来循环引用的问题,如果需要动画停留在最后的状态,
 可以直接设置View的center属性在动画结束的位置Point.
 之所以会出现循环引用,因为由于CAAnimation的delegate使用的strong类型:
 
 
 4.常用KeyPath 总结
 transform.scale      比例缩放
 transform.scale.x    缩放宽的比例
 transform.scale.y    缩放高的比例
 transform.rotation.x 围绕着x轴旋转
 transform.rotation.y 围绕着y轴旋转
 transform.rotation.z 围绕着z轴旋转
 backgroudColor       背景颜色的变化
 bounds               大小缩放,中心不变
 position             位置(中心点的改变)
 contents             UIImageView的图片 
 opacity              透明度
 contentsRect.size.width  横向拉伸缩放
 contentsRect.size.height 纵向拉伸缩放
 
 
 
 三 . CAKeyframeAnimation 
 CAKeyframeAnimation 是核心动画里面的帧动画,它提供了按照指定的一串值进行动画,好像拍电影一样的一帧一帧的效果.
 1.属性解释
 values: 是许多值组成的数组用来进行动画的.这个属性比较特别,只有在path属性值为nil的时候才有作用.
 path:路径,可以指定一个路径,让动画沿着这个指定的路径执行
 cacluationMode:在关键帧动画中还有一个非常重要的参数,那便是calculationMode,计算模式.其主要针对的是每一帧的内容为一个坐标点的情况,也就是对anchorPoint 和 position 进行的动画.当在平面坐标系中有多个离散的点的时候,可以是离散的,也可以直线相连后进行插值计算,也可以使用
 圆滑的曲线将他们相连后进行插值计算.
 1)kCAAnimationLinear calculationMode 的默认值,r 自定义控制动画的时间(线性)可以设置keyTimes,表示当天关键帧坐标点的时候,关
 键帧动之间直接直线相连进行插值计算;
 2)kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
 3)kCAAnimationPaced 节奏动画自动计算动画的运动时间,使得动画均匀进行,而不是按keyTimes设置的或者按关键帧分时间,此时keyTimes 和timingFunctions无效.
 4)kCAAnimationCubic 对关键帧为坐标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues
 来进行调整自定义,这里的主要目的是是的运行的轨迹变的圆滑,曲线动画需要设置timingFunctions
 kCAAnimationsCubicPaced 看这个名字就知道和kCAAnimaionCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统
 时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的.
 
 
 
 
 
 
 
 
 
 
 
 
 
 */


@end
