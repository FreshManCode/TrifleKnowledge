//
//  ContactsManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/24.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YContactObject;

@interface ContactsManager : NSObject

+ (instancetype)shareInstance;
/**
 请求所有的联系人,按照添加人的时间顺序

 @return 完成的回调
 */

- (void)requestContactsComplete:(void(^)(NSArray <YContactObject *>*))completeBlock;



@end
