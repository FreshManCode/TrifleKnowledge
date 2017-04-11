//
//  ResourceModelOne.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceModelOne : NSObject
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *nation;
+(instancetype)modelWithDic:(NSDictionary *)dic;
@end
