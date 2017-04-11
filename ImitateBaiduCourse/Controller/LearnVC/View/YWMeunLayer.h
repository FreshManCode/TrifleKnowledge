//
//  YWMeunLayer.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/10.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,STAGE) {
    STAGE1,
    STAGE2,
    STAGE3,
};


@interface YWMeunLayer : CALayer
@property(nonatomic,assign) STAGE animateStage;
@property(nonatomic,assign) CGFloat  xAxisPercent;


@end
