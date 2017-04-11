//
//  MusicStockModel.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MusicStockModel.h"

@implementation MusicStockModel

+ (instancetype)baseWithDictionary:(NSDictionary *)dic {
    MusicStockModel *model = [[MusicStockModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (id)valueForUndefinedKey:(NSString *)key {
//   / /  NSLog(@"undefinedKey:%@",key);
    return key;
}
@end
