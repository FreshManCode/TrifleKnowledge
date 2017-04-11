//
//  DrawView.m
//  ImitateBaiduCourse
//
//  Created by ZhangJJ on 16/8/4.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor redColor];
    [color set];
    [[UIColor whiteColor]setFill];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    
    path.lineCapStyle  = kCGLineCapRound;//线条拐点
    path.lineJoinStyle = kCGLineCapRound;//重点处理
    
    //设置起点坐标
    [path moveToPoint:CGPointMake(100, 10)];
    //画线
    [path addLineToPoint:CGPointMake(200, 40)];
    [path addLineToPoint:CGPointMake(160, 140)];
    [path addLineToPoint:CGPointMake(40, 140)];
    [path addLineToPoint:CGPointMake(10, 40)];
    [path closePath]; //第五条线通过调用closePath方法获得
    [path stroke];    //根据坐标连线
}

@end
