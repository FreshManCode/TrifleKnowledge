//
//  LearnMutilObject.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/16.
//  Copyright © 2017年 能伍网络. All rights reserved.
//  Block 循环引用相关

#import "LearnMutilObject.h"
typedef void (^blk_t) (void);

@interface LearnMutilObject () {
    blk_t blk_;
    id obj_;
    
}


@end


@implementation LearnMutilObject
/*
 该源代码中dealloc 实例方法一定没有被调用.
 LearnMutilObject类对象的Block类成员变量blk_持有赋值为Block的强引用.即LearnMutilObject 类对象持有Block.init实例
 方法中执行的Block语法使用附有__strong 修饰符的id类型变量self.并且由于Block语法赋值在了成员变量blk_中,因此通过Block语法
 生成在栈上的Block此时由栈复制到堆,并持有所用的self.self持有Block,Block持有self.这正是循环引用.
 */


- (id)init {
    self = [super init];
    blk_ = ^{
        NSLog(@"self = %@",self);
    };
    return self;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

/*
 即Block语法内使用的obj_实际上截获了self.对于编译器来说,obj_只不过是对象用结构体的成员变量.
 
 */

- (void)recyleRetainTwo {
    blk_ = ^{
        NSLog(@"obj_ = %@",obj_);
    };
}

//上面的写法相当于下面的写法
- (void)recyleRetainTwoCopy {
    blk_ = ^{
        NSLog(@"obj_ = %@",self -> obj_);
    };
}

//在为避免循环引用而使用__weak 修饰符时,虽说可以确认使用附有__weak修饰符的变量时是否为nil,但更有必要使之生存以使用赋值给
//附有__weak 修饰符修饰变量的对象.另外还可以使用__block 变量来便秘循环引用
- (void)resoveRecyleRetainTwo {
    __weak typeof(obj_) weakObj = obj_;
    blk_ = ^{
        NSLog(@"obj_= %@",weakObj);
    };
    
}




@end
