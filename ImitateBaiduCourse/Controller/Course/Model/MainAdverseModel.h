//
//  MainAdverseModel.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/1.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainAdverseModel : NSObject

@property (readwrite, nonatomic, strong) NSString *adId;
@property (readwrite, nonatomic, strong) NSString *adImageUrl;
@property (readwrite, nonatomic, strong) NSString *adActionUrl;
- (instancetype)initWithDictionary:(NSDictionary *)dic withHost:(NSString *)host;


@end


//流行趋势
@interface MainGoodsModel : NSObject
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_id;
@property (nonatomic,copy) NSString *goods_image;
@property (nonatomic,copy) NSString *goods_price;
@property (nonatomic,copy) NSString *goods_unit;
- (id)initWithDicionary:(NSDictionary *)dic;

@end

//优质商家
@interface MainMerchantsModel : NSObject
@property (nonatomic,copy) NSString *merchants_id;
@property (nonatomic,copy) NSString *merchants_image;
@property (nonatomic,copy) NSString *merchants_title;
- (id)initWithDicionary:(NSDictionary *)dic;

@end
