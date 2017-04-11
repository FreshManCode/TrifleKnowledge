//
//  PlayerHelper.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerHelper : NSObject

@property (nonatomic,strong) AVQueuePlayer *aPlayer;
+ (instancetype)sharePalyerHelper;


@end
