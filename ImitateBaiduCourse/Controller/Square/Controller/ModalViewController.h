//
//  ModalViewController.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/11.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClcikValue)(NSString *value);

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>
@optional
- (NSString *)didTransValue:(NSString *)value;

@end

@interface ModalViewController : UIViewController
// 步骤一:
@property (nonatomic,strong) RACSubject *delegateSignal;
@property (nonatomic,assign) id <ModalViewControllerDelegate>delegate;
@property (nonatomic,copy)   ClcikValue clickBlock;


@end
