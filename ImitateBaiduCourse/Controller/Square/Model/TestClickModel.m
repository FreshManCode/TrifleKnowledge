//
//  TestModel.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/11.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "TestClickModel.h"

@implementation TestClickModel
- (id)copyWithZone:(NSZone *)zone {
    TestClickModel *model = [[TestClickModel allocWithZone:zone]init];
    return model;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    TestClickModel *model = [[TestClickModel allocWithZone:zone]init];
    return model;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@",self.title];
}

@end
