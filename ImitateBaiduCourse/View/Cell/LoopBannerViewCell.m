//
//  LoopBannerViewCell.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "LoopBannerViewCell.h"

@implementation LoopBannerViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.frame];
        [self addSubview:_imageView];
    }
}


@end
