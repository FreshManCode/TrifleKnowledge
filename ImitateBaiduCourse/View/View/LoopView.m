//
//  LoopView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "LoopView.h"
#import "CALayer+Add.h"

@implementation LoopView
- (void)drawRect:(CGRect)rect {
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.size = CGSizeMake(60, 60);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 20, 60, 60) cornerRadius:30];
    [bezierPath moveToPoint:CGPointMake(10, 20)];
    [bezierPath closePath];
    bezierPath.lineWidth = 3.0f;
    _shapeLayer.path = bezierPath.CGPath;
    _shapeLayer.lineWidth = bezierPath.lineWidth;
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    _shapeLayer.hidden = YES;
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_shapeLayer];
    
//    UIColor *strokeColor = [UIColor blueColor];
//    [strokeColor set];
//    [bezierPath stroke];
    
}

@end
