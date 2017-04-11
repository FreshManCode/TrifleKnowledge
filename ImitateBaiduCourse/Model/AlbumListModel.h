//
//  AlbumListModel.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumListModel : NSObject
@property (nonatomic,copy) NSString *AlbumID;
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *PhotoURL;
@property (nonatomic,copy) NSString *Sort;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *IphoneType;
@property (nonatomic,copy) NSString *IpadType;
@property (nonatomic,copy) NSString *Pattern;
@property (nonatomic,copy) NSString *LinkURL;
@property (nonatomic,copy) NSString *ShowStartTime;
@property (nonatomic,copy) NSString *ShowEndTime;


@end
