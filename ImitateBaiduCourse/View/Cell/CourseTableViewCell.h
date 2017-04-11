//
//  CourseTableViewCell.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseListModel.h"
#import "AlbumListModel.h"
typedef NS_ENUM(NSInteger,CourseTableViewCellType) {
 CourseTableViewCellTypeDefault = 0,
 CourseTableViewCellTypeScroll,
};
typedef void (^CategoryClick) (NSInteger index);


@interface CourseTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView  *courseImage;
@property (nonatomic,strong) UILabel      *courseName;
@property (nonatomic,strong) UILabel      *couseIntro;
@property (nonatomic,strong) UIView       *sepratorLineView;
@property (nonatomic,assign) CourseTableViewCellType cellType;
@property (nonatomic,strong) CourseListModel *courseModel;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface CourseScrollCell : UITableViewCell
@property (nonatomic,strong) NSArray      *scrollArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView  *scrollImage;
@property (nonatomic,copy)   CategoryClick courseClick;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end