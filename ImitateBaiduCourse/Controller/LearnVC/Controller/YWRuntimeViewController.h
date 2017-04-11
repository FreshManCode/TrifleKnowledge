//
//  YWRuntimeViewController.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/28.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "BaseViewController.h"

@interface YWRuntimeViewController : BaseViewController
@property (nonatomic,copy) NSString *name;
@property(nonatomic,assign) int  tag;
- (void)setName:(NSString *)name tag:(int)tag;

@end

/*
 Runtime 又叫运行时,是一套底层C语言的API,我们平时编写的OC代码,底层都是基于它来实现的.比如:
 [receiver message];
 // 底层运行时会被编译器转化为:
 objc_msgSend(receiver,selector)
 //如果还有其他参数比如:
 [receiver message:(id)arg...];
 // 底层运行时会被编译器转转化为:
 objc_msgSend(receiver,selector,arg1,arg2...)
 
 我们需要了解的是OC是一门动态语言,他会将一些工作放在代码运行时才处理而并非编译时.也就是说,有很多类和成员变量在我们编译
 时是不知道的,而运行时,我们所编写的代码会转换成完成的代码运行.
 因此,编译器是不够的,我们还需要一个运行时系统(Runtime system)来处理编译后的代码
 Runtime基本是用C和汇编写的;Runtime的作用:
 OC在三种层面上与Runtime系统进行交互:
 1.通过OC源代码
 2.通过Foundation 框架的NSObject 类定义的方法
 3.通过对Runtime 库函数的直接调用
 
 通过Foundation 框架的NSObject 类定义的方法
 Cocoa 程序中绝大部分类都是NSObject 的子类,所以都继承了NSObject 的行为(NSProxy类是个列外,它是个抽象超类)
 
 通过对Runtime 库函数的直接调用
 Runtime 系统是具有公共接口的动态共享库.头文件存放于/usr/include/objc目录下,这意味着我们使用时只需要引入objc/Runtime.h头文件即可。
 
 一些对Runtime 的术语的数据结构.
 
 SEL
 它是selector 在Objc中的表示(Swift 中是Selctor类).seletor是方法选择器,其实作用就和名字一样,日常生活中,我们通过人名
 辨别谁是谁,注意OC在相同的类中不会有命名相同的两个方法.selector 对方法名进行包装,以便找到相应的方法实现,数据结构是:
 typedef struct objc_selector *SEL;
 我们可以看出它是个映射到方法的C字符串,可以通过OC编译器命令@selector()或者Runtime 系统的sel_registerName 函数来
 获取一个SEL类型的方法选择器.
 注意:不同类中相同名字的方法所对应的selector 是相同的,由于变量的类型不同,所以不会导致它们调用实现混乱.
 
 id:是一个参数类型,它是指向某个类的实例的指针.定义如下:
 typedef struct objc _object *id;
 struct objc_object {Class isd;};
 objc_object 结构体包含一个ids指针,根据isa指针可以找到对象所属的类.
 注意:isa 指针在代码运行时并不总指向实例对象所属的类型,所以不能依靠它来确定类型,要想确定类型还是需要对象的 -class 方法
 PS:KVO 的实现机理就是将被观察者对象的isa指针指向一个中间类而不是真实类型.
 
 Class
 typedef struct objc_class *Class
 Class 其实是指向objc_class 结构体的指针.objc_class 的数据结构如下:
 struct objc_class {
     Class isa OBJC_ISA_AVAILABLITY;
 #if !__OBJC2__
     Class super_class                                        OBJC2_UNAVAILABLE;
     const char *name                                         OBJC2_UNAVAILABLE;
     long version                                             OBJC2_UNAVAILABLE;
     long info                                                OBJC2_UNAVAILABLE;
     long instance_size                                       OBJC2_UNAVAILABLE;
     struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
     struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
     struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
     struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
 #endif
 } OBJC2_UNAVAILABLE;
 从objc_class 可以看到,一个运行时时类中关联了它的父类指针,类名,成员变量,方法,缓存以及附属的协议.
 其中objc_ivar_list 和 objc_method_list 分别是成员变量列表和方法列表:
 
 // 成员变量列表
 struct objc_ivar_list {
 int ivar_count                                           OBJC2_UNAVAILABLE;
 #ifdef __LP64__
 int space                                                OBJC2_UNAVAILABLE;
 #endif
 struct objc_ivar ivar_list[1]                            OBJC2_UNAVAILABLE;
 }                                                        OBJC2_UNAVAILABLE;
 
 // 方法列表
 struct objc_method_list {
 struct objc_method_list *obsolete                        OBJC2_UNAVAILABLE;
 
 int method_count                                         OBJC2_UNAVAILABLE;
 #ifdef __LP64__
 int space                                                OBJC2_UNAVAILABLE;
 #endif
 struct objc_method method_list[1]                        OBJC2_UNAVAILABLE;
 }

 由此可见,我们可以动态修改*methodList 的值来添加成员方法,这也是Category 实现的原理,同样也解释了Category 不能添加属性
 的原因.
 objc_ivar_list 结构体用来存储成员变量的列表,而objc_ivar 则是存储了单个成员变量的信息;同理,objc_method_list 结构体
 存储着方法数组的列表,而单个方法的信息则由objc_method 结构体存储.
 
 值得注意的是:objc_class 中也有一个isa 指针,这说明Objc 类本身也是一个对象.为了处理类和对象的关系,Runtime 库创建了一种叫
 做Meta Class(元类)的东西,类对象所属的类就叫做元类.Meta Class 表述了类对象本身所具备的元数据.
 
 我们所熟悉的类方法,就源于Meta Class.我们可以理解为类方法就是类对象的实例方法.每个类仅有一个类对象,而每个类对象仅有一个与之
 相关的元类.
 
 当你发出一个类似[NSObject alloc](类方法)的消息时,实际上,这个消息被发送给一个类对象(Class Object),这个类对象必须是一个
 元类的实例,而这个元类同时也是一个根元类(Root Meta Class)的实例.所有元类的isa 指针最终都指向根源类.
 
 所以当[NSObject alloc]这条消息发送给类对象的时候,运行时代码objc_msgSend() 会去它元类中查找能够相应的消息的方法
 实现,如果找到了,就会对这个类对象执行方法调用.
 
 Method 
 Method 代表类中某个方法的类型
 typedef struct objc_method *Method;
 struct objc_method {
 SEL method_name        OBJC2_UNAVAILABLE;
 char *method_types     OBJC2_UNAVAILABLE;
 IMP method_imp         OBJC2_UNAVAILABLE;
 }
 objc_method 存储了方法名,方法类型和方法实现:
 . 方法名类型为 SEL
 . 方法类型method_types 是个char 指针,存储方法的参数类型和返回值类型
 . method_imp 指向了方法的实现,本质上是一个函数指针
 
 Ivar 
 Ivar 是表示成员变量的类型
 typedef stuct objc_ivar*Ivar;
 struct objc_ivar {
 char *ivar_name                                          OBJC2_UNAVAILABLE;
 char *ivar_type                                          OBJC2_UNAVAILABLE;
 int ivar_offset                                          OBJC2_UNAVAILABLE;
 #ifdef __LP64__
 int space                                                OBJC2_UNAVAILABLE;
 #endif
 }
 其中ivar_offset 是基地址偏移字节
 
 IMP
 IMP在objc.h 中的定义是:
 typedef id (*IMP)(id ,SEL,...);
 他就是一个函数指针,这是由编译器生成的.当你发起一个Objc消息之后,最终它会执行的那段代码,就是由这个函数指针指定的.而IMP这个函
 数指针就指向了这个方法的实现.
 如果得到了执行某个实例某个方法的入口,我们就可以绕开消息传递阶段,直接执行方法,这在后面Cache中会提到.
 IMP指向的方法与objc_msgSend 函数类型相同,参数都包含id 和 SEL类型.每个方法名都对应一个SEL类型的方法选择器,而每个实例对象
 中的SEL对应的方法实现肯定是唯一的,通过一组id 和 SEL参数就能确定唯一的方法实现地址.
 而一个确定的方法也只有唯一的一组id 和SEL参数.
 
 Cache 
 Cache 定义如下:
 typedef struct objc_cache *Cache
 
 struct objc_cache {
 unsigned int mask                                        OBJC2_UNAVAILABLE;
 unsigned int occupied                                    OBJC2_UNAVAILABLE;
 Method buckets[1]                                        OBJC2_UNAVAILABLE;
 };
 
 Cache为方法调用的性能进行优化,每当实例对象接收到一个消息时,它不会直接在isa指针指向的类的方法列表中遍历查找能够响应的方法,因为每次都要查找效率太低了,而是优先在Cache 中查找.
 Runtime 系统会把被调用的方法存到Cache中,如果一个方法被调用,那么他有可能今后还会被调用,下次查找的时候就会效率更高.就像计算机
 组成原理中CPU绕过主存现访问Cache一样.
 
 Property
 typedef struct objc_property *Property;
 typedef struct objc_property *objc_property_t; //这个更常用
 可以通过class_copyPropertyList 和protocol_propertyList 方法获取类和协议中的属性:
 objc_property_t *class_copyPropertyList (Class cls,unsigned int *outCount)
 objc_property_t *protocol_copyPropertyList (Protocol * proto,unsigned int *outCount)
 注意:返回的是属性列表,列表中的每个元素都是一个objc_property_t 指针
 
 方法中的隐藏参数:
 我们经藏用到关键字self但是self是如何获取当前方法的对象呢?
 其实,这也是Runtime系统的作用,self 是在方法运行时被动态传入的.
 当objc_msgSend 找到方法对应实现时,它将直接调用该方法实现,并将消息中所有参数都传递给方法实现,同时,它还传递两个隐藏参数:
  .接受消息的对象(self所指向的内容,当前方法的对象指针)
  .方法选择器(_cmd 指向的内容,当前方法的SEL指针)
 因为在源代码方法的定义中,我们并没有发现这两个参数的声明.他们同时在代码编译时被插入方法实现中的.尽管这些参数没有被明确声明,在源代码中我们仍然可以引用他们.
 这两个参数中,self更实用.它是在方法实现中访问消息接收者对象的实例变量的途径.
 这时我们可能会想到另一个关键字super,实际上super关键字接收到消息时,编译器会创建一个objc_super 结构体:
 struct objc_super { id receiver; Class class; };
 
 这个结构体指明了消息应该被传递给特定的父类。 receiver 仍然是 self 本身，当我们想通过 [super class] 获取父类时，编译器其实是将指向 self 的 id 指针和 class 的 SEL 传递给了 objc_msgSendSuper 函数。只有在 NSObject 类中才能找到 class 方法，然后 class 方法底层被转换为 object_getClass()， 接着底层编译器将代码转换为 objc_msgSend(objc_super->receiver, @selector(class))，传入的第一个参数是指向 self 的 id 指针，与调用 [self class] 相同，所以我们得到的永远都是 self 的类型。因此你会发现：
 // 这句话并不能获取父类的类型，只能获取当前类的类型名
 NSLog(@"%@", NSStringFromClass([super class]));
 
 




 */
