//
//  NetworkManager.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)shareManager {
    static NetworkManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}
+ (void)postRequest:(NSString *)urlString parameters:(NSDictionary *)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html",@"text/javascript",@"text/plain", nil];
    [manager POST:urlString parameters:param progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                  success (responseObject);
              } else {
                  if (responseObject) {
                      NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                  options:NSJSONReadingAllowFragments error:nil];
                      success (responseDic);
                  }
              }
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (error) {
                  failure(error);
              }
          }];
}


+ (void)getRequest:(NSString *)urlString parameters:(NSDictionary *)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    /*
     3. 请求格式
     
     AFHTTPRequestSerializer			二进制格式
     AFJSONRequestSerializer			JSON
     AFPropertyListRequestSerializer	PList(是一种特殊的XML,解析起来相对容易)
     
     4. 返回格
     AFHTTPResponseSerializer		   二进制格式
     AFJSONResponseSerializer		   JSON
     AFXMLParserResponseSerializer	  XML,只能返回XMLParser,还需要自己通过代理方法解析
     
     
     */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求格式 ,默认提交请求的数据格式都是二进制的,返回json
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    //设置返回格式
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html",@"text/javascript", @"text/plain", nil];
    [manager GET:urlString parameters:param progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                 success (responseObject);
             } else {
                 if (responseObject) {
                     NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                 options:NSJSONReadingAllowFragments error:nil];
                     success (responseDic);
                 }
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (error) {
                 failure(error);
             }
         }];
}

- (void)requestBannerViewResponseSuccess:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure {
    [NetworkManager getRequest:@"http://test.api.xunpige.com/v20/Homes/index" parameters:nil
                       success:^(id responseObject) {
                           if (responseObject) {
                               NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
                               if ([code isEqualToString:@"0"]) {
                                   if (success) {
                                       success(responseObject);
                                   }
                               }
                           }
                       } failure:^(NSError *error) {
                           if (failure) {
                               failure(error);
                           }
                       }];
}


@end
