//
//  WeakProxy.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/9.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakProxy : NSProxy
NS_ASSUME_NONNULL_BEGIN
@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;


@end

NS_ASSUME_NONNULL_END

/*
 类型注释:_nullable 和 _nonnull,
 _nullable表示对象可以是NULL或者nil,而_nonnull表示对象不应该为空,当我么不遵循这一规则时,编译器就会给出警告
 说明:如果需要为每个属性或者方法都去指定nonnull 和 nullable,是一件非常繁琐的事.苹果为了减轻工作量,提供了专门的两个宏:
 NS_ASSUME_NONNULL_BEGIN 和 NS_ASSUME_NONNULL_END.在这两个宏之间的代码,所有简单指针对象都被设定为nonnull,因此我们只需要去指定
 那些nullable的指针
 
 */