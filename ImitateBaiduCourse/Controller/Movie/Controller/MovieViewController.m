//
//  MovieViewController.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/21.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MovieViewController.h"
#import "CALayer+Add.h"
#import "DrawView.h"
#import "BackGroungView.h"
#import "LoopView.h"
#import "DisplayJSAndOCViewController.h"
#import "PaintingViewController.h"
@interface MovieViewController ()
{
    NSInteger _totalSize;
    NSInteger _currentSize;
}
@property (nonatomic,strong) CAShapeLayer *progressLayer;
//可以动态的模拟加载进度条
@property (nonatomic,strong) BackGroungView *bgView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
//动态的画圆
@property (nonatomic,strong) LoopView *loopView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影专辑";
    _totalSize  =30;
    _currentSize = 1;
    [self setUpUIBezierPath];
    [self setUpLoopPath];
    [self sortOrderWithKeys];
    [self setUpSubViews];
    // Do any additional setup after loading the view.
}

- (void)setUpSubViews {
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"去和JS交互" style:UIBarButtonItemStylePlain target:self action:@selector(toNextViewController:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"去涂鸦" style:UIBarButtonItemStylePlain target:self action:@selector(goPainting)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}


- (void)sortOrderWithKeys {
   NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"test",@"some",@"小明",@"order",@"67373",@"monety",@"10",@"罗红",@"xiaowng", nil];
   NSArray *array= [testDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
   NSArray *valueArray = [testDic.allValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       return [obj1 compare:obj2];
   }];
    NSLog(@"---%@-----%@",array,valueArray);
    
    NSMutableArray *arcArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *orderArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0;i <10;i++ ) {
        int x = arc4random() %50;
        [arcArray addObject:@(x)];
    }
    
    for (int i=0;i<10;i++) {
        for (int j =i;j<10;j++) {
            if ([arcArray[i] integerValue] > [arcArray[j] integerValue]) {
                arcArray[i] = arcArray[j];
            }
        }
        [orderArray addObject:arcArray[i]];
    }
    NSLog(@"***%@",orderArray);
}
- (void)goPainting {
    PaintingViewController *paintVC  = [[PaintingViewController alloc]init];
    paintVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:paintVC animated:YES];
}



- (void)toNextViewController:(UIBarButtonItem *)sender {
    DisplayJSAndOCViewController *jsAndOC = [[DisplayJSAndOCViewController alloc]init];
    jsAndOC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jsAndOC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [self addTimer];
}
- (void)viewWillDisappear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
    [self removeTimer];
}

- (void)addTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(progressiveEffect:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer fire];
    }
}

-(void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUIBezierPath {
    _bgView = [[BackGroungView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 150)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    DrawView *drawView = [[DrawView alloc]initWithFrame:CGRectMake(0, _bgView.bottom+120, SCREENWIDTH, 200)];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    
}

- (void)setUpLoopPath {
    _loopView = [[LoopView alloc]initWithFrame:CGRectMake(0, _bgView.bottom +10, SCREENWIDTH, 100)];
    _loopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loopView];
}

- (void)progressiveEffect:(NSTimer *)timer {
    CGFloat proressView = (CGFloat)_currentSize / _totalSize;
    if (_bgView.progressLayer.hidden) {
        _bgView.progressLayer.hidden = NO;
        _loopView.shapeLayer.hidden  = NO;
        _bgView.singleLayer.hidden   = NO;
    }
    _bgView.progressLayer.strokeEnd = proressView;
    _loopView.shapeLayer.strokeEnd  = proressView*2;
    _bgView.singleLayer.strokeEnd   = proressView;
    _currentSize ++;
    if (_currentSize >_totalSize) {
        _currentSize = 1;
    }
}

@end
