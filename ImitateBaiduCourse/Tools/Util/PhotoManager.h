//
//  PhotoManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoManager : NSObject
+ (instancetype)shareManager;
- (UIImage *)getBundleImageWithName:(NSString *)imageName;


@end
