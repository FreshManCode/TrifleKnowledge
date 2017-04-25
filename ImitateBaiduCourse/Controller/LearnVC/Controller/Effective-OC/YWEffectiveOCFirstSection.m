//
//  YWEffectiveOCFirstSection.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/4/5.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWEffectiveOCFirstSection.h"

@interface YWEffectiveOCFirstSection ()

@end

@implementation YWEffectiveOCFirstSection

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self learnEffectiveOCTipsThree];
}
#pragma mark -----熟悉Objective -C
- (void)learnAboutOCLanguage {
    NSString *someString = @"The string";
    NSString *anotherStr = someString;
 /*这种语法声明了一个NSString * 的变量,此变量为执行NSString 的指针.所有的O-C 语言的对象都必须这样声明,因为对象所占内存总是分
  配在 "堆空间"中,而绝不会分配在 "栈"上.不能在栈中分配O-C 对象;
  
  只有一个NSString 实例,然而有两个变量指向此实例.两个变量都是NSString * 类型,这说明当前"栈帧"(stack frame)里分配了两块内存
  .每块内存的大小都能容下一枚指针.这两块内存里的值都一样,就是NSString 实例的内存地址
  分配在栈上                   分配在堆中
  someString -------->
                             NSString
  anotherStr -------->
  
  分配在堆中的内存必须直接管理.而分配在栈上用于保存变量的内存则会在其栈帧弹出时自动清理.
  
  在Objecttive - C 代码中,有时会遇到定义不含 * 的变量,它们可能会使用"栈空间(stack space)"这些变量保存的不是Obective-C 对
  象.如下:
  */
    CGRect frame;
    frame.origin.x = 0.0f;
    frame.origin.y = 10.0f;
    frame.size.width  = 100.0f;
    frame.size.height = 150.0f;
    //CGrect 是C 结构体,其定义是
    struct CGRect {
        CGPoint oirgin;
        CGSize size;
    };
    typedef struct CGRect CustomRect;
    //与创建结构体相比,创建对象还需要额外开销,例如分配及释放堆内存等,如果只是保存基本类型等"非对象类型"(nonobject type),那么
    //通常使用CGRect 这种结构体就可以了.
    
    //要点
    //1.OC 为C语言添加了面向对象特性,是其超集.OC使用动态绑定的消息结构,也就是说,在运行时才会检查对象类型.接收到一条线消息之后
    //究竟应执行何种代码,由运行期环境而非编译器来决定.
    //2.理解C语言的核心概念有助于写好OC程序.尤其掌握内存模型与指针.
}

#pragma mark ------类的头文件中尽量少引入其他头文件
- (void)learchEffecticeOCTipsTwo {
    /*将引入头文件的时机尽量延后,只在确有需要时才引入,这样就可以减少类的使用者所引入的头文件数量.这样可以减少编译时间.
     向前声明也解决了两个类互相引用的问题.如果在各自头文件中引入对方的头文件,则会导致"循环引用"(chicken-and-edd situation)
     当解析其中一个头文件时,编译器会发现它引入了另一个头文件,而那个头文件又回过头来引用第一个头文件.使用#import 而非#include
     指令虽然不会导致死循环,但这却意味着两个类里有一个无法被正确编译
     
     但是有时候必须要在头文件中引入其他头文件.例如你写的类继承自某个超类,则必须引入定义那个超类的头文件.同理,如果要声明你写的
     类遵从某个协议(protocol),那么该协议必须由完整定义,且不能使用向前声明.向前声明只能告诉编译器有某个协议,而此时编译器却
     要知道该协议中定义的方法.
     @Class 类名 :向前声明
     
     要点:
     1.除非确有必要,否则不要引入头文件.一般来说,应在某个类的头文件中使用向前声明来提及别的类,并在实现文件中引入那些类的头文件
     .这样做可以尽量降低类之间的耦合(coupling)
     2.有时无法使用向前声明,比如要声明某个类遵循一项协议.这种情况下,尽量把"该类遵循某协议"的这条声明移至"class-continuation 
     中".如果不行的话,就把协议单独放在一个头文件中,然后将其引入.
     */
}

#pragma mark -------多用字面变量语法,少用与之等价的方法
- (void)learnEffectiveOCTipsThree {
    //使用字面量语法(literal syntax)可以缩减源代码长度,使其更为易读
    //字面数值
    //有时需要把整数,浮点数,布尔值封入OC对象中.这种情况下可以用NSNumber类,该类可处理多种类型的数值.若是不用字面量,就需要用下述
    //方式创建实例
    NSNumber *someNumber  = [NSNumber numberWithInt:1];
    NSNumber *someNumberL = @1;
    //可以看到,字面量语法更为精简.不过它还有很多好处.能够以NSNumber实例表示的所有数据类型都可使用该语法.例如:
    NSNumber *intNumber   = @1;
    NSNumber *floarNumber = @2.5f;
    NSNumber *boolNumber  = @YES;
    //字面量语法也可用于下述表达式:
    int   x = 5;
    float y = 6.32f;
    NSNumber *expressionNumber = @(x * y);
    //以字面量来表示数值十分有用.这样做可以令NSNumber 对象变得整洁,因为声明中只包含数值,而没有多余的语法成分.
    
    //字面量数组
    //使用字面量语法来创建是:
    NSArray *animals = @[@"tiger",@"dog",@"cat",@"mouse"];
    //若使用字面量,则是
    NSString *dog = animals[1];
    //这也叫做"取下标"操作(subscripting),与使用字面量语法的其他情况一样,这种方式也更为简洁,更易理解.
    
    //注意:用字面量语法创建时数组时,若数组元素对象中有nil,则会抛出异常,因为字面量语法实际上只是一种"语法糖"(syntactic sugar)
    //其效果等同于先创建了一个数组,然后把方括号内的所有对象都加到这个数组中.抛出的异常如下:
    /* ***Terminate app due to uncaught exception
     "NSIncalidArgumentException",reason :****
     -[__NSPlaceHolderArray initWithObjects:count]:attempt to insert nil object from objects[0]
     
     语法糖:也叫"糖衣语法",是值计算机语言中与另外一套语法等效但是开发者用起来却更加方便的语言.语法糖可令程序易读,减少代码出错率.
     */
    
    id object1 = @"1bc";
    id object2 ;
    id object3 = @"123";
//    NSArray *arrayA = [NSArray arrayWithObjects:object1,object2,object3, nil];
//    NSArray *arrayB = @[object1,object2,object3];
    /* object1 和object3 都指向了有效的OC对象,而object2是nil,那么会出现什么情况?
     按字面量语法创建数组arrayB的时候会抛出异常.arrayA 虽然能创建出来,但是其中却只含object1 一个对象.原因在
     于,"arrayWithObjects"方法会依次处理各个参数,直到发现nil为止,由于object2是nil,所以该方法会以提前结束.
     
     这个微妙的差别表明,使用字面量语法更为安全.抛出异常令应用程序终止执行,这比创建好数组之后才发现元素个数少了要好.向数组中插入
     nil说明程序有错,而通过异常可以更快地发现这个错误.
     */
    
    
    //字面量字典
    NSDictionary *personData = @{@"firstName":@"Matt",@"lastName":@"Galloway",@"age":@28};
    //上面这种写法更简明,而且键值对出现在对象之前,理解起来较顺畅.此范例代码还说明了使用字面量数值的好处.字典中的对象和键必须都是
    //OC对象,所以不能把整数28直接放进去,而要将其封装在NSNumber实例中才行.使用字面量语法很容易就能做到这一点,只需给数字前加
    //一个@字符即可.
}

#pragma mark ---- 多用类型常亮,少用#define 预处理指令
- (void)learnAboutTypeConstant {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
