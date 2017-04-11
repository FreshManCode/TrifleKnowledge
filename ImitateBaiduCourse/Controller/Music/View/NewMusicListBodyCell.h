//
//  NewMusicListBodyCell.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface NewMusicListBodyCell : UITableViewCell
@property (nonatomic,strong) MusicModel *model;
@property (nonatomic,strong) UIImageView *songImage;
@property (nonatomic,strong) UILabel *lblSongName;
@property (nonatomic,strong) UILabel *lblSingerName;
@property (nonatomic,strong) UILabel *lblFavoriteCount;
@property (nonatomic,strong) UIView  *sepratorLine;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
