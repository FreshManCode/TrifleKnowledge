//
//  BigAppearView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BigAppearView.h"

@implementation BigAppearView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title cancelTitle:(NSString *)cancel sureTitle:(NSString *)sure {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.4;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [self.layer addAnimation:animation forKey:nil];
        
        
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 40, 30)];
        [leftButton setTitle:@"X" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.f];
        [leftButton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, SCREENWIDTH - 40, 20)];
        titlelab.text = title;
        titlelab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titlelab];
        
        
        UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - 200) /2.0, titlelab.bottom + 40, 200, 30)];
        [shareButton setTitle:sure forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(shareButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareButton];
        
        
    }
    return self;
}

- (void)closeView:(UIButton *)sender {
    UIView *view = sender.superview;
    if (self.CancelEvent) {
        self.CancelEvent(view);
    }
}

- (void)shareButtonEvent:(UIButton *)sender {
    UIView *view = sender.superview;
    if (self.SureEvent) {
        self.SureEvent (view);
    }
}

@end
