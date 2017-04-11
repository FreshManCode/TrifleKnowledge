//
//  BottomAppearAnimationView.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/9/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomAppearAnimationView : UIView
@property (nonatomic,copy) void (^(DidCloseView))();
-(id)initWithFrame:(CGRect)frame;

@end
