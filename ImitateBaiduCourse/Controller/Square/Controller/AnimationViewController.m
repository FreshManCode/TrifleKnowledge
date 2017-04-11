
//
//  AnimationViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/9/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "AnimationViewController.h"
#import "BottomAppearAnimationView.h"



@interface AnimationViewController ()
@property (nonatomic,strong) BottomAppearAnimationView *animationView;

@end


@implementation AnimationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}
- (void)setUpSubViews {
    __weak typeof (self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开始吧" style:UIBarButtonItemStylePlain target:self action:@selector(appearBottomAnimationView)];
    switch (self.type) {
        case 0: {
            self.title = @"底部弹出动画";
            _animationView = [[BottomAppearAnimationView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT)];
            [[self getRootWindow]addSubview:_animationView];
            _animationView.hidden = YES;
            _animationView.DidCloseView = ^ () {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.65];
                [weakSelf.animationView setY:SCREENHEIGHT];
                [UIView commitAnimations];
                weakSelf.animationView.hidden = YES;
            };
        }
            break;
            
        default:
            break;
    }
}

- (UIWindow *)getRootWindow {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    return window;
}

- (void)appearBottomAnimationView {
    switch (self.type) {
        case 0 : {
            _animationView.hidden = NO;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.35f];
            [_animationView setY:65];
            [UIView commitAnimations];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] ==NSNotFound) {
        [_animationView removeFromSuperview];
        _animationView = nil;
    }
}

- (void)dealloc {
    [_animationView removeFromSuperview];
    _animationView = nil;
}


@end
