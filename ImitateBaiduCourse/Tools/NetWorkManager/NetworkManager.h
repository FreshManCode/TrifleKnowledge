//
//  NetworkManager.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetworkManager : NSObject

+ (instancetype)shareManager;

+ (void)postRequest:(NSString *)urlString parameters:(NSDictionary *)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)getRequest:(NSString *)urlString parameters:(NSDictionary *)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
- (void)requestBannerViewResponseSuccess:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;



@end
