
//
//  AlertViewManager.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/7.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "AlertViewManager.h"

@implementation AlertViewManager

+ (instancetype)manager {
    static AlertViewManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AlertViewManager alloc]init];
    });
    return _manager;
}

- (void)showTitle:(NSString *)title
          message:(NSString *)messgae
      cancanTitle:(NSString *)cancelTitle
         okAction:(OKClick)ok
      cancelClick:(CancalClick)cancel{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    if (IsUsefulString(messgae)) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:messgae style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (ok) {
                ok();
            }
        }];
        [alertVC addAction:okAction];
    }
    
    if (IsUsefulString(cancelTitle)) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }];
        [alertVC addAction:cancelAction];
    }
    [[self rootWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (UIWindow *)rootWindow {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    return window;
}

@end
