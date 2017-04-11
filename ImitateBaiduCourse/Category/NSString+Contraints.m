//
//  NSString+Contraints.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/30.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NSString+Contraints.h"
#import <objc/runtime.h>
static const NSString * tag = @"Test";

@implementation NSString (Contraints)

- (NSString *)test {
    return objc_getAssociatedObject(self, &tag);
}
- (void)setTest:(NSString *)test {
    objc_setAssociatedObject(self, &tag, test, OBJC_ASSOCIATION_COPY);
}


- (CGSize)getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font width:(CGFloat)width {
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing= lineSpace;
    NSDictionary *dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dict
                                       context:nil].size;
    
    return size;
}

- (CGSize)getAttributionHeightWithLineSpace:(CGFloat)lineSpace font:(UIFont *)font width:(CGFloat)width {
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing= lineSpace;
    NSDictionary *dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dict
                                       context:nil].size;
    
    return size;

}

@end
