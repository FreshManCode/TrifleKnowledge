//
//  BottomAppearAnimationView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/9/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BottomAppearAnimationView.h"

@implementation BottomAppearAnimationView
-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubviewsWithFrame:frame];
    }
    return self;
}

- (void)setUpSubviewsWithFrame:(CGRect)frame {
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-60, 10, 50, 30)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeCurrentView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UILabel *centerLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREENWIDTH-150)/2.0, (SCREENHEIGHT-40)/2.0, 150, 40)];
    [centerLab setText:@"我是简单的底部弹出动画"];
    centerLab.font = [UIFont systemFontOfSize:14.0f];
    centerLab.textColor = [UIColor redColor];
    [self addSubview:centerLab];
}

- (void)closeCurrentView:(UIButton *)sender {
    if (self.DidCloseView) {
        self.DidCloseView();
    }
}

@end
