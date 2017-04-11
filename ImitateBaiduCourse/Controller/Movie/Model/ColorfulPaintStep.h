//
//  ColorfulPaintStep.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/25.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorfulPaintStep : NSObject
@property(nonatomic,assign) CGColorRef  color;
@property(nonatomic,assign) CGFloat     lineWidth;
@property(nonatomic,strong) NSMutableArray *paintPoints ;

@end
