//
//  AnimationViewController.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/9/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,AnimationType) {
    AnimationTypeFromBottom = 0,
    
};

@interface AnimationViewController : BaseViewController
@property (nonatomic,assign) AnimationType type;


@end
