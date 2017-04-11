//
//  NSObject+propertyCode.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (propertyCode)
/**
 *  自动生成属性声明code
 *
 *  @param dic 传入的字典
 */
+ (void)propertyCodeWithDictionary:(NSDictionary *)dic;
@end
