//
//  UIImage+Image.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/6.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
- (NSData *)compressImage;
@end
