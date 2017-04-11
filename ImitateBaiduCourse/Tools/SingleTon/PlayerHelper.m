//
//  PlayerHelper.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PlayerHelper.h"

@implementation PlayerHelper

+ (instancetype)sharePalyerHelper {
    static PlayerHelper *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[PlayerHelper alloc] init];
    });
    return player;
}

- (id)init {
    if (self = [super init]) {
        self.aPlayer = [[AVQueuePlayer alloc]init];
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setActive:YES error:nil];
    return self;
}


@end
