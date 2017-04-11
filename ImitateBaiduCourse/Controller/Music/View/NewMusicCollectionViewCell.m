//
//  NewMusicCollectionViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NewMusicCollectionViewCell.h"


@interface NewMusicCollectionViewCell ()
@property (nonatomic,strong) UIImageView *bgImage;
@property (nonatomic,strong) UILabel *songNameLab;
@property (nonatomic,strong) UILabel *singerLab;

@end

@implementation NewMusicCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews {
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    }
    [self addSubview:_bgImage];
    
    if (!_songNameLab) {
        _songNameLab = [[UILabel alloc]initWithFrame:CGRectMake(2, _bgImage.bottom + 3, self.width - 5, 15)];
        _songNameLab.textAlignment = NSTextAlignmentLeft;
        _songNameLab.font = Font(14.0f);
    }
    [self addSubview:_songNameLab];
    
    if (!_singerLab) {
        _singerLab = [[UILabel alloc]initWithFrame:CGRectMake(_songNameLab.left, _songNameLab.bottom + 5, _songNameLab.width, 13)];
        _singerLab.font = Font(12.5f);
        _singerLab.textAlignment = NSTextAlignmentLeft;
    }
    [self addSubview:_singerLab];
    
}

- (void)setMusicModel:(NewMusicModel *)musicModel {
    _musicModel = musicModel;
    //网落图片太大， 在这里为了防止内存警告，每次请求清除一下内存
    [[SDImageCache sharedImageCache] clearMemory];
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:musicModel.pic] placeholderImage:[[PhotoManager shareManager] getBundleImageWithName:@"default.jpg"]];
    self.songNameLab.text = [musicModel.desc componentsSeparatedByString:@"-"][0];
    self.singerLab.text   = [musicModel.desc componentsSeparatedByString:@"-"][1];
}


@end
