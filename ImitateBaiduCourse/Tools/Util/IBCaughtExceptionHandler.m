//
//  IBCaughtExceptionHandler.m
//  ImitateBaiduCourse
//
//  Created by SnailJob on 17/4/24.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "IBCaughtExceptionHandler.h"

@implementation IBCaughtExceptionHandler
void caughtUnexceptionHandle(NSException *exception) {
    NSArray  *array = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name  = [exception name];
    NSString *excaptionText = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[array componentsJoinedByString:@"\n"]];
    [IBCaughtExceptionHandler saveAsText:excaptionText];
    [IBCaughtExceptionHandler sendEmail:excaptionText];
    
}

+ (void)setExceptionHandler {
    NSSetUncaughtExceptionHandler(&caughtUnexceptionHandle);
}
+ (NSUncaughtExceptionHandler *)getExceptionHandler {
    return NSGetUncaughtExceptionHandler();
}
+ (void)saveAsText:(NSString *)exceptionText {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray.firstObject stringByAppendingPathComponent:@"Exception.txt"];
    BOOL isSuccess=  [exceptionText writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (isSuccess) {
        NSLog(@"写入异常信息成功");
    } else {
        NSLog(@"写入异常信息失败");
    }
}

+ (void)sendEmail:(NSString *)exceptionText {
    NSString *appName=@"CFBundleDisplayName";
    NSString *version=@"CFBundleVersion";
    NSString *urlStr = [NSString stringWithFormat:@"mailto:whfandtank@163.com?subject=嗯,遇到麻烦了...%@&body=%@%@发生未捕捉异常错误,希望发送bug至技术支持邮箱,我们会尽快修复该bug,感谢您的配合!<br><br><br>"
                        "错误详情:%@",[NSDate date],appName,version,exceptionText];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}




@end
