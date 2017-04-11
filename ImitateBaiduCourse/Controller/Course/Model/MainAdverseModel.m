//
//  MainAdverseModel.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/1.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MainAdverseModel.h"
#import "MJExtension.h"

@implementation MainAdverseModel
- (instancetype)initWithDictionary:(NSDictionary *)dic withHost:(NSString *)host{
    if (self = [super init]) {
        self.adId        = [NSString stringWithFormat:@"%@",dic[@"id"]];
        self.adImageUrl  = [host stringByAppendingString:dic[@"code"]];
        self.adActionUrl = dic[@"url"];
    }
    return self;
}

@end

@implementation MainGoodsModel
- (id)initWithDicionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goods_name   = dic[@"goods_name"];
        self.goods_id     = dic[@"id"];
        self.goods_image  = dic[@"image"];
        self.goods_price  = dic[@"retail_price"];
        self.goods_unit   = dic[@"unit"];
    }
    return self;
}
//使用MJ时当key和属性名不一致时的情况处理

/**
 key:为属性名
 value:为转化的字典的多级key

 @return 返回的字典
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"goods_name"  : @"goods_name",
             @"goods_id"    : @"id",
             @"goods_image" : @"image",
             @"goods_price" : @"retail_price",
             @"goods_unit"  : @"unit",
    };
}
@end

@implementation MainMerchantsModel
- (id)initWithDicionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.merchants_id     = dic[@"id"];
        self.merchants_image  = dic[@"image"];
        self.merchants_title  = dic[@"title"];
    }
    return self;
}

//使用MJ时当key和属性名不一致时的情况处理

/**
 key:为属性名
 value:为转化的字典的多级key
 
 @return 返回的字典
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"merchants_id"   : @"id",
             @"merchants_image": @"image",
             @"merchants_title": @"title",
             };
}

@end
