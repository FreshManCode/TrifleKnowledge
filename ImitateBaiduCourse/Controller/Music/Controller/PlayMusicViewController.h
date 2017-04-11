//
//  PlayMusicViewController.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayMusicViewController : BaseViewController
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) AVPlayerItem *currentItem;
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,assign) NSInteger currentIndex;


@end
