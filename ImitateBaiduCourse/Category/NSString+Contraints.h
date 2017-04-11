//
//  NSString+Contraints.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/30.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Contraints)

@property (nonatomic,copy) NSString *test;

/**
 *  获取富文本的高度
 *
 *  @param string    文字
 *  @param lineSpace 行间距
 *  @param font      字体大小
 *  @param width     文本宽度
 *
 *  @return size
 */
- (CGSize)getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font width:(CGFloat)width;

- (CGSize)getAttributionHeightWithLineSpace:(CGFloat)lineSpace font:(UIFont *)font width:(CGFloat)width;

@end
