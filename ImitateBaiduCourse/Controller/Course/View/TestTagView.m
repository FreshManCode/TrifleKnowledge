//
//  TestTagView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/1.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "TestTagView.h"

@implementation TestTagView

- (id)initWithFrame:(CGRect)frame leftIconName:(NSString *)name title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUpSubViewsWithImageName:name title:title];
    }
    return self;
}

- (void)setUpSubViewsWithImageName:(NSString *)name title:(NSString *)title {
    UIImageView *leftIcon = [[UIImageView alloc]initWithFrame:CGRectMake(8, (self.height -10 - 20)/2.0 , 20, 20)];
    if (name) {
        leftIcon.image = [[PhotoManager shareManager]getBundleImageWithName:name];
    } else {
        [leftIcon setBackgroundColor:[UIColor blueColor]];
    }
    [self addSubview:leftIcon];
    
    UILabel *titlelLab = [[UILabel alloc]initWithFrame:CGRectMake(leftIcon.right + 10, 0, self.width - 60, self.height -10)];
    titlelLab.text     = title;
    titlelLab.textAlignment = NSTextAlignmentLeft;
    titlelLab.textColor= [UIColor lightGrayColor];
    titlelLab.font     = Font(15.0f);
    [self addSubview:titlelLab];
    
    CALayer *sepratorLine = [CALayer layer];
    sepratorLine.frame    = CGRectMake(0, self.bottom - 10, self.width, 10);
    [sepratorLine setBackgroundColor:RGB(238, 238, 238).CGColor];
    [self.layer addSublayer:sepratorLine];
    
}


@end
