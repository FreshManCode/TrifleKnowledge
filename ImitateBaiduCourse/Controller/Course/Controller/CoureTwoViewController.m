//
//  CoureTwoViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/30.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "CoureTwoViewController.h"
#import "JSWave.h"
#import "ThreeViewController.h"
#import "TestModel.h"
#import "ContactsViewController.h"

@interface CoureTwoViewController ()
@property (nonatomic,strong) UIImageView *iconImage;
@property (nonatomic,strong) JSWave *headerView;
@end


@implementation CoureTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    self.titleLab.text = @"头像浪起来";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext:)];
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-30, 0, 60, 60)];
        _iconImage.layer.borderColor  = [UIColor whiteColor].CGColor;
        _iconImage.layer.borderWidth  = 2;
        _iconImage.layer.cornerRadius = 20;
    }
    
    if (!_headerView) {
        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 150)];
        _headerView.waveSpeed  = 1.50f;
        _headerView.waveHeight = 8.0f;
        _headerView.backgroundColor = XNColor(248, 64, 87, 1);
         __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            CGRect iconFrame = [weakSelf.iconImage frame];
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconImage.frame)+currentY-weakSelf.headerView.waveHeight;
            weakSelf.iconImage.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    [self.view addSubview:_headerView];
    [_headerView addSubview:_iconImage];
    
    TestModel *testModel = [[TestModel alloc] init];
    testModel ->name = @"小李";
    testModel ->age  = @"41";
    testModel ->address = @"北京";
    NSLog(@"testModel:\nname:%@---age:%@---address:%@",testModel->name,testModel->age,testModel->address);
    
    

    NSString *text1 = @"输入字符最多为15个输入字符最多为15个,输入字符最多为15个,输入字符最多为15个,输入字符最多为15个";
    NSString *text2 = @"Do you love your mother ?Yes !你爱你的妈妈?何以琛赵默萧";
    NSString *text3 = @"这仅仅是这个测试!Just a test";
    NSString *text4 = @"我\n和\n你\n心\n连\n心";
    CGSize sizeOne = [text1 getAttributionHeightWithLineSpace:8.0f font:[UIFont systemFontOfSize:13.0f] width:SCREENWIDTH -20];
    CGSize sizeTwo = [text2 getAttributionHeightWithLineSpace:8.0f font:[UIFont systemFontOfSize:13.0f] width:SCREENWIDTH -20];
    CGSize sizeThree = [text3 getAttributionHeightWithString:text3 lineSpace:8.0f font:[UIFont systemFontOfSize:13.0f] width:MAXFLOAT];
    CGSize sizeFour  = [text4 getAttributionHeightWithLineSpace:8.0f font:[UIFont systemFontOfSize:14.0f] width:SCREENWIDTH - 20];
    
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 64+150, SCREENWIDTH -20, sizeOne.height)];
    labelOne.backgroundColor = [UIColor greenColor];
    labelOne.text = text1;
    labelOne.textColor = [UIColor lightGrayColor];
    labelOne.font = [UIFont systemFontOfSize:13.0f];
    labelOne.numberOfLines = 0;
    [self.view addSubview:labelOne];
    
    UILabel *labelTwo = [[UILabel alloc]initWithFrame:CGRectMake(10, labelOne.bottom +20, SCREENWIDTH -20, sizeTwo.height)];
    labelTwo.backgroundColor = [UIColor greenColor];
    labelTwo.text = text2;
    labelTwo.textColor = [UIColor lightGrayColor];
    labelTwo.font = [UIFont systemFontOfSize:13.0f];
    labelTwo.numberOfLines = 0;
    [self.view addSubview:labelTwo];
    
    UILabel *labelThree = [[UILabel alloc]initWithFrame:CGRectMake(10, labelTwo.bottom +30, sizeThree.width, 13.0f)];
    labelThree.backgroundColor = [UIColor greenColor];
    labelThree.text = text3;
    labelThree.textColor = [UIColor lightGrayColor];
    labelThree.font = [UIFont systemFontOfSize:13.0f];
    labelThree.numberOfLines = 0;
    [self.view addSubview:labelThree];
    
    UILabel *labelFour = [[UILabel alloc]initWithFrame:CGRectMake(10, labelThree.bottom +30, sizeFour.width, sizeFour.height)];
    labelFour.backgroundColor = [UIColor greenColor];
    labelFour.text = text4;
    labelFour.textColor = [UIColor lightGrayColor];
    labelFour.font = [UIFont systemFontOfSize:14.0f];
    labelFour.numberOfLines = 0;
    [labelFour sizeToFit];
    [self.view addSubview:labelFour];
}

- (void)pushToNext:(UIBarButtonItem *)sender {
    ContactsViewController *contactsVC = [[ContactsViewController alloc]init];
    [self.navigationController pushViewController:contactsVC animated:YES];
//    [self.navigationController pushViewController:[ThreeViewController new] animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
