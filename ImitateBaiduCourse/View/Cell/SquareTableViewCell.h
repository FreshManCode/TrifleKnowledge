//
//  SquareTableViewCell.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/22.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UILabel     *intoLab;
@property (nonatomic,strong) UILabel     *titleLab;

@end
