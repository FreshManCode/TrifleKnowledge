//
//  HRTipsHUD.h
//  HR
//
//  Created by 巴巴罗萨 on 2017/2/16.
//  Copyright © 2017年 jinlikeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void (^OKClick)     ();
typedef void (^CancelClick) ();

@interface HRTipsHUD : NSObject <MBProgressHUDDelegate> {
    MBProgressHUD *_hudView;
}

+ (instancetype)shareInstance;

- (void)hudShowSuccess:(NSString *)message withSuperView:(UIView *)aView;
- (void)hudShowFailure:(NSString *)message withSuperView:(UIView *)aView;

- (void)hudRemoveFromSuperView:(UIView *)aView;;

- (void)hudShowLoadingMessage:(NSString *)message;
- (void)hudHidden;
- (void)hudRemove;
- (void)hudShowSuccess:(NSString *)message;


- (void)showActionTitle:(NSString *)title
                message:(NSString *)message
            cancelTitle:(NSString *)cancelTitle
               okAction:(OKClick)ok
           cancelAction:(CancelClick)cancel;

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
               okTitle:(NSString *)okTitle
              okAction:(OKClick)ok
          cancelAction:(CancelClick)click;



@end
