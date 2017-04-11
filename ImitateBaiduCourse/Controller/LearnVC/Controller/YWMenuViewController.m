
//
//  YWMenuViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/10.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWMenuViewController.h"
#import "YWMeunView.h"

@interface YWMenuViewController ()
@property (nonatomic,strong) YWMeunView *menu;

@end

@implementation YWMenuViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMenuView];
}
- (void)setUpMenuView {
    _menu = [[YWMeunView alloc]initWithFrame:CGRectMake(self.view.center.x - 50, self.view.frame.size.height - 200, 100, 100)];
    [self.view addSubview:_menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
