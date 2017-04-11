//
//  BaseViewController.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic,strong) UIView   *navView;
@property (nonatomic,strong) UILabel  *titleLab;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIView   *navSeptaorLine;

- (CGFloat)getNavHeight;


@end
