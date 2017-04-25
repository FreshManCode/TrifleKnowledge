//
//  ITCaughtExceptionViewController.m
//  ImitateBaiduCourse
//
//  Created by SnailJob on 17/4/24.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "ITCaughtExceptionViewController.h"

@interface ITCaughtExceptionViewController ()

@end

@implementation ITCaughtExceptionViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"异常类";
    UIButton *testButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 110, 100, 100, 40)];
    [testButton setBackgroundColor:[UIColor redColor]];
    [testButton setTitle:@"ClickMe" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(clickCrashEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}
- (void)clickCrashEvent:(UIButton *)sender {
    NSLog(@"我点击的是异常事件");
    NSArray *array = @[@"2",@"3",@"4"];
    NSLog(@"%@",array[5]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
