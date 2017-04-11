//
//  NewMusicListBodyCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NewMusicListBodyCell.h"

static NSString *identifier = @"NewMusicListBodyCell";
@implementation NewMusicListBodyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NewMusicListBodyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewMusicListBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}


- (void)setUpSubViews {
    if (!_songImage) {
        _songImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        _songImage.image = [[PhotoManager shareManager] getBundleImageWithName:@"song_list_item_inlove.png"];
    }
    [self addSubview:_songImage];
    
    if (!_lblFavoriteCount) {
        _lblFavoriteCount = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 60, 21)];
        _lblFavoriteCount.textAlignment = NSTextAlignmentCenter;
        _lblFavoriteCount.font = Font(13.0f);
    }
    [self addSubview:_lblFavoriteCount];
    
    if (!_lblSongName) {
        _lblSongName = [[UILabel alloc]initWithFrame:CGRectMake(70, 18, SCREENWIDTH - 75, 21)];
        _lblSongName.textAlignment = NSTextAlignmentLeft;
        _lblSongName.font = Font(16.0f);
    }
    [self addSubview:_lblSongName];
    
    if (!_lblSingerName) {
        _lblSingerName = [[UILabel alloc]initWithFrame:CGRectMake(91, 47, SCREENWIDTH - 95, 17)];
        _lblSingerName.textAlignment = NSTextAlignmentLeft;
        _lblSingerName.textColor = [UIColor lightGrayColor];
        _lblSingerName.font = Font(14.0f);
    }
    [self addSubview:_lblSingerName];
    
    if (!_sepratorLine) {
        _sepratorLine = [[UIView alloc]initWithFrame:CGRectMake(70, 65, SCREENWIDTH - 70, 1.0f)];
        _sepratorLine.backgroundColor = [UIColor lightGrayColor];
    }
    [self addSubview:_sepratorLine];
    
}

- (void)setModel:(MusicModel *)model {
    _model = model;
    self.lblSingerName.text = model.singer_name;
    self.lblFavoriteCount.text = [NSString stringWithFormat:@"%ld", (long)model.pick_count];
}


@end
