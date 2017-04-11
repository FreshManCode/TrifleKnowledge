//
//  PlayMusicView.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PlayMusicView.h"

@interface PlayMusicView ()
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIButton *randomBtn;
@property (nonatomic,strong) UIButton *lastMusicBtn;
@property (nonatomic,strong) UIButton *pauseBtn;
@property (nonatomic,strong) UIButton *nextMusicBtn;
@property (nonatomic,strong) UIButton *collectBtn;

@end

@implementation PlayMusicView
- (id)initWithFrame:(CGRect)frame delegate:(id)delegate {
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 30, SCREENWIDTH - 20, 10)];
    }
}



@end
