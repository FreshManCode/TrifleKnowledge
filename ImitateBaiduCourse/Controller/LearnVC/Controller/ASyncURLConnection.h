//
//  ASyncURLConnection.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/30.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completeBlock) (NSData *data);
typedef void (^errorBlock) (NSError *error);

@interface ASyncURLConnection : NSObject {
    NSMutableData *_data;
    completeBlock _completeBlock;
    errorBlock _errorBlock;
}
+ (id)request:(NSString *)reqeustURL
completeBlock:(completeBlock)completeBlock
   errorBlock:(errorBlock)errorBlock;
- (id)initWithRequest:(NSString *)requestURL
        completeBlock:(completeBlock)complete
           errorBlock:(errorBlock)error;



@end
