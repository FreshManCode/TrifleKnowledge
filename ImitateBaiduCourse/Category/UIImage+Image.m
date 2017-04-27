//
//  UIImage+Image.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/6.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>

@implementation UIImage (Image)
// 加载分类到内存的时候调用
+ (void)load {
//交换方法
//获取imageWithName 方法地址
    //获取imageWithName 方法地址
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    //获取imageNamed 方法地址
    Method imageName     = class_getClassMethod(self, @selector(imageNamed:));
    //调用交换方法,实现时用A方法 替换B方法
    method_exchangeImplementations(imageWithName, imageName);
}


// 不能在分类中重写系统方法imageNamed,因为会把系统的功能给覆盖掉,而且分类中不能调用super
// 既能加载图片又能打印
+ (instancetype)imageWithName:(NSString *)name {
    //这里调用imageWithName,相当于调用imageName
    UIImage *image = [self imageWithName:name];
    if (image == nil) {
        NSLog(@"加载空的图片");
    } else {
        NSLog(@"加载的图片有值名字是:%@",name);
    }
    return image;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
//    float scale = [UIScreen mainScreen].scale;
    float scale = scaleSize;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width * scale, image.size.height * scale), YES, 0.0);
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (NSData *)compressImage {
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    if (data.length>50*1000) {
        if (data.length > 5000 * 1000) {
            data = UIImageJPEGRepresentation(self, 0.15);
        }else if (data.length>3000*1000) {//3M以及以上
            data = UIImageJPEGRepresentation(self, 0.2);
        } else if (data.length >1500 * 1000 ) {
            data = UIImageJPEGRepresentation(self, 0.3);
        } else if (data.length>512*1000) {//0.5M-1M
            data = UIImageJPEGRepresentation(self, 0.45);
        } else if (data.length>200*1000) {//0.25M-0.5M
            data = UIImageJPEGRepresentation(self, 0.6);
        } else {
            data = UIImageJPEGRepresentation(self, 0.7);
        }
    } else {
        data = UIImageJPEGRepresentation(self, 0.85);
    }
    return data;
}


@end
