//
//  LearnMutilTaskViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/9.
//  Copyright © 2017年 能伍网络. All rights reserved.
//  Objecttive-C 高级编程 iOS多线程和内存管理学习

#import "LearnMutilTaskViewController.h"
#import <objc/runtime.h>
#import <CoreFoundation/CoreFoundation.h>

typedef int (^TestBlockOne) (int);

@interface LearnMutilTaskViewController ()

@end

@implementation LearnMutilTaskViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)learnMemoryManager {
    /*
     只有作为alloc/new/copy/mutableCopy 方法的返回值而取得的对象时,能够自己生成并持有对象.其他情况即为"取得非自己生成
     并持有的对象".这点务必牢记.
     在ARC情况下需要遵守的规则是:
     1.不能使用retain/release/retainCount/autorelease
     2.不能使用NSAllocateObject/NSDeallocateObject
     3.须遵守内存管理的方法命名规则.
     4.不要显示调用dealloc
     5.使用@autoreleasepool 块替代NSAutoreleasePool
     6.不能使用区域(NSZone)
     7.对象型变量不能作为C语言挤乳沟提(struct/union)的成员
     8.显式转换id 和 "void *"
     */
    // 对象型变量不能作为C语言结构体的成员
    // C语言的结构体(struct或union)成员中,如果存在Objective-C对象型变量,便会引起编译错误,如下
//    struct Data {
//        NSMutableArray *array;
//    };
    //error: ARC forbids Objective-C objs in structs or unions
    
    //显式转换 id 和 void *
    //id型或对象型变量赋值给void * 或者逆向赋值时都需要进行特定的转换.如果只想单纯地赋值,则可以使用"__bridge 转换"
    id obj  = [[NSObject alloc]init];
    void *p = (__bridge void *)(obj);
    id o    = (__bridge id)p;
    //像这样通过"__bridge转换",id 和void * 就能互相转换.
    __weak id  obj1 = [[NSObject alloc]init];
    id __weak  obj2 = [[NSObject alloc]init];
    __weak typeof(self) weakSelf = self;
    //ARC 环境下获得引用计数
    NSLog(@"retain count = %ld",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    int result1 = func(10);
//但其实使用函数指针也仍然需要知道函数名称.像以下源代码这样,在赋值给函数指针时,若不使用想赋值函数的名称,就无法取得该函数的地址.
    
    int (*funcPtr) (int) = &func;
    //使用函数指针来代替直接调用函数,那么似乎不用知道函数名也能够使用该函数
    int result2 = (*funcPtr)(10);
    
    /*
     通过Blocks,源代码中就能够使用匿名函数,即不带名称的函数.对于程序员而言,命名就是工作的本质.函数名,变量名,方法名,属性名
     类名和框架名都必须具备.而能够编写不带名称的函数对于程序员相当有吸引力.
     说到这里,我们知道了"带有自动变量值的匿名函数"中"匿名函数"的概念.那么"带有自动变量值"究竟是什么呢?
     首先回顾在C语言中的函数中可能使用的变量.
     1.自动变量(局部变量)
     2.函数的参数
     3.静态变量(静态局部变量)
     4.静态全局变量
     5.全局变量
     其中在函数的多次调用能够传递值的变量有:
     静态变量
     静态全局变量
     全局变量
     
     虽然这些变量的作用域不同,但在整个程序当中,一个变量总保持在一个内存区域/因此,虽然多次调用函数,但该变量总能保持不变,在
     任何时候以任何状态调用,使用的都是同样的额变量值
     */
    buttonCallBack(5);
}

void buttonCallBack(int event) {
    int buttonId = 0;
    printf("buttonId:%d,%d",buttonId,event);
}

#pragma mark -----Block 知识点相关-----
- (void)learnBlockKnowledge {
    int (^Blcok) (int) = ^(int count) {
        return count + 1;
    };
    /*
     与前面的使用函数指针的源代码对比可知,声明Block类型变量仅仅是将声明函数指针类型变量的"*"变为"^".该Blcok类型的变量
     与一般的C语言变量完全相同,可作为以下用途使用.
     1.自动变量
     2.函数参数
     3.静态变量
     4.静态全局变量
     5.全局变量
     由"^"开始的Block语法生成的Block被赋值给变量Block 中.因为与通常的变量相同,所以当然也可以由Block类型变量向Block
     类型变量赋值
     */
    int (^BlockOne) (int a) = Blcok;
    //在函数参数中使用Block类型变量可以向函数传递Block 如下:
}

//在函数参数和返回值使用Block类型变量时,记述方式极为复杂.这时我们可以像使用函数指针类型那样,使用typedef 来解决问题
- (TestBlockOne)retunBlock {
    return ^(int a) {
        return a;
    };
}

TestBlockOne retunBlock (int a) {
    return ^ (int a) {
        return a + 1;
    };
}


//通过赋值给Block类型变量中的Block方法像C语言通常的函数调用那样使用.这种方法与使用函数指针类型变量调用函数的方法几乎完全
void blockPtr () {
    typedef int (^blk_t) (int);
    
}

//声明名称为 func 的函数
int func (int count) {
    return count + 1;
}

#pragma mark -----截取自动变量值
- (void)subtractVaiableValue {
    /* 通过Block 语法和Block类型变量的说明,我们已经理解了"带有自动变量值的匿名函数"中的"匿名函数".而"带有自动变量值"究竟
     是什么呢?"带有自动变量值"在Blocks中表现为"截取自动变量值".截取自动变量值的实例如下:
     */
    gogo();
    //该源代码中,Block语法的表达式使用的是它之前声明的自动变量fmt和val.Blocks中,Block表达式截取所使用的自动变量的值,
    //即保存该自动变量的瞬间值.因为Block表达式保存了自动变量的值,所以在执行Block语法后,即使改写Block中使用的自动变量
    //的值也不会影响Block执行是时自动变量的值.该源代码就在Block语法后改写了Block中的自动变量val和fmt.
    //执行结果是 val = 10;并不是改写后的值"";而是执行Block语法时的自动变量的瞬间值.该Block语法在执行时,字符串指针
    //"val=%d\n"被赋值到自动变量fmt中,int 值10 被赋值到自动变量val中,因此这些值被保存(即被截获),从而在执行块时使用.
    //这就是自动变量值的截获
    
    //.截获的自动变量
    id array = [[NSMutableArray alloc]init];
    void (^Block)(void) = ^ (){
        id obj = [[NSObject alloc]init];
        [array addObject:obj];
    };
    //这是没有问题的,而向截获的变量array赋值则会产生编译错误.该源代码中截获的变量值为NSMUtableArray类的对象.如果用C
    //语言来描述,即是截获NSMutableArray 类对象用的结构体实例指针.虽然赋值给截获的自动变量array 的操作会产生编译错误,
    
    //但使用截获的值却不会有任何问题.下面源代码向截获的自动变量进行赋值.因此会产生编译错误.
//    id array2 = [[NSMutableArray alloc]init];
//    void (^BlockTwo)() = ^() {
//        array2 = [[NSMutableArray alloc]init];
//    };
    
    //另外,在使用C语言数组时必须小心使用其指针,如下
    //只是使用C语言的字符串字面量数组,而并没有向截获的自动变量赋值,因此看似没有问题.但实际上会产生编译错误.
    //这是因为在现在的Bbloks中,截获自动变量的方法并没有实现对C语言数组的截获.这时,使用指针可以解决问题.
//    const char text[] = "hello";
//    void (^Blk)(void) = ^(){
//        printf("%c\n",text[2]);
//    };
    const char *text = "hello";
    void (^Blc)(void) = ^ (){
        printf("%c\n",text[2]);
    };
}

// 下面这种方法是错误的,C语言规范不允许这种赋值.
//void funcTwo (char a[10]){
//    char b[10] = a;
//    printf("%d\n",b[0]);
//}

int gogo () {
    int dmy = 256;
    int val = 10;
    const char * fmt = "val = %d\n";
    void (^Block)(void) = ^(){
        printf(fmt,val);
    };
    val = 2;
    fmt = "These valus were changed .val = %d\n";
    Block();
    return 0;
}

#pragma mark -------G---C----D GCD学习使用
//GCD 的学习
- (void)learnAboutRecycleRetain {
    /*1.第一种方法是通过GCD的API生成Dispatch Queue
     通过dispatch_queue_create 函数可生成Dispatch Queue.一下源代码生成了Serial Dispatch Queue
     */
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("CGD path One", NULL);
    /*讲解关于Serial Dispatch Queue 生成个数的注意事项.
     Concurrent Dispatch Queue 并执行多个追加处理,而Serial Disaptch Queue同时只能执行1个追加处理.虽然
     Serial Disaptch Queue 和 Concurrent Dispatch Queue 受到系统资源的限制,但用dispatch_queue_crate 
     函数可生成任意多个 Dispatch Queue.
     
     当生成多个Serial Dispatch Queue 时,各个Concurrent Dispatch Queue 将并行执行.虽然在1个Serail
     Dispatch Queue 中同时只能执行一个追加处理,但如果将处理分别追加到4个Concurrent Dispatch Queue 中,各个
     Serial Dispatch Queue 执行1个,即为同时执行4个处理.
     
     一旦生成Serial Dispatch Queue 并追加处理,系统对于一个Serial Dispatch Queue并追加处理,系统对于一个
     Serial Dispatch Queue 就只生成并使用一个线程.如果生成2000个Serial Dispatch Queue,那么久生成2000个
     线程.
     如果过多使用线程,就会消耗大量内存,引起大量的上下文切换,大幅度降低系统的响应性能.
     下面继续讲解dispatch_queue_create 函数.该函数的第一个参数指定Serial Dispatch Queue 的名称.像此源代码
     这样,Dispatch Queue 的名称推荐使用应用程序ID 这种逆序全程域名(FQDN,fully qualified domian name).该名
     称在Xcode 和 Instruments 的调试器作为Dispatch Queue 名称表示.另外,该名称也出现在应用程序崩溃时所产生的
     CrashLog中.我们命名时应遵循这样的原则:对我们编程人员来说简单易懂.如果嫌命名麻烦设为NULL也可以,但是在调试中...
       
       生成Serial Dispatch Queue时,像该源代码这样,将第二个参数指定为NULL.生成Concurrent Dispatch Queue 时
     像下面源代码一样,指定为DISPATCH_QUEUE_CONCURRENT.
     
     */
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("com.example.gcd.myConcurrentDispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    //dsipatch_queue_create 函数的返回值表示Dispatch Queue的dispatch_queue_t类型.在之前源代码中所出现的
    //变量queue 均为dispatch_queue_t 类型变量.
    dispatch_async(myConcurrentDispatchQueue, ^{
        NSLog(@"block on  myConcurrentDispatchQueue");
    });
    //该源代码在Concurrent Dispatch Queue 中执行指定的Block.
    
    //2.各种Disparch Queue的获取方法如下:
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t globalHighQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t globalDefaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t globalLowQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t globalBackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //3.dispatch_set_target_queue
    /*dispatch_queue_create 函数生成的Dispatch Queue不管是Serial Dispatch Queue 还是Concurrent 
     Dispatch Queue,都使用与默认优先级Global Dispatch Queue 相同执行优先级的线程.而变更生成的Dispatch 
     Queue 的执行优先级需要使用 dispatch_set_target_queue 函数.在后台执行动作处理的
     Serial Dispatch Queue 的生成方法如下:
     */
    dispatch_queue_t mySerialDispatchQueueTwo = dispatch_queue_create("com.example.CGD", NULL);
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(mySerialDispatchQueueTwo, ^{
        for (int i=0;i<2000;i++) {
            if (i %100==0) {
                NSLog(@"----当前的进度是%d",i);
            }
        }
    });
    dispatch_async(globalDispatchQueueBackground, ^{
        for (int i = 0; i < 800; i++) {
            if (i % 50 == 0) {
                NSLog(@"*****当前的进展是%d",i);
            }
        }
    });
    dispatch_set_target_queue(globalDispatchQueueBackground,mySerialDispatchQueueTwo);
    /*指定要变更执行优先级的Dispatch Queue 为dispatch_set_target_queue 函数的第一个参数,指定要与使用的执行优
     先级相同优先级的Global Dispatch Queue 为第二个参数(目标).第一个参数如果指定系统提供的Main Dispatch 
     Queue 和 Global Dispatch Queue
     */
    
    //4. dispatch_after
    //下面表示从现在 开始 1 秒后的dispatch_time_t 类型的值
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    //数值和NSEC_PER_SEC 的乘积得到单位为毫微妙的数值."ull"是C语言的数值字面量,是显式表明类型时使用的字符串
    //表示(unsigned long long ).如果使用NSEC_PER_MSEC 则可以以毫秒为单位计算.一下源代码获取表示从现在开始
    //150毫秒后的时间值
    dispatch_time_t time150 = dispatch_time(DISPATCH_TIME_NOW, 150ull * NSEC_PER_MSEC);
    /*dispatch_walltime 函数由POSIX中使用的stuct timespec 类型的时间得到的dispatch_time_t 类型的值.
     dispatch_time 函数通常用于计算相对时间.而dispatch_walltime 函数用于计算绝对时间.例如在:dispatch_after
     函数中想指定从2011年11月11日11时11分11秒这一绝对时间的情况,这可作为粗略的闹钟功能使用
     struct timespec 类型的时间可以很轻松地通过NSDate 类对象完成
     */
    
     //5. Dispatch Group
    /*在追加到Dispatch Queue 中的多个处理全部结束后想执行结束处理,这种情况会经常出现.只使用一个Serial Queue 时,
     只要将想执行的处理全部追加到改Serial Dispatch Queue 中并在最后追加结束处理,即可实现.但是在使用Concurrent 
     Dispatch Queue 时或同时使用多个Dispatch Queue 时,源代码就会 变得颇为复杂.
     在此种情况下使用Dispatch Group.例如下面源代码:追加3个Block 到Global Dispatch Queue,这些Block 如果不全
     部执行完毕,就会执行Main Dispatch Queue 中处理结束用的Block
     */
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"block0");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block2");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"代码执行完毕了:done");
    });
    /*因为向Global Dispatch Queue 即Concurrent Dispatch Queue 追加处理,多个线程并行执行,所以追加处理的执行
     顺序不定.执行时会发生变化,但是此执行结果的done一定在最后输出的.
     无论像什么样的Dispatch Queue 中追加处理,使用Dispatch Group 都可监视这些处理执行的结束.一旦检测到所有处理执
     行结束,就可将结束的处理追加到Dispatch Queue中.这就是使用Dispatch Group的原因.
     
     dispatch_group_wait 函数的第二个参数指定为等待的时间(超时).它属于dispatch_time_t 类型的值.只要属于
     Dispatch Group 的处理尚未执行结束,就会一直等待,中途不能取消.
     如同dispatch_after 函数说明中出现的那样,指定等待间隔为1妙时应做如下处理.
     */
    dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    long result = dispatch_group_wait(group, time1);
    if (result == 0) {
        //属于 Dispatch Group 的全部处理执行结束
    } else {
        //属于Dispatch Group 的某一个处理还在执行中
    }
    /* 如果dispatch_group_wait 函数的返回值不为0,就意味着虽然经过了指定的时间,但属于Dispatch Group
     的某一个处理还在执行中.如果返回值为0,那么全部处理执行结束.当等待时间为 DISPATCH_TIME_FOREVER ,由
     dispatch_group_wait 函数返回时,由于属于Dispatch Group 的处理必定全部执行结束,因此返回值为0.
     
     一旦调用 dispatch_group_wait 函数,该函数就处于调用的状态而不返.即执行dispatch_group_wait 函数
     的现在的线程(当前线程)停止.在经过dispatch_group_wait 函数中指定的时间或属于指定Dispatch Group的
     处理全部执行结束之前,执行该函数的线程停止.
     指定DISPATCH-TIME-NOW ,则不用任何等待即可判定属于Dispatch Group的处理是否执行结束.

     */
    long result2 = dispatch_group_wait(group, DISPATCH_TIME_NOW);
    /* 在主线程的RunLoop 的每次循环中,可检查执行是否结束,从而不耗费多余的等待时间,虽然这样也可以,但一般在
     这种情形下,还是推荐使用 dispatch_group_notify 函数追加结束处理到Main Dispatch Queue 中.这是
     因为dispatch_group_notify 函数可以简化源代码.
     */
    
    //6.dispatch_barrier_async
    /*在访问数据库或文件时,如前所述,使用Serial Dispatch Queue 可避免数据竞争的问题.
     写入处理确实不可与其他的写入处理以及包含读取处理的其他某些处理并执行.但是如果读取处理只是与去读处理并行
     执行,那么多个并行执行就不会发生问题.
     也就是说,为了高效率地进行访问,读取处理追加到Concurrent Dispatch Queue 中,写入处理在任意个读取处理
     没有执行的状态下,追加Serial Dispatch Queue 中即可(在写入处理结束之前,读取处理不可执行)
     虽然利用Dispatch Group 和 dispatch_set_target_queue 函数也可实现,但是源代码会很复杂.
     GCD 为我们提供了更为聪明的解决方法-----dispatch_barrier_async 函数.该函数同dispatch_queue_create
     函数生成的Concurrent Dispatch Queue 一起使用.
     首先dispatch_queue_create 函数生成Concurrent Dispatch Queue ,在dispatch_async 中追加读取处理.
     
     dispatch_barrier_async 函数会等待追加到Concurrent Dispatch Queue 上的并行执行的处理全部结束以后,再将
     指定的处理追加到该Concurrent Dispatch Queue中.然后在由dispatch_barrier_async 函数追加的处理执行完毕后
     Concurrent Dispatch Queue 才恢复为一般的动作,追加到该Concurrent Dispatch Queue 的处理又开始并行执行
     */
    dispatch_queue_t barrierQueue = dispatch_queue_create("com.example.gcd.Forbarrier", 0);
    dispatch_async(barrierQueue, ^{
        
    });
    
    // dispatch_apply
    /*
     dispatch_apply 函数是dispatch_sync 函数和Dispatch Group 的关联API.该函数按指定的次数将指定的Block追加
     到指定的Dispatch Queue中,并等待全部处理执行结束.
     
     因为在分线程中执行处理,所以各个处理的执行时间不定.但是输出结果中的done必定在最后的位置上.这是因为dispatch_apply
     函数会等待全部处理执行结束.
     第一个参数为重复次数,第二个参数为追加对象的Dispatch Queue,第三个参数为追加的处理.与目前为止所出现的例子不同,第
     三个参数的Block为带有参数的Block.这是为了按第一个参数重复追加Block并区分各个Block而使用.例如要对NSArray 类
     对象的所有元素执行处理时,不必一个一个编写for循环部分.
    
     */
    dispatch_queue_t queueTest = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, queueTest, ^(size_t index) {
        NSLog(@"------%zu",index);
    });
    NSLog(@"done");
    NSArray *testArray = [NSArray arrayWithObjects:@"2",@"3",@"4",@"5", nil];
    dispatch_apply([testArray count], queueTest, ^(size_t index) {
        NSLog(@"%zu : %@",index,testArray[index]);
    });
    /*这样可以简单地在分线程中对所有元素执行Block
     另外,由于dispatch_apply 函数也与dispatch_sync 函数相同,会等待处理执行结束,因此推荐在dispatch_async 函数
     非同步地的执行dispatch_apply 函数.
     */
    dispatch_async(queueTest, ^{
        
    });
    
    //Dispatch I/O
    /*使用该技术读取较大文件,将大文件分成合适的大小并使用GCD并列读取,速度回提升不少.
     Dispatch I/O 和 Dispatch Data
     通过Dispatch I/O 读写文件时,使用GCD将1个文件按某个大小read/write.如下例子:
     */
    __block size_t total = 0;
    size_t size ;//要读取的字节数
    char *buff = (char *)malloc(size);
    //设定为异步映像
    fcntl (lockf,F_SETFL,O_NONBLOCK);
    //获取用户追加事件处理的GCD
    dispatch_queue_t quueQQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //基于Read 事件 作成Dispatch Source
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, lockf , 0, quueQQ);
    //指定发生READ 事件时执行的处理
    dispatch_source_set_event_handler(source, ^{
        //获取可读取的字节数
        size_t available = dispatch_source_get_data(source);
        //从影像中读取
        int length = read(lockf , buff, available);
        //发生错误时取消Dispatch Source
        if (length < 0) {
            //错误处理
            dispatch_source_cancel(source);
        }
        total += length;
        if (total == size) {
            //buff 的处理
            //处理结束,取消Dispatch Source
            dispatch_source_cancel(source);
        }
    });
    
    //指定取消Dispatch Source 时的处理
    dispatch_source_set_cancel_handler(source, ^{
        free(buff);
        close(lockf);
    });
    //启动Dispatch Source
    dispatch_resume(source);
    /*与上面源代码非常相似的代码,使用在了Core Foundation 框架的用于异步网络的API CFSocket中.因为Foudation 框架的异步网络API是通过CFSocket实现的.所以可享受到
     仅使用Foyndation 框架的Dispatch Source (即GCD)带来的好处.
     使用DISPATCH_SOURCE_TYPE_TIME 的定时器的梨子.在网络编程的通信超时等情况下可使该例.
     */
    
    //指定 DISPATCH_SOURCE_TYPE_TIMER 作为Dispatch Source
    //在定时器经过指定时间设定Main Dispatch Queue 为追加处理的Dispatch Queue
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    
    /**
     将定时器设定为15秒后

     @param timer
     @param DISPATCH_TIME_NOW
     @param NSEC_PER_SEC 不指定为重复
     @return 允许延迟1秒
     */
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 15ull * NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 1ull *NSEC_PER_SEC);
    //指定定时器指定时间内执行的处理
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"wakeup!");
        //取消Dispatch Source
        dispatch_source_cancel(timer);
    });
    
    //指定取消Dispatch Source 时的处理
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"canceled");
    });
    //启动Dispatch Source
    dispatch_resume(timer);

}

//我们实际使用一下ARC,Blocks 和GCD.实现从指定的URL 下载数据,在另外的线程中解析该数据并在主线程中使用其解析结果的源代码如下:
- (void)actualUseMethod {
    NSString *url = @"http://images.apple.com/jp/iphone/features/includes/camera-galleray/03-20100607.jpg";
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    [self learnMemoryManager];
    [self subtractVaiableValue];
    [self learnAboutRecycleRetain];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
