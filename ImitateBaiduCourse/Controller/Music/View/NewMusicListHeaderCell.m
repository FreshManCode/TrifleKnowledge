//
//  NewMusicListCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NewMusicListHeaderCell.h"


@interface NewMusicListHeaderCell ()

@property (nonatomic,strong)UIImageView *listBgImage;
@property (nonatomic,strong)UIImageView *typeImage;

@end

static NSString *identifier = @"NewMusicListCell";
@implementation NewMusicListHeaderCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NewMusicListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewMusicListHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    if (!_listBgImage) {
        _listBgImage = [[UIImageView alloc]init];
    }
    [self addSubview:_listBgImage];
    
    if (!_darkBGView) {
        _darkBGView = [[UIView alloc]init];
        _darkBGView.backgroundColor = [UIColor darkGrayColor];
        _darkBGView.alpha = 0.8;
    }
    [self addSubview:_darkBGView];
    
    if (!_typeImage) {
        _typeImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH -100)/2.0, 30, 100, 100)];
        _typeImage.layer.cornerRadius = 50;
        _typeImage.layer.masksToBounds = YES;
    }
    [_darkBGView addSubview:_typeImage];
}

- (void)layoutSubviews {
    _listBgImage.frame = CGRectMake(0, 0, self.width, self.height);
    _darkBGView.frame  = CGRectMake(0, 0, self.width, self.height);
}


- (void)setUserDict:(NSDictionary *)userDict {
    [self.listBgImage sd_setImageWithURL:[NSURL URLWithString:[userDict[@"pics"] firstObject]] placeholderImage:[[PhotoManager shareManager]getBundleImageWithName:@"default.jpg"]];
    [self.typeImage sd_setImageWithURL:[NSURL URLWithString:[userDict[@"pics"] firstObject]] placeholderImage:[[PhotoManager shareManager] getBundleImageWithName:@"default.jpg"]];
}

@end
