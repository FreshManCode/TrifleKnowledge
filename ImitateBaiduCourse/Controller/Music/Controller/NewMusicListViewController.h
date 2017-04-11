//
//  NewMusicListViewController.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BaseViewController.h"

@interface NewMusicListViewController : BaseViewController
@property (nonatomic, copy)   NSString *navTitile;
@property (nonatomic, copy)   NSString *msg_id;

@property (nonatomic, copy)   NSString *from;   //标识从哪个界面push来的
@property (nonatomic, copy)   NSString *pic_url;//用来接收从排行传过来的图片


@end
