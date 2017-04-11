//
//  LearnBlockViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/14.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "LearnBlockViewController.h"
#import "AddressCard.h"
#import <YYKit.h>
typedef void (^BlockName) (NSString *name);

@interface LearnBlockViewController () {
    UISlider *_slider0;
    UISlider *_slider1;
}

//定义了一个日期类型的结构体
struct Date {
    int month;
    int day;
    int year;
};

struct LiMing {
   const char * name;
   const char * age;
    
};




//有参无返回
@property (nonatomic,copy) void (^TestBlock) (NSString *test);
//有参有返回
@property (nonatomic,copy) NSString * (^StringBlock) (NSString *);
//无参无返回
@property (nonatomic,copy) void (^NoParasAndRetunBlock) ();
//无参有返回
@property (nonatomic,copy) int (^NoParamsWithReturnBlock) ();
@property (nonatomic,copy) BlockName  testBlock;


//定义了一个名为 today 的结构体类型
@property(nonatomic,assign) struct  Date today;

//定义了一个 Date 类型的指针
@property(nonatomic,assign) struct  Date *datePtr;

//渐变色
@property(nonatomic,strong) CAGradientLayer * gradientLayer;

@property(nonatomic,strong)  UIImageView *blurImageView;

@property(nonatomic,assign) struct  LiMing person;




@end


@implementation LearnBlockViewController

@synthesize blurImageView = _blurImageView;


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleLab.text = @"知识点学习";
    [self handleWithStructType];
    [self saveDataWithPlistFile];
    [self learnCAGradientLayer];
    [self appearBlurImageViewEffect];
    [self learnAboutPointer];
    // Do any additional setup after loading the view.
}

/*
 Block :块的细节
 ^(void) {
 //块是以插入字符 " ^ " 开头为标识的.后面的括号表示需要的参数列表.在这个例子中,块并没有参数,所以在函数定义中仅填入void
 }
 
 同样,可以将这个块赋给一个名为printMessage的变量,只要变量声明正确:
 void (^printMessage) (void) = ^(void) {
 //中间插入需要执行的
 };
 
 等号左边表示printMessage 指向一个没有参数和返回值的块指针.需要注意的是,赋值语句是以分号终止的.
 执行一个变量引用的块,与函数调用方式一致.
 
 */

#pragma mark -----Block的处理----
- (void)handleWithBlockType {
    _TestBlock = ^ (NSString *test) {
        NSLog(@"%@",test);
    };
    
    _StringBlock = ^ (NSString *string) {
        return  string;
    };
    
    //一般多使用有参(无参)无返回的,用来传递事件或者值
    
    //无参无返回的block形式1
    _NoParasAndRetunBlock = ^ {
        
    };
     //无参无返回的block形式2
    _NoParasAndRetunBlock = ^ () {
        
    };
    
    //无参有返回
    _NoParamsWithReturnBlock = ^ {
        return 1;
    };
    
    //无参有返回
    _NoParamsWithReturnBlock = ^ (){
        return 2;
    };
    
// 像这样直接在block内部修改外部的值是会报错的,应该以下面的形式修改 (ARC)
//    int outParam = 10;
//    _NoParasAndRetunBlock = ^ (){
//        outParam = 100;
//        return outParam;
//    };
    
//这种形式是正确的在block内部修改外部的参数的值
    __block int outParam = 10;
    _NoParamsWithReturnBlock = ^ () {
        outParam = 100;
        return outParam;
    };
}

#pragma mark -----结构体类型的处理 (指针)----
- (void)handleWithStructType {
    // 处理结构体变量时需要特殊语法.通过指定变量名称,在之后加上句点类访问结构成员
    // 变量名,句点和成员名称之间不允许出现空格
    
    
    _today.year   = 2016;
    _today.month  = 12;
    _today.day    = 14;
    
    // 将datePtr 设置为指向 today 变量的指针
    _datePtr = & _today;
    
    //通过指针间接寻址,
    _datePtr ->year  = 2016;
    _datePtr ->month = 12;
    _datePtr ->day   = 15;
    
    _person.name = "李白";
    _person.age  = "23";
    NSLog(@"人名是:%s,年龄是:%s",_person.name,_person.age);
    
    NSError *error = nil;
    //赋值给对象指针时,所有权修饰符必须一致.
    NSError *__strong *pError = &error;
//  下面的这种修饰会报错的,切记
//    NSError **tError =&error;
//   对于其他所有权修饰符也是一样.
    NSError __weak *errorT = nil;
    NSError *__weak *ppError = &errorT;
    
    
    
    
    
    
    int i1 = -5 ,i2 = 66, *p1 = &i1, *p2 = &i2;
    NSLog(@"i1 = %i,i2 = %i",i1,i2);
    exchange(p1, p2);
    NSLog(@"i1 = %i,i2 = %i",i1,i2);
    exchange(&i1, &i2);
    NSLog(@"i1 = %i,i2 = %i",i1,i2);
    
    char *textPtr;
    textPtr = "A chcaracter string.";
    //将textPtr设为指向字符串常亮 "A chcaracter string" 的指针
    
}

void  exchange (int *pint1,int *pint2) {
    int temp;
    temp   = *pint1;
    *pint1 = *pint2;
    *pint2 = temp;
}

#pragma mark ------关于指针的学习
- (void)learnAboutPointer {
    //定义一个名为count的变量
    int count = 10;
    
    //定义一个名为intPtr的便令,它允许间接访问count的值
    int *intPtr;
    /*
     在OC中,星号定义变量intPtr时int的指针类型.这表示在这个程序中,intPtr用于间接访问一个或者多个整型变量的值.
     &运算符:又称为地址运算符,用来得到变量的指针.所以如果 x 是特定类型的变量,那么表达式&x就是该变量的指针.如果需要,&x可以赋值给任何指针变量,只要该指针指向的类型和x相同.
     */
    intPtr = &count;
    
    /*
     建立起intPtr和count之间的间接引用.地址运算符将intPtr赋值为指向变量count的指针,而不是count的值
     intPtr -----> count
     箭头说明intPtr并不直接包含count的值,而是包含变量count的指针
     要通过指针变量intPtr引用count的内容,可以使用间接寻址运算符,即星号 (*).如果x是int类型,那么语句
     x = *intPtr
     会将intPtr 间接指向的值赋给变量x.因为之前将intPtr设置为指向count,所以这个语句的作用就是将变量count的数值10赋值变量x
     
     地址运算符 (&) 间接寻址运算符 (*)
     */
    int x = * intPtr;
    NSLog(@"count = %i, x = %i",count,x);
    
    NSString *search = @"a";
    NSString *mStr   = @"This is a Object-C language";
    NSRange  subRan  = [mStr rangeOfString:search];
    while (subRan.location != NSNotFound) {
        NSLog(@"找到了可用的");
        NSLog(@"找到可用的字符串是:%@",[mStr substringWithRange:subRan]);
        break;
    }
}


#pragma mark -----属性列表归档-----
- (void)saveDataWithPlistFile {
    //注意:进行存储(归档)之前必须要指定存储文件的路径,先建立文件夹---在文件夹中建立文件路径------存储开始
    
    NSDictionary *savaData = @{@"abc":@"class",@"des":@"money",@"aes":@"gogogo",@"face":@"abstract"};
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask ,YES)firstObject];
    NSString *directory = [path stringByAppendingPathComponent:@"ABC"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:directory]) {
        BOOL result = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            NSLog(@"创建文件夹成功");
        } else {
            NSLog(@"闯进文件夹失败");
        }
    }
    
    NSString *savaPath = [directory stringByAppendingPathComponent:@"saveData"];
    
    BOOL isSuccess = [savaData writeToFile:savaPath atomically:YES];
    if (isSuccess) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
    /*
     writeToFile: atomically:消息被发送给字典对象saveData,使字典以属性列表的形式写到文件saveData中,atomically参数设置为YES,表示希望首先将字典写入临时备份文件中,并且一旦成功,将把最终数据转移到名为saveData的指定文件中这是一种安全措施,他保护文件在一些情况下(如系统在执行操作的过程中崩溃时)免受破坏.在这种情况下,原始的saveData文件(如果该文件存在)不会受损害.
     说明:当根据字典创建属性列表时,字典中的键必须全是NSString对象.数组中的元素或者字典中的可以是NSString,NSArray,NSDictionary,NSData,NSDate或者NSNumber对象
     如要将文件中的XML属性列表读入你的程序,使用dictionaryWithContentsOfFileL或arrayWithContentsOfFile:方法.要读取数据,使用dataWithContentsOfFile:方法,要读取字符串对象,使用stringWithContentsOfFile:方法.
     */
    NSDictionary *readData = [NSDictionary dictionaryWithContentsOfFile:savaPath];
    for (NSString *key in readData.allKeys ) {
        NSLog(@"%@:%@",key,readData[key]);
    }
    
    for (NSString *key in readData) {
        NSLog(@"默认输出的是啥:%@:%@",key,readData[key]);
    }
    
    /* 使用NSKeyedArchiver 归档
     若将各种类型的额对象存储到文件中,而且不仅仅是字符串,数组和字典类型,有一种更灵活的方法就是利用NSKeyedArchiver类创建带键(keyed)的档案来完成.
     在带键的档案中,每个归档字段都有一个名称.归档某个对象时,会为它提供一个名称,即键.从归档中获取该对象时,是根据这个键来检索它的.这样,可以按照任意顺序
     将对象写入归档并进行检索.另外,如果向类中添加了新的实例变量或者删除了实例变量,程序也可以进行处理.

     */
    NSString *archiveDir = [path stringByAppendingPathComponent:@"Archive"];
    if (![fileManager fileExistsAtPath:archiveDir]) {
        [fileManager createDirectoryAtPath:archiveDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *archivePath = [archiveDir stringByAppendingPathComponent:@"test.archive"];
    BOOL result =  [NSKeyedArchiver archiveRootObject:savaData toFile:archivePath];
    if (result) {
        NSLog(@"归档成功了");
    } else {
        NSLog(@"归档失败了");
    }
    
    //将指定的文件打开并读取文件的内容,该文件必须是前面归档操作的结果.可以为文件指定完整路径名称或者对路径名;
    NSDictionary *data2 = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    for (NSString *key in data2) {
        NSLog(@"---%@---%@",key,data2[key]);
    }
    
    
    /* 编码方法和解码方法
     可以使用刚刚描述的方式归档和恢复NSString,NSArray,NSDictionary,NSSet,NSDate,NSNumber 和 NSData之类的基本Objecttive-C类对象,这还包括嵌套的对象,如包含字符串,甚至其他数组对象的数组.
     这意味着我们不能直接使用这种方法去归档AddressBook,因为OC系统不知道如何归档AddressBook对象.如果在程序中插入如下一行来尝试归档它:
     [NSKeyedArchiver archiveRootObject:AddressBook toFile:archivePath];
     这样就报错了;没有找到一个名为encodeWithCoder:的方法,但是你从未定义过这样的方法.
     
     要归档前面没有列出的对象,必须告知系统如何归档(或编码)你的对象,以及如何归解归档他们.这是按照<NSCoding>协议,在类定义中添加encodeWithCoder;方法和initWithCoder:方法实现的.对于本书地址簿的例子,必须向AddressBook类和AddressCard类添加这些方法.
     
     每次归档程序想要根据指定的类编码对象时,都将调用encodeWithCoder:方法,该方法告知归档程序如何归档.类似地,每次从指定的类解析码对象时都会用到initWithCoder:方法
     */
    
    AddressCard *card1 = [[AddressCard alloc]init];
    [card1 setName:@"李白" andEmail:@"123452@qq.com"];
    
    NSString *cardDir = [path stringByAppendingPathComponent:@"CardClass"];
    if (![fileManager fileExistsAtPath:cardDir]) {
        [fileManager createDirectoryAtPath:cardDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *cardPath = [cardDir stringByAppendingPathComponent:@"CardFile"];
    BOOL cardResult = [NSKeyedArchiver archiveRootObject:card1
                                                  toFile:cardPath];
    if (cardResult) {
        NSLog(@"cardClass归档成功");
    }
    
    AddressCard *newCard = [NSKeyedUnarchiver unarchiveObjectWithFile:cardPath];
    if (newCard) {
        NSLog(@"%@----%@",newCard.name,newCard.email);
    } else {
        NSLog(@"cardClass解档失败");
    }
    
    Foo *foo = [[Foo alloc]init];
    foo.strVal   = @"This is a Test";
    foo.intVal   = 1;
    foo.floatVal = 1.5;
    NSString *fooPath = [path stringByAppendingPathComponent:@"FooClass"];
    if (![fileManager fileExistsAtPath:fooPath]) {
        [fileManager createDirectoryAtPath:fooPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *fooSavePath = [fooPath stringByAppendingPathComponent:@"FooFile"];
    [NSKeyedArchiver archiveRootObject:foo toFile:fooSavePath];
    
    Foo *newFoo = [NSKeyedUnarchiver unarchiveObjectWithFile:fooSavePath];
    if (newFoo) {
        NSLog(@"FooClass unarchive success %@",newFoo.strVal);
    } else {
        NSLog(@"Foo class 解档失败");
    }
    
    /* 使用NSData 创建自定义档案
     NSData 对象可以用来保留一块内存空间,以备将来存储数据.这些数据空间的典型应用是为一些数据提供临时存储空间,以便随后写入文件,或者存放从磁盘读取的文件内容.创建可变数据空间的最简单方式是使用data方法:
     */
    
    NSMutableData   *dataArea = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:dataArea];
    
    //现在可以开始存储对象
    [archiver encodeObject:foo forKey:@"FooClass"];
    [archiver encodeObject:card1 forKey:@"CardClass"];
    [archiver finishEncoding];
    
    //将存档的数据区写到文件
    NSString *dataPath = [path stringByAppendingPathComponent:@"DataArea"];
    if (![fileManager fileExistsAtPath:dataPath]) {
        [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //[dataArea writeToFile:dataPath atomically:YES];
    //创立文件夹之后直接写入必定失败,要创立文件的路径才可写入
    NSString *dataEndPath = [dataPath stringByAppendingPathComponent:@"DataAreaData"];
    BOOL isSuccss = [dataArea writeToFile:dataEndPath atomically:YES];
    if (isSuccss) {
        NSLog(@"创建文件夹之后直接写入文件成功");
    } else {
        NSLog(@"创建文件夹后直接写入失败");
    }
    
    /* 归档
     分配一个 NSKeyedArchiver 对象之后.发送initForWritingWithMutableData: 消息,以指定要写入归档数据的存储空间.这就是去前面创建的dataArea 的空间.此时,就可以向存储在archiver中的 NSKeyedArchiver 对象发送编码消息,以归档该程序中的对象.实际上,所有的编码消息在收到finishEncoding 消息之前都被归档并存在指定的数据空间内.
     
     这里,有两个对象需要编码,一个是foo对象,一个是card1对象.对于这两个对象可以使用encodeObject: forKey:,因为在前面已经为这两个类实现了编码方法和解码方法(这个很重要,否则就是闪退).
     
     在归档这两个对象时,向archiver对象发送一条finishEncoding消息,之后,就不能编码其他对象,此时你需要发送此消息以完成归档过程.
     现在,你预留的那块名为dataArea的空间包含归档对象,这些对象能够以一种可写入文件的格式存在.消息表达式,
     [dataArea writeToFile:dataEndPath atomically:YES];
     向你的数据流发送writeToFile: atomically:消息,请求它把它的数据写入指定的文件,这个文件名为:DataAreaData
     */
    
    /* 解档
     从档案文件中恢复数据很简单:所做的工作只需和归档文件相反.首先,需要像以前那样分配一个数据空间.其次,把档案文件中的数据读入该数据空间.然后,需要创建一个
     NSKeyedUnarchiver 对象,并告知它从指定的空间解码数据.必须调用解码方法类提取和解码归档的对象,做完之后,向NSKeyedUnarchiver 对象发送一条finishDecoding消息.如下:
     */
    //这个获取要解档的数据时,要根据指定的路径进行操作
    NSMutableData *unarchiverData = [NSMutableData dataWithContentsOfFile:dataEndPath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:unarchiverData];
    AddressCard *unCard = [unarchiver decodeObjectForKey:@"CardClass"];
    Foo *unFoo          = [unarchiver decodeObjectForKey:@"FooClass"];
    [unarchiver finishDecoding];
    if (unCard || unFoo) {
        NSLog(@"解挡成功了%@",unFoo.strVal);
    } else {
        NSLog(@"解档失败了");
    }
}

//渐变色的学习
- (void)learnCAGradientLayer {
    //初始化imageView
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Imitate.bundle/online-back-ttfm"]];
    imageView.frame  = CGRectMake(0, [self getNavHeight], SCREENWIDTH, 200);
    [self.view addSubview:imageView];
    
    //初始化渐变层
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.gradientLayer];
    
    //设置渐变方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint   = CGPointMake(0, 1);
    
    //设定颜色组
    self.gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor purpleColor].CGColor,(id)[UIColor clearColor].CGColor];
    self.gradientLayer.locations = @[@0.1,@0.8,@01.0];
}

#pragma mark ----交换方法
// 交换方法
- (void)exchangeMethod {
    /*开发使用场景系统自带的方法功能不够,给系统自带的方法扩展一些功能,并且保持原有的功能.
     方式1:继承系统的类,重写方法.
     方式2:使用Runtime ,交换方法
     步骤1:先搞个分类,定义一个能加载图片并且能打印的方法+
     步骤2:交换imageNamed 和imageWithName的实现,就能调用imageWithName,间接调用imageWithName的实现
     详见 "UIImage+Image" 分类中
     
     
     
     
     */
}



//图片模糊效果的学习
- (void)appearBlurImageViewEffect {
    
    _blurImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, kScreen_Width, 200)];
    _blurImageView.backgroundColor = [UIColor colorWithWhite:0.790 alpha:1.000];
    [self.view addSubview:_blurImageView];
    
    _slider1 = [UISlider new];
    _slider1.frame  = CGRectMake(0, 0, kScreen_Width, 30);
    _slider1.minimumValue = 0;
    _slider1.maximumValue = 20;
    _slider1.value = 0;
    __weak typeof(self) _self = self;
    [self changed];
    [_slider1 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [_self changed];
    }];
    _slider1.top = _blurImageView.bottom + 35;
    [self.view addSubview:_slider1];
    

}

- (void)changed {
    NSString *name  = @"mew_baseline.png";
    NSData *data    = [NSData dataNamed:name];
    float progress  = 1;
    NSData *subData = [data subdataWithRange:NSMakeRange(0, data.length * progress)];
    NSLog(@"%f-----%f",progress,_slider1.value);
    YYImageDecoder *decoder = [[YYImageDecoder alloc] initWithScale:[UIScreen mainScreen].scale];
    [decoder updateData:subData final:NO];
    YYImageFrame *frame = [decoder frameAtIndex:0 decodeForDisplay:YES];
    
    UIImage *image = [frame.image imageByBlurRadius:_slider1.value tintColor:nil tintMode:0 saturation:1 maskImage:nil];
    
    _blurImageView.image = image;
}



- (void)dealloc {
    NSLog(@"%@被释放了",[self description]);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
