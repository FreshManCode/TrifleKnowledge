//
//  PopSelectedMenuViewModel.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/8.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PopSelectedMenuViewModel.h"

@implementation PopSelectedMenuViewModel

- (instancetype)initWithItemTitle:(NSString *)title
                    itemImageName:(NSString *)imageName {
    PopSelectedMenuViewModel *model = [[PopSelectedMenuViewModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    return model;
    
}



@end
