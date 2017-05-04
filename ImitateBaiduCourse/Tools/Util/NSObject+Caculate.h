//
//  NSObject+Caculate.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/1/17.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorManager.h"

@interface NSObject (Caculate)

+ (int)caculte:(void (^)(CaculatorManager *manager))block;
+ (NSMutableAttributedString *)getAttributeStringWithContent:(NSString *)content lineSpacing:(CGFloat)space wordFont:(UIFont *)font;

@end
