//
//  PopSelectedMenuViewModel.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/8.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopSelectedMenuViewModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithItemTitle:(NSString *)title
                    itemImageName:(NSString *)imageName;

@end
