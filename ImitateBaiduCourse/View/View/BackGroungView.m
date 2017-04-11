
//
//  BackGroungView.m
//  ImitateBaiduCourse
//
//  Created by ZhangJJ on 16/8/4.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BackGroungView.h"
#import "CALayer+Add.h"

@implementation BackGroungView

- (void)drawRect:(CGRect)rect {
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.size = CGSizeMake(SCREENWIDTH, 4.0f);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, _progressLayer.frame.size.height/2.0)];
    [bezierPath addLineToPoint:CGPointMake(SCREENWIDTH, _progressLayer.frame.size.height/2.0)];
    [bezierPath addLineToPoint:CGPointMake(SCREENWIDTH, 75)];
    [bezierPath addLineToPoint:CGPointMake(10, 75)];
    [bezierPath closePath];
    _progressLayer.lineWidth = 4.0;
    _progressLayer.path = bezierPath.CGPath;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _progressLayer.fillColor = [UIColor whiteColor].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    _progressLayer.hidden = YES;
    [self.layer addSublayer:_progressLayer];
    
    _singleLayer = [CAShapeLayer layer];
    _singleLayer.size = CGSizeMake(SCREENHEIGHT, 2.0f);
    UIBezierPath *singlePath = [UIBezierPath bezierPath];
    [singlePath moveToPoint:CGPointMake(0, 20.0f)];
    [singlePath addLineToPoint:CGPointMake(SCREENWIDTH, 20.0)];
    _singleLayer.path = singlePath.CGPath;
    _singleLayer.lineWidth = 2.0f;
    _singleLayer.strokeColor = [UIColor colorWithRed:0.500 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _singleLayer.fillColor = [UIColor clearColor].CGColor;
    _singleLayer.strokeStart = 0;
    _singleLayer.strokeEnd = 0;
    [_singleLayer setHidden:YES];
    [self.layer addSublayer:_singleLayer];
}

@end
