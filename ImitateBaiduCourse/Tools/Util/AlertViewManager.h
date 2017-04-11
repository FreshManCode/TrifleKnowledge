//
//  AlertViewManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/7.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^OKClick) ();
typedef void (^CancalClick) ();

@interface AlertViewManager : NSObject

+ (instancetype)manager;

- (void)showTitle:(NSString *)title
          message:(NSString *)messgae
      cancanTitle:(NSString *)cancelTitle
         okAction:(OKClick)ok
      cancelClick:(CancalClick)cancel;



@end
