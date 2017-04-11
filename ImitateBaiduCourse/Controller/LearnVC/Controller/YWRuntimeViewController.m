//
//  YWRuntimeViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/28.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWRuntimeViewController.h"
#import "NSObject+AllProperty.h"
#import "YWRuntimeTestModel.h"

@interface YWRuntimeViewController ()

@end

@implementation YWRuntimeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setName:@"李白" tag:15];
    NSDictionary *parmas = [self getAllPropertyAndValues];
    NSArray  *keysArray  = [self getAllProperties];
    NSLog(@"参数:%@----keys:%@",parmas,keysArray);
    
    [self getTestModelAllProperty];
}


- (void)getTestModelAllProperty {
    unsigned int outCount =0;
    objc_property_t *properties = class_copyPropertyList([YWRuntimeTestModel class], &outCount);
    
    for (NSInteger i =0; i < outCount; i ++) {
        NSString *name = @(property_getName(properties[i]));
        NSString *attributes = @(property_getAttributes(properties[i]));
        NSLog(@"%@----%@",name,attributes);
    }
    // 这句话并不能获取父类的类型，只能获取当前类的类型名
    NSLog(@"%@", NSStringFromClass([super class]));
    /*
     name--------T@"NSString",&,N,V_name
     age--------Ti,N,V_age
     weight--------Td,N,V_weight
     property_getName 用来查找属性的名称,返回c字符串.property_getAttributes 函数挖掘属性的真实名称和@encode类型,返回c 字符串
     
     objc_property_t class_getProperty(Class cls,const char *name)
     objc_property_t protocol_getProperty(Protocol *proto, const char *name, BOOL isRequiredProperty, BOOL isInstanceProperty)
     class_getProperty 和 protocol_getProperty 通过给出属性名在类和协议中获得属性的引用。
     
     */
    
}

//动态方法解析
- (void)analysizeDynamicMethod {
/*
我们可以动态提供一个方法实现.如果我们使用关键字@dynamic 在类的实现文件中修饰一个属性,表明我们会为这个属性动态提供存取方法,编译器不会再默认为我们生成这个属性的setter 和 getter 方法了,需要我们自己提供
 @dynamic propertyName;
 这时，我们可以通过分别重载 resolveInstanceMethod: 和 resolveClassMethod: 方法添加实例方法实现和类方法实现。
 
 当 Runtime 系统在 Cache 和类的方法列表(包括父类)中找不到要执行的方法时，Runtime 会调用 resolveInstanceMethod: 或 resolveClassMethod: 来给我们一次动态添加方法实现的机会。我们需要用 class_addMethod 函数完成向特定类添加特定方法实现的操作：
 void dynamicMethodIMP(id self, SEL _cmd) {
 // implementation ....
 }
 @implementation MyClass
 + (BOOL)resolveInstanceMethod:(SEL)aSEL
 {
 if (aSEL == @selector(resolveThisMethodDynamically)) {
 class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
 return YES;
 }
 return [super resolveInstanceMethod:aSEL];
 }
 @end
 上面的例子为 resolveThisMethodDynamically 方法添加了实现内容，就是 dynamicMethodIMP 方法中的代码。其中 "v@:" 表示返回值和参数，
 
 注意：
 动态方法解析会在消息转发机制侵入前执行，动态方法解析器将会首先给予提供该方法选择器对应的 IMP 的机会。如果你想让该方法选择器被传送到转发机制，就让 resolveInstanceMethod: 方法返回 NO。
 
*/
}





- (void)setName:(NSString *)name tag:(int)tag {
    if (_name != name) {
        _name = name;
    }
    
    if (_tag != tag) {
        _tag = tag;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
