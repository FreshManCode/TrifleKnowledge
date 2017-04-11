//
//  UIImage+Common.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/28.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+ (UIImage *)imageWithColor:(UIColor *)aColor {
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame {
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    CGContextFillRect(context, aFrame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetImageFromCurrentImageContext();
    return image;
}




@end
