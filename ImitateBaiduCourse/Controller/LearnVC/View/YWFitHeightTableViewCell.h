//
//  YWFitHeightTableViewCell.h
//  ImitateBaiduCourse
//
//  Created by 张君君 on 17/5/3.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWFitHeightTableViewCell : UITableViewCell
@property (nonatomic,copy) NSString *content;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)cellHeightWithContent:(NSString *)content;

@end
