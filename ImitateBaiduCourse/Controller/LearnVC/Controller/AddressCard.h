//
//  AddressCard.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/28.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressCard : NSObject

@property (nonatomic,copy) NSString *name,*email;

- (void)setName:(NSString *)name andEmail:(NSString *)theEmail;


@end


@interface Foo  : NSObject <NSCoding>
@property (nonatomic,copy) NSString *strVal;
@property (nonatomic,assign) int intVal;
@property (nonatomic,assign) float  floatVal;

@end
