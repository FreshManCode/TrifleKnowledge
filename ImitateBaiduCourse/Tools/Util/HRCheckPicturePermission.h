//
//  HRCheckPicturePermission.h
//  HR
//
//  Created by SnailJob on 17/4/12.
//  Copyright © 2017年 jinlikeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRCheckPicturePermission : NSObject
+ (BOOL)checkPhotoLibraryAuthorizationStatus;
+ (BOOL)checkCameraAuthorizationStatus;
@end
