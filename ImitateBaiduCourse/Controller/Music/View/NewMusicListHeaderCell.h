//
//  NewMusicListCell.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMusicListHeaderCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *userDict;
@property (nonatomic,strong) UIView *darkBGView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end

