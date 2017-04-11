//
//  BottomPlayView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BottomPlayView.h"
#import "MusicModel.h"
#import "PlayerHelper.h"

@implementation BottomPlayView
+ (instancetype)shareBottomPlayView {
    static BottomPlayView *bpv = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bpv = [[BottomPlayView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
    });
    return bpv;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
    }
    return self;
}

- (UIView *)contentView {
    if (!_contentView) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        [_contentView addSubview:self.songImage];
        [_contentView addSubview:self.lblSongName];
        [_contentView addSubview:self.lblSinger];
        [_contentView addSubview:self.lineImage];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_contentView addGestureRecognizer:tap];
    }
    return _contentView;
}
- (UIImageView *)songImage {
    if (!_songImage) {
        self.songImage = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 50, 48)];
        _songImage.layer.cornerRadius = 3;
        _songImage.layer.masksToBounds = YES;
        _songImage.image = [[PhotoManager shareManager]getBundleImageWithName:@"effect_env_none.jpg"];
    }
    return _songImage;
}

- (UILabel *)lblSinger {
    if (!_lblSinger) {
        self.lblSinger = [[UILabel alloc] initWithFrame:CGRectMake(61, 2 + 20 + 2   , 120, 15)];
        _lblSinger.text = @"微乐提醒";
        _lblSinger.font = [UIFont systemFontOfSize:14];
        _lblSinger.textColor = [UIColor lightGrayColor];
    }
    return _lblSinger;
}

- (UILabel *)lblSongName {
    if (!_lblSongName) {
        self.lblSongName = [[UILabel alloc] initWithFrame:CGRectMake(10 + 50 + 1, 2, 200, 20)];
        _lblSongName.text = @"没有选择播放的歌曲";
        _lblSongName.font = [UIFont systemFontOfSize:16];
        _lblSongName.textColor = [UIColor colorWithRed:41 / 255.0 green:36 / 255.0  blue:33 / 255.0  alpha:1.0];
    }
    return _lblSongName;
}

- (UIImageView *)lineImage {
    if (!_lineImage) {
        self.lineImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 5, 40, 40)];
        _lineImage.layer.cornerRadius = 20;
        _lineImage.layer.masksToBounds = YES;
        _lineImage.image = [[PhotoManager shareManager]getBundleImageWithName:@"playLine.png"];
    }
    return _lineImage;
}

#pragma mark - Action
//轻拍手势
- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (self.TapPlayView) {
        self.TapPlayView(_dataSourceArr, _currentIndex, _pic_url, _currentItem);
    }
}

- (void)setupPlayerWithModel:(MusicModel *)model  {
    _lblSongName.text = model.song_name;
    _lblSinger.text   = model.singer_name;
    if ([_pic_url isEqualToString:@""]) {
        _pic_url = model.pic_url;
    }
    [_songImage sd_setImageWithURL:[NSURL URLWithString:_pic_url] placeholderImage:[[PhotoManager shareManager] getBundleImageWithName:@"default.jpg"]];
    
    //播放器
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[model.url_list firstObject][@"url"]]];
    //添加通知 (歌曲播放完成之后会有这个通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
    PlayerHelper *player = [PlayerHelper sharePalyerHelper];
    //使当前的Item成为要播放的item
    [player.aPlayer replaceCurrentItemWithPlayerItem:_playerItem];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isPlaying"];
    [player.aPlayer play];
    
    //播放音乐的时候有个动态的那个小图
    _lineImage.animationImages = [NSArray arrayWithObjects:[[PhotoManager shareManager] getBundleImageWithName:@"line1"],[[PhotoManager shareManager]getBundleImageWithName:@"line2"],[[PhotoManager shareManager] getBundleImageWithName:@"line3"],[[PhotoManager shareManager] getBundleImageWithName:@"line4"], nil];
    _lineImage.animationDuration = 1.0;
    if (self.playerTimer) {
        [self.playerTimer invalidate];
    }
    
    //添加计时器
    self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleActionTime:) userInfo:_playerItem repeats:YES];
    
    
    //每当播放一首歌曲其实是要存在本地的,没做本地存储
    
}

#pragma mark 计时器
- (void)handleActionTime:(NSTimer *)timer {
    AVPlayerItem *newItem = (AVPlayerItem *)timer.userInfo;
    if ([newItem status] == AVPlayerStatusReadyToPlay) {
        [_lineImage startAnimating];
        //当播放时,存储当前播放的Item,用来与播放界面之间的信息通讯
        _currentItem = newItem;
        if (self.ASTimer) {
            self.ASTimer(newItem);
        }
    }
}

//歌曲播放完毕后处理事件
- (void)playerItemAction:(AVPlayerItem *)item {
    [self.playerTimer invalidate];
    if (self.NextSong) {
        self.NextSong();
    } else {
        //给系统设置一个延迟,准备播放下一首(如果不延迟,将不能自己播放下一首ps:或许player还没有准备好播放)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self nextSong];
        });
    }
}

//获取下一首歌曲
- (void)nextSong {
    [BottomPlayView shareBottomPlayView].playerItem = nil;
    if (++ _currentIndex >=_dataSourceArr.count) {
        _currentIndex = 0;
        [self setupPlayerWithModel:[_dataSourceArr firstObject]];
    } else {
        [self setupPlayerWithModel:_dataSourceArr[_currentIndex]];
    }
}




@end
