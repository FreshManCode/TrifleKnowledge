//
//  UncaughtExceptionHandler.h
//  异常捕获
//
//  Created by 周成龙 on 17/4/25.
//  Copyright © 2017年 ZCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}

@end

void HandleException(NSException *exception);
void SignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);
