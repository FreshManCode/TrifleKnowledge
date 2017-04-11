//
//  PlayViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/12.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PlayViewController.h"


@interface PlayViewController ()
@property (nonatomic,strong) UIButton *redView;
@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *pswText;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    /*
     1.代替代理
     需求：自定义redView,监听红色view中按钮点击
     之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
     rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
     这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
     */
    
    // 2.KVO
    // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
    // observer:可以传入nil
    [[_redView rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"11%@",x);
    }];
    
    // 3.监听事件
    // 把按钮点击事件转换为信号，点击按钮，就会发送信号
    
    /* 8.ReactiveCocoa常见宏。
     8.1 RAC(TARGET, [KEYPATH, [NIL_VALUE]]):用于给某个对象的某个属性绑定。
     //只要文本框文字改变,就会修改label的文字
      RAC(self.labelView,text) = _textField.rac_textSignal;
     
     8.2 RACObserve(self, name):监听某个对象的某个属性,返回的是信号。
     [RACObserve(self.view, center) subscribeNext:^(id x) {
     
     NSLog(@"%@",x);
     }];
     
     8.3  @weakify(Obj)和@strongify(Obj),一般两个都是配套使用,在主头文件(ReactiveCocoa.h)中并没有导入，需要自己手动导入，RACEXTScope.h才可以使用。但是每次导入都非常麻烦，只需要在主头文件自己导入就好了。
     
     8.4 RACTuplePack：把数据包装成RACTuple（元组类）
     // 把参数中的数据包装成元组
     RACTuple *tuple = RACTuplePack(@10,@20);
     
     8.5 RACTupleUnpack：把RACTuple（元组类）解包成对应的数据。
     
     // 把参数中的数据包装成元组
     RACTuple *tuple = RACTuplePack(@"xmg",@20);
     
     // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
     // name = @"xmg" age = @20
     RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
     
     */
    UIView *nameView = [self viewWithFrame:CGRectMake(0, 70, SCREENWIDTH, 40) leftTiele:@"用户名:" placeHolder:@"请输入账号" textFontSize:14.0f];
    [self.view addSubview:nameView];
    [nameView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            _nameText = obj;
        }
    }];
    
    UIView *pswView  = [self viewWithFrame:CGRectMake(0, nameView.bottom+30, SCREENWIDTH, 40) leftTiele:@"密  码:" placeHolder:@"输入密码" textFontSize:14.0f];
    [pswView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            _pswText = obj;
        }
    }];
    [self.view addSubview:pswView];
    
    _redView = [[UIButton alloc]initWithFrame:CGRectMake(10, pswView.bottom +60, SCREENWIDTH - 20, 100)];
    [_redView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_redView setTitle:@"点击我啊" forState:UIControlStateNormal];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    [[_redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"点击红色按钮啊");
    }];
    
   RAC(self, redView.enabled) = [RACSignal combineLatest:@[RACObserve(self, nameText.text),
                                                          RACObserve(self, pswText.text)] reduce:^id{
                                                              NSString *loginName;
                                                              NSString *password;
                                                              return @((loginName && loginName.length >0) &&(password && password.length >0));
   }];
    
    
}

- (UIView *)viewWithFrame:(CGRect)frame leftTiele:(NSString *)title placeHolder:(NSString *)placeHolder textFontSize:(CGFloat)fontSize  {
    UIView *bgView = [[UIView alloc]initWithFrame:frame];
    
    UILabel*leftLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, bgView.height)];
    leftLab.textColor = [UIColor blueColor];
    leftLab.textAlignment = NSTextAlignmentLeft;
    leftLab.text    = title;
    leftLab.font  = [UIFont systemFontOfSize:15.0f];
    [bgView addSubview:leftLab];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(leftLab.right+10, 0, bgView.width-100, bgView.height)];
    textField.placeholder  = placeHolder;
    textField.font         = [UIFont systemFontOfSize:fontSize];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.returnKeyType = UIReturnKeyGo;
    textField.layer.borderWidth = 1.0f;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [bgView addSubview:textField];
    return bgView;
}


- (void)btnClick:(UIButton *)sender {
    NSLog(@"这个能点击?");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
