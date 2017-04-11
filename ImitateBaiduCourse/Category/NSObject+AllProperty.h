//
//  NSObject+AllProperty.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/28.
//  Copyright © 2017年 能伍网络. All rights reserved.
//  利用Runtime 获取属性和方法

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (AllProperty)

/**
 获取对象的所有属性和属性内容

 @return
 */
- (NSDictionary *)getAllPropertyAndValues;


/**
 获取对象的所有属性

 @return
 */
- (NSArray *)getAllProperties;


/**
 获取对象的所有方法
 */
- (void)getAllMethods;


@end
