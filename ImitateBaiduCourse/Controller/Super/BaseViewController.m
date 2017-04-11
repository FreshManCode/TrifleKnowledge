//
//  BaseViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    if ([self.title length] >0) {
        self.titleLab.text = self.title;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count <1) {
        [self.leftBtn setHidden:YES];
    }
     self.navigationController.navigationBarHidden = YES;
}


- (void)initSubViews {
    [self.view addSubview:[self navView]];
    [self.navView addSubview:[self titleLab]];
    [self.navView addSubview:[self leftBtn]];
    [self.navView addSubview:[self navSeptaorLine]];
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 20 + 12, SCREENWIDTH - 100, 17)];
        _titleLab.font = Font(17.0f);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20 + 8, 40, 30)];
        UIImage  *backImage = [[PhotoManager shareManager]getBundleImageWithName:@"btn_back"];
        [_leftBtn setImage:backImage forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIView *)navSeptaorLine {
    if (!_navSeptaorLine) {
        _navSeptaorLine = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, SCREENWIDTH, 0.5)];
        _navSeptaorLine.backgroundColor = RGB(178, 178, 178);
    }
    return _navSeptaorLine;
}


- (void)backButtonEvent:(UIButton *)sender {
    if ([self.navigationController respondsToSelector:@selector(popToViewController:animated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)getNavHeight {
    return 64;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
