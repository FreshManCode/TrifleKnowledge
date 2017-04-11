//
//  PhotoManager.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PhotoManager.h"

@implementation PhotoManager
static PhotoManager *_manager;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}

- (UIImage *)getBundleImageWithName:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"Imitate.bundle" ofType:nil];
    NSString *imagePath  = [bundlePath stringByAppendingPathComponent:imageName];
    UIImage  *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
    return image;
}

@end
