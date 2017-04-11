
//
//  ThreeViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/9/6.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "ThreeViewController.h"

@implementation ThreeViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [self sortContainerOrder];
    [self recordMovedDistance];
}

- (void)sortContainerOrder {
    NSDictionary *tempDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"key",@"123",@"helo",@"黎明",@"李白",@"老家",@"name",@"goods",@"23",@"语音", @"78",@"35",nil];
    //key ASCII码升序
    NSArray *keysArray = [[tempDic allKeys]sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSArray *keysReverseArray = [[tempDic allValues]sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1];
    }];
    
    // value ASCII码降序
    NSArray *valuesArray = [[tempDic allValues]sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSArray *valueReverseArray = [[tempDic allValues]sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1];
    }];
    
    NSArray *strigArray = [NSArray arrayWithObjects:@"2",@"3",@"6",@"3",@"7",@"9",@"10",@"18", nil];
    //按照大小 升序排列
    NSComparator sort = ^ (id string1, id string2) {
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        } else if ([string1 integerValue] < [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }else {
            return (NSComparisonResult)NSOrderedSame;
        }
    };
    NSArray *strigOrderArray = [strigArray sortedArrayUsingComparator:sort];
    NSLog(@"%@---%@---%@--%@---%@",keysArray,keysReverseArray,valuesArray,valueReverseArray,strigOrderArray);

}

- (void)recordMovedDistance {
    
}


@end
