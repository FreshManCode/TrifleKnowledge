
//
//  PlayMusicViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PlayMusicViewController.h"
#import "PlayerHelper.h"
#import "MusicModel.h"
#import "BottomPlayView.h"
#import <Masonry.h>

@interface PlayMusicViewController () {
    BOOL _isRandom;
}

@property (nonatomic,strong) UILabel *lblSongName;
@property (nonatomic,strong) UILabel *lblSinger;
@property (nonatomic,strong) UIImageView *imageSong;
@property (nonatomic,strong) UILabel *lblCurrentTime;
@property (nonatomic,strong) UILabel *llblDurationTime;
@property (nonatomic,strong) UISlider *sliderBar;
@property (nonatomic,strong) UIButton *btnPlay;
@property (nonatomic,strong) UIImageView *centerImage;
@property (nonatomic,strong) UIButton *btnPlayType;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@property (nonatomic, strong) PlayerHelper *player;


@end


@implementation PlayMusicViewController


#pragma mark 系统类
//单独定制白色状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.titleLab setText:@""];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    if (!_lblSongName) {
        _lblSongName = [[UILabel alloc]initWithFrame:CGRectMake(self.leftBtn.right, self.leftBtn.top, SCREENWIDTH - self.leftBtn.width - 30, 15)];
        _lblSongName.textColor = [UIColor whiteColor];
        _lblSongName.textAlignment = NSTextAlignmentLeft;
        _lblSongName.font = Font(14.0f);
    }
    [self.view addSubview:_lblSongName];
    
    if (!_lblSinger) {
        _lblSinger = [[UILabel alloc]initWithFrame:CGRectMake(_lblSongName.left, _lblSongName.bottom + 5, _lblSongName.width, 15)];
        _lblSinger.textAlignment = NSTextAlignmentLeft;
        _lblSinger.font = Font(13.0f);
    }
    [self.view addSubview:_lblSinger];
    
    if (!_imageSong) {
        _imageSong = [[UIImageView alloc]init];
        _imageSong.image = [[PhotoManager shareManager] getBundleImageWithName:@"default.jpg"];
    }
    [self.view addSubview:_imageSong];
    [_imageSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@(self.view.width - 200));
        make.height.equalTo(@(self.imageSong.width));
    }];
    _imageSong.layer.cornerRadius = SCREENWIDTH - 200;
    _imageSong.layer.masksToBounds = YES;
    [_imageSong layoutIfNeeded];
}

#pragma mark -----Configure Data
- (void)setUpPlayDataWithMusicModel:(MusicModel *)model {
    //创建模糊层
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    [_blurEffectView removeFromSuperview];
    self.blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    _blurEffectView.frame = self.view.bounds;
    [self.imageSong insertSubview:_blurEffectView atIndex:0];
    [self.imageSong sd_setImageWithURL:[NSURL URLWithString:_pic_url] placeholderImage:[[PhotoManager shareManager] getBundleImageWithName:@"default.jpg"]];
    if (model ==nil) {
        self.lblSinger.text        = @"微乐提醒";
        self.lblSongName.text      = @"没有选择播放的歌曲";
        return;
    }
    
    
    
}


@end
