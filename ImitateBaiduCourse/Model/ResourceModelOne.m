//
//  ResourceModelOne.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "ResourceModelOne.h"

@implementation ResourceModelOne
+(instancetype)modelWithDic:(NSDictionary *)dic {
    ResourceModelOne *model = [[ResourceModelOne alloc]initWithDictionary:dic];
    return model;
}
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.age  = dic[@"age"];
        self.nation = dic[@"nation"];
    }
    return self;
}

@end
