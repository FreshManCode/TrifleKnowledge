//
//  MusicModel.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"songId"]) {
        self.song_id = value;
    }
    if ([key isEqualToString:@"singerName"]) {
        self.singer_name = value;
    }
    if ([key isEqualToString:@"name"]) {
        self.song_name = value;
    }
    
    if ([key isEqualToString:@"albumName"]) {
        self.album_name = value;
    }
    if ([key isEqualToString:@"urlList"]) {
        self.url_list = value;
    }
    
    if ([key isEqualToString:@"favorites"]) {
        self.pick_count = [value integerValue];
    }
}


@end
