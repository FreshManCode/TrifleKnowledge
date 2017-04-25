//
//  IBCaughtExceptionHandler.h
//  ImitateBaiduCourse
//
//  Created by SnailJob on 17/4/24.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IBCaughtExceptionHandler : NSObject
+ (void)setExceptionHandler;
+(NSUncaughtExceptionHandler *) getExceptionHandler;
+(void) saveAsText:(NSString *)exceptionText;
+(void) sendEmail:(NSString *)exceptionText;

@end
