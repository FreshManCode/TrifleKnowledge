//
//  SquareModel.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/22.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareModel : NSObject
@property (nonatomic, copy)  NSString *typeface_color;
@property (nonatomic,assign) NSInteger position;
@property (nonatomic,assign) BOOL module;
@property (nonatomic,  copy) NSString *maintitle;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,  copy) NSString *deputytitle;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSDictionary *share;
@property (nonatomic,  copy) NSString *title;
@property (nonatomic,  copy) NSString *deputy_typeface_color;
@property (nonatomic,  copy) NSString *tplurl;
@property (nonatomic,  copy) NSString *imageurl;


@end
