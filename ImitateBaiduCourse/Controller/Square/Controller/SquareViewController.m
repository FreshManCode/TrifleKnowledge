//
//  SquareViewController.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/21.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "SquareViewController.h"
#import <MJRefresh.h>
#import "NetworkManager.h"
#import <MJExtension.h>
#import "RecordHUD.h"
#import "D3RecordButton.h"
#import "ModalViewController.h"
#import "ResourceModelOne.h"
#import "AnimationViewController.h"
#import "TestViewController.h"
@interface SquareViewController () <D3RecordDelegate,ModalViewControllerDelegate,UITextFieldDelegate>
{
    AVAudioPlayer *_player;
    UIButton *_lastBtn;
    NSMutableArray *_selectedTagArray;
}
@property (nonatomic,strong) UITableView *squareTable;
@property (nonatomic,strong) UIButton *voiceBtn;

@property (nonatomic,strong) D3RecordButton *recordBtn;
@property (nonatomic,strong) UITextField * textFiledOne;
@property (nonatomic,strong) UITextField * textFiledTwo;
@property (nonatomic,copy)   NSString *warningString;
@property (nonatomic,copy)   NSString *accountString;
@property (nonatomic,copy)   NSString *passwordString;
@property (nonatomic,strong) UIButton * submitBtn;

@end

@implementation SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"广场";
//    [self setUpSubViews];
    
//    [self initRecordVoiceView];
    [self initReactiveCocoa];
   
}


- (void)initRecordVoiceView {
    _recordBtn = [[D3RecordButton alloc] initWithFrame:CGRectMake((SCREENWIDTH-90)/2.0, 200, 90, 40)];
    _recordBtn.backgroundColor = [UIColor redColor];
    [_recordBtn setTitle:@"按下即可录音" forState:UIControlStateNormal];
    [_recordBtn initRecord:self maxtime:20 title:@"上滑取消录音"];
    [_recordBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _recordBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:_recordBtn];
}

- (void)endRecord:(NSData *)voiceData {
    NSLog(@"-----%ld---录音的大小为:%.2f K",(long)voiceData.length,voiceData.length /1000.0);
    NSError *error;
    _player = [[AVAudioPlayer alloc]initWithData:voiceData error:&error];
    _player.volume = 1.0f;
    [_player play];
}

- (void)dragExit {
    [_recordBtn setTitle:@"长按即可录音" forState:UIControlStateNormal];
}


- (void)setUpSubViews {
    self.automaticallyAdjustsScrollViewInsets = NO;
//    NSString *urlString = @"http://api.meituan.com/group/v1/deal/topic/discount/city/10?__vhost=api.mobile.meituan.com&uuid=7BE81026363721F45E399C3CDFCCA02A39540A135395C11A2AF9369968B85A33&ci=10&latlng=31.133408%2C121.403969&utm_medium=iphone&utm_source=AppStore&rn_package_version=0&utm_campaign=AgroupBgroupGhomepage_category1_1__a1H0&version_name=7.0.1&__skck=3c0cf64e4b039997339ed8fec4cddf05&__skua=bdf85db445a5d880034a8017867d56b0&utm_content=7BE81026363721F45E399C3CDFCCA02A39540A135395C11A2AF9369968B85A33&__reqTraceID=C2910BAC-329A-405E-82DA-F4BFE9180A1C&__skts=1469168180.783149&__skno=C9C42EA8-856E-477B-969A-16AD8DDEE6AD&__skcy=5E57X4D7zTkzlRFY0wdSH9csNGA%3D&msid=BAD4C57D-2EC1-4754-BD3F-DAEA398660692016-07-22-14-05120&movieBundleVersion=100&client=iphone&utm_term=7.0.1";
//    if (!_squareTable) {
//        _squareTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENWIDTH-64) style:UITableViewStylePlain];
//        _squareTable.delegate   = self;
//        _squareTable.dataSource = self;
//        _squareTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    [self.view addSubview:_squareTable];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 80, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue   = [NSNumber numberWithInt:10];
    animation.toValue     = [NSNumber numberWithInt:100];
    animation.duration    = 1.5;
    animation.repeatCount = 5;
    animation.fillMode    = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"animateLayer"];
    
    _selectedTagArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *array = [NSArray arrayWithObjects:@"底部弹出动画",@"酒店工程",@"箱包手袋",@"餐椅",@"软包硬包",@"皮鞋",@"服装",@"地毯",@"汽车游艇", nil];
    NSInteger rowNum = array.count / 4 ==0 ? array.count / 4 :array.count /4 +1;
    CGFloat rowSpace  = 15;
    CGFloat btnHeight = 30;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, view.bottom +15, SCREENWIDTH, rowNum * (rowSpace + btnHeight))];
    [self.view addSubview:bgView];
    CGFloat offSetX = 10;
    CGFloat offSetY = 10;
    CGFloat btnWidth  = (SCREENWIDTH -5*offSetY)/4.0;
    for (int i= 0;i<array.count;i++) {
        CGFloat x = (offSetY +btnWidth)  * (i%4) + offSetY;
        CGFloat y = (offSetX +btnHeight) * (i/4) + offSetX;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnWidth, btnHeight)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        btn.tag = 10 +i;
        [btn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
    }
}
- (void)chooseBtn:(UIButton *)sender {
    [self hanldeWithChooseTag:sender.tag - 10];
    if (sender.selected) {
        sender.selected = NO;
        [_selectedTagArray removeObject:@(sender.tag)];
    } else {
        sender.selected = YES;
        [_selectedTagArray addObject:@(sender.tag)];
    }
    
    NSLog(@"%@",_selectedTagArray);
}

- (void)hanldeWithChooseTag:(NSInteger)tagIndex {
    AnimationViewController *animationVC = [[AnimationViewController alloc]init];
    animationVC.hidesBottomBarWhenPushed = YES;
    animationVC.type = tagIndex;
    [self.navigationController pushViewController:animationVC animated:YES];
}


- (void)initReactiveCocoa {
    /*
     RAC中最核心的类RACSignal
     RACSignal:信号类,一般表示将来有数据传递,只要有数据改变,信号内部接收到数据,就会马上发出数据
     注意:
     信号类(RACSignal),只是表示当数据改变时,信号内部会发出数据,它本身不具发送信号的能力,而是交给内部一个订阅者去发出.
     默认一个信号都是冷信号,也就是值改变了,也不会触发,只有订阅了这个信号,这个信号才会变为热信号,值改变了才会触发.
     如何订阅信号:调用信号RACSignal的subscribeNext就能订阅
     
     
     RACSignal使用步骤:
     1.创建信号  + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
     2.订阅信号,才会激活设备信号  - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
     3.发送信号 - (void)sendNext:(id)value
     
     RACSingal底层实现
     1.创建信号,首先把didSubcribe 保存到信号中,还不会触发
     2.当信号被订阅,也就是调用singal的subscribeNext:nextBlock
     2.2subscribeNext内部会创建订阅者subscribeer,并且把nextBlock保存到subscribe中
     2.1subscribeNext内部会调用[subscriber sendNext:@1];
     3.singal的didSubscribe中调用[subscriber sendNext:@1];
     3.1 sendNext 底层其实就是执行subscriber的nextBlock
     
     
     */
    
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //block 调用时刻:每当有订阅或者订阅信号,就会调用block
       //2.发送信号
        [subscriber sendNext:@1];
       //如果不在发送数据,最好发送信号完成,内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            //block 调用时刻:当信号发送完成或者发送错误,自会自动执行这个block,取消订阅信号.
            //执行完block后,当前信号就在被订阅了.
            NSLog(@"信号被销毁");
        }];
    }];
    //3.订阅信号,才会激活设备信号
    [signal subscribeNext:^(id x) {
       // block调用时刻:每当有信号发出数据,就会调用block
        NSLog(@"接收到的数据:%@",x);
    }];
    
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, SCREENWIDTH - 40, 20)];
    tipsLabel.text = @"Please Input";
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLabel];
    
    _textFiledOne = [[UITextField alloc]initWithFrame:CGRectMake(tipsLabel.left, tipsLabel.bottom + 30, SCREENWIDTH - 40, 30)];
    _textFiledOne.layer.cornerRadius = 5.0f;
    _textFiledOne.clipsToBounds = YES;
    _textFiledOne.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textFiledOne.layer.borderWidth = 1.0f;
    _textFiledOne.delegate = self;
    //实时监测textFiled输入文字的变化
    [_textFiledOne addTarget:self action:@selector(textFiledChanedL:) forControlEvents:UIControlEventEditingChanged];
    //使用这个可以对textField的文字更改做监听
    [[_textFiledOne rac_textSignal]subscribeNext:^(NSString * changeOne) {
        NSLog(@"changeOne%@:",changeOne);
    }];

    [self.view addSubview:_textFiledOne];
    
    _textFiledTwo = [[UITextField alloc]initWithFrame:CGRectMake(tipsLabel.left, _textFiledOne.bottom + 30, SCREENWIDTH - 40, 30)];
    _textFiledTwo.layer.cornerRadius = 5.0f;
    _textFiledTwo.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    _textFiledTwo.layer.borderWidth  = 1.0f;
    _textFiledTwo.clipsToBounds = YES;
    _textFiledTwo.delegate = self;
    [_textFiledTwo addTarget:self action:@selector(textFiledChanedL:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textFiledTwo];
    
    
    //由于没有设置button的背景图片,所以即使button不可点击的情况下颜色也不变
    _submitBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREENWIDTH - 50)/ 2.0, _textFiledTwo.bottom + 30, 50, 30)];
    [_submitBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x4E90BF"]] forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x4E90BF" andAlpha:0.5]] forState:UIControlStateDisabled];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    //RAC的使用,根据输入框是否均有文字的输入来使当前的按钮是不是可以点击
    //使用这个方法的时候一定要有返回值
    RAC(self,submitBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, accountString),RACObserve(self, passwordString)] reduce:^id(NSString *password,NSString *confirmPassword){
        return @((password && password.length >0)&& (confirmPassword && confirmPassword.length >0));
    }];
    
    
    /*
     6.2 RACSubscriber:表示订阅者的意思,用于发送信号,这是一个协议,不是一个类,只要遵守这个协议,并且实现方法才能成为订阅者.通过create创建的信号,都有一个订阅者,帮助他发送数据
     6.3 RACDisposable:用于取消订阅或者清理资源,当信号发送完成或者发送错误的时候,就会自动触发它.
     使用场景:不想监听某个信号时,可以通过它主动取消订阅信号
     6.4 RACSubject:RACSubject 信号提供者,自己可以充当信号,又能发送信号
     使用场景:通常同来代替代理,有了它,就不必要定义代理了
     RACReplaySubject:重复提供信号类,RACSubject的子类
     
     RACReplaySubject 与RACSubject 区
     RACReplaySubject 可以先发送信号,在订阅信号, RACSubject 就不可以
     使用场景一:如果一个信号每被订阅一次,就需要把它之前的值重复发送一遍,使用重复提供信号类
     使用场景二:如果可以设置capacity数量来限制缓存的value的数量,即只缓存最新的几个值
     
     */
    
    // RACSubject 和 RACReplayySubject简单使用:
    // RACSubject 使用步骤
    /*
     1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
     2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
     3.发送信号 sendNext:(id)value
     
     RACSubject:底层实现和RACSignal不一样。
     1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
     2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
     
     */
    
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //2.订阅信号
    [subject subscribeNext:^(id x) {
       //block 调用时刻:当信号发出新值,就会调用
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        //block 调用时刻:当信号发出新值,就会调用
        NSLog(@"第二个订阅者%@",x);
    }];
    
    //3. 发出信号
    [subject sendNext:@"1"];
    
     // RACReplaySubject使用步骤:
     // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
     // 2.可以先订阅信号，也可以先发送信号。
     // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
     // 2.2 发送信号 sendNext:(id)value
    
     // RACReplaySubject:底层实现和RACSubject不一样。
     // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
     // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
     // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
     // 也就是先保存值，在订阅值。
    
     // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    //  2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    //  3.发送信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    //  3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
    
    
    /*
     RACSubject 替代代理
     需求
     1. 给当前控制器添加一个按钮,modeal到另一个控制器界面
     2. 另一个控制器view中有个按钮,点击按钮,通知当前控制器
     
     步骤一:在第二个控制器.h,添加一个RACSubject代替代理
     步骤二:监控第二个控制器按钮点击
     步骤三:在第一个控制器中,监听跳转按钮,给第二个控制器的代理信号赋值,并且监听
     
     */
    
    
    UIButton *modalBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, _recordBtn.bottom +25, 60, 30)];
    [modalBtn setTitle:@"模态跳转" forState:UIControlStateNormal];
    modalBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [modalBtn addTarget:self action:@selector(modalToNextViewController:) forControlEvents:UIControlEventTouchUpInside];
    [modalBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:modalBtn];

}

- (void)submitEvent:(UIButton *)sender {
    TestViewController *testVC = [[TestViewController alloc]init];
    testVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testVC animated:YES];
}


//步骤三
- (void)modalToNextViewController:(UIButton *)sender {
    ModalViewController *modalVC = [[ModalViewController alloc]init];
    //设置代理信号
    modalVC.delegateSignal = [RACSubject subject];
    // 订阅代理信号
    [modalVC.delegateSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮:%@",x);
    }];
    
    modalVC.delegate = self;
    modalVC.clickBlock = ^(NSString *value) {
        NSLog(@"The block transed value is %@",value);
    };

    // 跳转到第二个控制器
    [self presentViewController:modalVC animated:NO completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark ---ModalViewControllerDelegate
- (NSString *)didTransValue:(NSString *)value {
    NSLog(@"the value transed by delegate is %@",value);
    return value;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _textFiledOne) {
        [_textFiledOne resignFirstResponder];
        [_textFiledTwo becomeFirstResponder];
        return NO;
    } else {
        [_textFiledTwo resignFirstResponder];
        return YES;
    }
}

- (void)textFiledChanedL:(UITextField *)textFiled {
    if (textFiled == _textFiledOne) {
        self.accountString  = textFiled.text;
    } else {
        self.passwordString = textFiled.text;
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
