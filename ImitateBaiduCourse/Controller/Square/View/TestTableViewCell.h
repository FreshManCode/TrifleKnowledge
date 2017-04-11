//
//  TestTableViewCell.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/11.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestClickModel.h"

@interface TestTableViewCell : UITableViewCell

@property (nonatomic,strong) TestClickModel * model;
@property (nonatomic,copy)   void (^(OpenViewClick)) (UIButton *button);
+ (instancetype)cellWithTableView:(UITableView*)tableView;
@end
