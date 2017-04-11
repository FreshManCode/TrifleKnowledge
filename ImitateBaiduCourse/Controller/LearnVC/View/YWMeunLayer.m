//
//  YWMeunLayer.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/10.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWMeunLayer.h"

const CGFloat OFF = 30;

@interface YWMeunLayer ()

@end


@implementation YWMeunLayer

- (id)initWithLayer:(YWMeunLayer *)layer {
    if (self = [super initWithLayer:layer]) {
        self.xAxisPercent = layer.xAxisPercent;
        self.animateStage = layer.animateStage;
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"xAxisPercent"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    //刚运行没有触碰view的时候,stage 的默认值是0
    CGRect  real_rect = CGRectInset(self.frame , OFF, OFF);
    CGFloat offset = real_rect.size.width / 3.6;
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    CGFloat moveDistance1;
    CGFloat moveDistance2;
    CGPoint top_left;
    CGPoint top_center;
    CGPoint top_right;
    if (_animateStage == STAGE1) {
        moveDistance1 = _xAxisPercent * (real_rect.size.width / 2 - offset)/2;
        top_left   = CGPointMake(center.x - offset - moveDistance1 * 2, OFF);
        top_center = CGPointMake(center.x - moveDistance1, OFF);
        top_right  = CGPointMake(center.x + offset, OFF);
    } else if (_animateStage == STAGE2) {
        CGFloat hightFactor;
        if (_xAxisPercent >= 0.2) {
            hightFactor = 1 - _xAxisPercent;
        } else {
            hightFactor = _xAxisPercent;
        }
        moveDistance1 = (real_rect.size.width / 2 - offset) /2;
        moveDistance2 = _xAxisPercent * (real_rect.size.width / 3);
        top_left   = CGPointMake(center.x - moveDistance1 + moveDistance2, OFF);
        top_center = CGPointMake(center.x - moveDistance1 + moveDistance2, OFF);
        top_right  = CGPointMake(center.x + offset + moveDistance2, OFF);
    } else if (_animateStage == STAGE3) {
        moveDistance1 = (real_rect.size.width / 2 - offset) / 2;
        moveDistance2 = (real_rect.size.width / 3);
        CGFloat gooeyDis_1 =
        _xAxisPercent * (center.x - offset - moveDistance1 * 2 +
                         moveDistance2 - (center.x - offset));
        CGFloat gooeyDis_2 = _xAxisPercent * (center.x - moveDistance1 +
                                              moveDistance2 - (center.x));
        CGFloat gooeyDis_3 = _xAxisPercent * (center.x + offset + moveDistance2 -
                                              (center.x + offset));
        
        top_left = CGPointMake(center.x - offset - moveDistance1 * 2 +
                               moveDistance2 - gooeyDis_1,
                               OFF);
        top_center = CGPointMake(
                                 center.x - moveDistance1 + moveDistance2 - gooeyDis_2, OFF);
        top_right =
        CGPointMake(center.x + offset + moveDistance2 - gooeyDis_3, OFF);
    }
    
    //右边
    CGPoint right_top    = CGPointMake(CGRectGetMaxX(real_rect), center.y - offset);
    CGPoint right_center = CGPointMake(CGRectGetMaxX(real_rect), center.y);
    CGPoint right_bottom = CGPointMake(CGRectGetMaxX(real_rect), center.y + offset);
    
    //底部
    CGPoint bottom_left   = CGPointMake(center.x - offset, CGRectGetMaxX(real_rect));
    CGPoint bottom_center = CGPointMake(center.x, CGRectGetMaxY(real_rect));
    CGPoint bottom_right  = CGPointMake(center.x + offset, CGRectGetMaxY(real_rect));
    
    //左边
    CGPoint left_top    = CGPointMake(OFF, center.y - offset);
    CGPoint left_center = CGPointMake(OFF, center.y);
    CGPoint left_bottom = CGPointMake(OFF, center.y + offset);
    
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:top_center];
    
    [circlePath addCurveToPoint:right_center controlPoint1:top_right controlPoint2:right_top];
    [circlePath addCurveToPoint:bottom_center controlPoint1:right_bottom controlPoint2:bottom_right];
    [circlePath addCurveToPoint:left_center controlPoint1:bottom_left controlPoint2:left_bottom];
    [circlePath addCurveToPoint:top_center controlPoint1:left_top controlPoint2:top_left];
    [circlePath closePath];
    
    CGContextAddPath(ctx, circlePath.CGPath);
    CGContextSetFillColorWithColor(ctx,
                                   [UIColor colorWithRed:29.0 / 255.0 green:163.0 / 255.0 blue:1 alpha:1].CGColor);
    CGContextFillPath(ctx);
    
}




@end
