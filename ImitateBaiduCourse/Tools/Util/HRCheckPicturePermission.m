//
//  HRCheckPicturePermission.m
//  HR
//
//  Created by SnailJob on 17/4/12.
//  Copyright © 2017年 jinlikeji. All rights reserved.
//

#import "HRCheckPicturePermission.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define NSFoundationVersionNumber_iOS_7_1 1047.25

@import AVFoundation;


@implementation HRCheckPicturePermission
+ (BOOL)checkPhotoLibraryAuthorizationStatus {
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (ALAuthorizationStatusDenied == authStatus || ALAuthorizationStatusRestricted == authStatus) {
        [self showSettingAlertStr:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
        return NO;
    }
    return YES;
}

+ (BOOL)checkCameraAuthorizationStatus {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        kTipAlert(@"该设备不支持拍照");
        return NO;
    }
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            [self showSettingAlertStr:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }
    return YES;
}


+ (void)showSettingAlertStr:(NSString *)tipStr {
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        [[HRTipsHUD shareInstance]showAlertTitle:@"提示"
                                         message:tipStr
                                     cancelTitle:@"取消"
                                         okTitle:@"设置"
                                        okAction:^{
                                            UIApplication *app = [UIApplication sharedApplication];
                                            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                            if ([app canOpenURL:settingsURL]) {
                                                [app openURL:settingsURL];
                                            }
                                        } cancelAction:nil];
        
    } else {
        [[HRTipsHUD shareInstance]showAlertTitle:nil
                                         message:tipStr
                                     cancelTitle:@"知道了"
                                         okTitle:nil
                                        okAction:nil
                                    cancelAction:nil];
        
    }
}


@end
