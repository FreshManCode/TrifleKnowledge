//
//  BaseSingleton.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/11.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BaseSingleton.h"

@implementation BaseSingleton
+ (instancetype)shareManager {
    static BaseSingleton *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}

@end
