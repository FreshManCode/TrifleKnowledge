//
//  MusicStockModel.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicStockModel : NSObject

@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *typeImageName;
@property (nonatomic, copy) NSString *typeUrl;
+ (instancetype)baseWithDictionary:(NSDictionary *)dic;

@end
