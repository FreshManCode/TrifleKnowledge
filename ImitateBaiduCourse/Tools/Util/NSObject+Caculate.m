//
//  NSObject+Caculate.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/1/17.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "NSObject+Caculate.h"

@implementation NSObject (Caculate)
+(int)caculte:(void (^)(CaculatorManager *))block {
    CaculatorManager *caculator = [[CaculatorManager alloc]init];
    block(caculator);
    return caculator.result;
}

@end
