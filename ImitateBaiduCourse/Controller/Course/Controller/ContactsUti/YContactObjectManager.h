//
//  YContactObjectManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/24.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;
@class YContactObject;
@interface YContactObjectManager : NSObject



/**
 根据ABRecordRef 数据获得YContactObject 对象

 @param  recordRef ABRecordRef 对象
 @return YContactObject 对象
 */
+ (YContactObject *)contactObject:(ABRecordRef)recordRef;


@end
