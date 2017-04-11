//
//  API.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

#define kMusicHotViewController @"http://api.dongting.com/frontpage/frontpage"

#define kMusicListControllerWeekMusic @"http://api.dongting.com/channel/ranklist/%@/songs?page=1"

#define kMusicListControllerSingerMusic @"http://api.dongting.com/song/singer/%@/songs?page=1&size=50"

#define kMusicListControllerSongType @"http://api.dongting.com/channel/channel/%@/songs?size=50&page=1"

#define kMusicListControllerOther @"http://api.songlist.ttpod.com/songlists/%@"

#define kMusicWeekController  @"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=281"

#define kNewCDController      @"http://online.dongting.com/recomm/new_albums?page=1&size=30"

#define kOpenSearchController @"http://so.ard.iyyin.com/sug/billboard"

#define kSearchController     @"http://so.ard.iyyin.com/s/song_with_out"

#define kSingerController     @"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=%@&size=1000&page=1"

#define kSingerTypeController @"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=46"

#define kSongTypeController   @"http://fm.api.ttpod.com/channellist?image_type=240_200"




@end
