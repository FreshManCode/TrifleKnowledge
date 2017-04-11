//
//  YWRegularViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/20.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWRegularViewController.h"

@interface YWRegularViewController ()

@end

@implementation YWRegularViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRegexMethod];
    [self setUpNSPredicateMethod];
}

- (void)setUpRegexMethod {
    //1.创建正则表达式对象,并制定正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\d\\w{10,}" options:0 error:nil];
    //2.获取指定字符串的范围
    NSString *jsonString = @"";
    NSTextCheckingResult *match = [regex firstMatchInString:jsonString options:0 range:NSMakeRange(0, jsonString.length)];
    //截取特定的字符串
    if (match) {
        NSString *result = [jsonString substringWithRange:match.range];
        NSLog(@"输出的结果%@",result);
    }
    
}

//谓词NSPredicate 创建正则表达式
- (void)setUpNSPredicateMethod {
    
    NSArray *testArray = [NSArray arrayWithObjects:@"abc",@"Abc",@"123@qq.com",@"12",@"Hello100", nil];
    //编写正则表达式:只能是数字或者英文,或者两者都存在
    NSString *regex = @"^[a-z0-9A-Z]*$";
    //创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //判断的字符串
    for (NSString *string  in testArray) {
        if ([predicate evaluateWithObject:string]) {
            NSLog(@"匹配到的字符串是:%@",string);
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
