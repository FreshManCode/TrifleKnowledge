//
//  ASyncURLConnection.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/30.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "ASyncURLConnection.h"

@implementation ASyncURLConnection

+ (id)request:(NSString *)reqeustURL
completeBlock:(completeBlock)completeBlock
   errorBlock:(errorBlock)errorBlock {
    id obj = [[self alloc]initWithRequest:reqeustURL completeBlock:completeBlock errorBlock:errorBlock];
    return obj;
}
- (id)initWithRequest:(NSString *)requestURL
        completeBlock:(completeBlock)complete
           errorBlock:(errorBlock)error {
    NSURL *url = [NSURL URLWithString:requestURL];
    NSURLRequest *reqeuest = [NSURLRequest requestWithURL:url];
    if (self = [super init]) {
        _data = [[NSMutableData alloc]init];
        _completeBlock = [complete copy];
        _errorBlock    = [error copy];
        
        
    }
    return self;
    
}


@end
