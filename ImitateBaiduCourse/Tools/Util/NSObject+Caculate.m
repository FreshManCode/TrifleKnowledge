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

+ (NSMutableAttributedString *)getAttributeStringWithContent:(NSString *)content lineSpacing:(CGFloat)space wordFont:(UIFont *)font{
    NSMutableAttributedString *atrributeString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 9.0f;
    [atrributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
    [atrributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, content.length)];
    return atrributeString;
}


@end
