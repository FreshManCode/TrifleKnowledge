//
//  BigAppearView.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigAppearView : UIView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title cancelTitle:(NSString *)cancel sureTitle:(NSString *)sure;

@property (nonatomic,copy) void (^(CancelEvent)) (UIView *view);
@property (nonatomic,copy) void (^(SureEvent))   (UIView *view);


@end
