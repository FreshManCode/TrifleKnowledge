//
//  CALayer+Add.m
//  ImitateBaiduCourse
//
//  Created by ZhangJJ on 16/8/4.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "CALayer+Add.h"

@implementation CALayer (Add)

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
