//
//  YWTransitionViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/8.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWTransitionViewController.h"

@interface YWTransitionViewController () <CAAnimationDelegate>
@property (nonatomic,strong) UILabel  *transitionLabel;
@property (nonatomic,assign) NSInteger  index;
@property (nonatomic,strong) NSArray *animateArry;

@end

@implementation YWTransitionViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _animateArry = [NSArray arrayWithObjects:@"cube", @"suckEffect", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"oglFlip", @"cameraIrisHollowOpen", @"cameraIrisHollowClose", @"spewEffect", @"genieEffect",@"unGenieEffect",@"twist",@"tubey",@"swirl",@"charminUltra", @"zoomyIn", @"zoomyOut", @"oglApplicationSuspend", nil];
    _transitionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    _transitionLabel.center = CGPointMake((kScreen_Width - 200 ) / 2.0 + 100, 100 + 150);
    _transitionLabel.backgroundColor = [UIColor redColor];
    _transitionLabel.font = Font(20);
    _transitionLabel.numberOfLines = 0;
    _transitionLabel.textColor = [UIColor blueColor];
    _transitionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_transitionLabel];
    
    UIButton *animateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    animateBtn.center = CGPointMake((kScreen_Width - 50)/2.0, kScreen_Height - 40/2.0 - 40);
    animateBtn.backgroundColor = [UIColor blueColor];
    [animateBtn setTitle:@"动画" forState:UIControlStateNormal];
    [animateBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:animateBtn];
}

- (void)btnAction {
    CATransition *transition = [CATransition animation];
    transition.delegate = self;
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = _animateArry[_index];
    transition.subtype = kCATransitionFromLeft;
    transition.repeatCount = 1;
    [transition setValue:@"transitionAnim" forKey:@"anim"];
    [_transitionLabel.layer addAnimation:transition forKey:nil];
    _transitionLabel.text = [NSString stringWithFormat:@"动画效果:%@",_animateArry[_index]];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _index = (_index < _animateArry.count - 1) ? _index + 1 : 0;
    if (flag) {
        CATransition *transition = [CATransition animation];
        transition.delegate = self;
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = _animateArry[_index];
        transition.subtype = kCATransitionFromLeft;
        transition.autoreverses = YES;
        transition.repeatCount  = 1;
        [transition setValue:@"transitionAnim" forKey:@"anim"];
        [_transitionLabel.layer addAnimation:transition forKey:nil];
        _transitionLabel.text = [NSString stringWithFormat:@"动画效果:%@",_animateArry[_index]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
