//
//  HRTipsHUD.m
//  HR
//
//  Created by 巴巴罗萨 on 2017/2/16.
//  Copyright © 2017年 jinlikeji. All rights reserved.
//

#import "HRTipsHUD.h"

@implementation HRTipsHUD

+ (instancetype)shareInstance {
    static HRTipsHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[HRTipsHUD alloc]init];
    });
    return hud;
}



- (void)hudShowSuccess:(NSString *)message withSuperView:(UIView *)aView {
    for (UIView *subview in aView.subviews ) {
        if (![subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:aView];
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SVProgressHUD.bundle/success"]];
            hud.mode = MBProgressHUDModeCustomView;
            hud.delegate  = (id) self;
            hud.labelText = message;
            [aView addSubview:hud];
            [aView bringSubviewToFront:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:1.20f];
        }
    }
}
- (void)hudShowFailure:(NSString *)message withSuperView:(UIView *)aView {
    for (UIView *subview in aView.subviews ) {
        if (![subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:aView];
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SVProgressHUD.bundle/error"]];
            hud.mode = MBProgressHUDModeCustomView;
            hud.delegate  = (id) self;
            hud.labelText = message;
            [aView addSubview:hud];
            [aView bringSubviewToFront:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:1.20f];
        }
    }
}

- (void)hudRemoveFromSuperView:(UIView *)aView{
    for (UIView *subViews in aView.subviews ) {
        if ([subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subViews;
            [hud removeFromSuperViewOnHide];
            hud                =nil;
        }
    }
}

- (void)hudShowLoadingMessage:(NSString *)message {
    UIWindow *winodw = [[UIApplication sharedApplication]keyWindow];
    for (UIView *subview in winodw.subviews ) {
        if (![subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:winodw];
            hud.delegate  = (id) self;
            hud.labelText = message;
            [winodw addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:30.0f];
        }
    }
}

- (void)hudRemove {
    UIWindow *winodw = [[UIApplication sharedApplication].delegate window];
    for (UIView *subview in winodw.subviews ) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subview;
            [hud removeFromSuperview];
            hud                =nil;
        }
    }

}


- (void)hudHidden {
    UIWindow *winodw = [[UIApplication sharedApplication].delegate window];
    for (UIView *subview in winodw.subviews ) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            [(MBProgressHUD *)subview hide:YES afterDelay:0];
        }
    }
}
- (void)hudShowSuccess:(NSString *)message {
    UIWindow *winodw = [[UIApplication sharedApplication]keyWindow];
    for (UIView *subview in winodw.subviews ) {
        if (![subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:winodw];
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SVProgressHUD.bundle/success"]];
            hud.mode = MBProgressHUDModeCustomView;
            hud.delegate  = (id) self;
            hud.labelText = message;
            [winodw addSubview:hud];
            [winodw bringSubviewToFront:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:0.80f];
        }
    }
}


- (void)showActionTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okAction:(OKClick)ok cancelAction:(CancelClick)cancel {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([message length] > 0) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            if (ok) {
                ok();
            }
        }];
        [alertVC addAction:okAction];
    }
    if ([cancelTitle length] > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
            if (cancel) {
                cancel();
            }
        }];
        [alertVC addAction:cancelAction];
    }
    [[[UIApplication sharedApplication]keyWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];
}


- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
               okTitle:(NSString *)okTitle
              okAction:(OKClick)ok
          cancelAction:(CancelClick)click{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if ([okTitle length] >0) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            if (ok) {
                ok();
            }
        }];
        [alertVC addAction:okAction];
    }
    
    if ([cancelTitle length] >0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
            if (click ) {
                click();
            }
        }];
        [alertVC addAction:cancelAction];
    }
    [[[UIApplication sharedApplication]keyWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];
    
    
}



@end
