//
//  YWEffectiveOCViewContoller.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/4/5.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWEffectiveOCViewContoller.h"
#import "YWEffectiveOCFirstSectionOne.h"

@interface YWEffectiveOCViewContoller () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UITableView * contentView;

@end

@implementation YWEffectiveOCViewContoller
static NSString *indentifier = @"YWEffectiveOCViewContoller";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    _dataArray = [NSMutableArray array];
    NSArray *dataArray = [NSArray arrayWithObjects:
                          @{@"className":@"YWEffectiveOCFirstSection", @"title":@"Effective-OC第一章"},
                          @{@"className":@"YWEffectiveOCSecondSection",@"title":@"Effective-OC第二章"},
                          @{@"className":@"YWEffectiveOCThirdSection", @"title":@"Effective-OC第三章"},
                          @{@"className":@"YWEffectiveOCFourthSection",@"title":@"Effective-OC第四章"},
                          @{@"className":@"YWEffectiveOCFifthSection", @"title":@"Effective-OC第五章"},nil];
    [_dataArray addObjectsFromArray:dataArray];
    _contentView     = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHeight], SCREENWIDTH, SCREENHEIGHT - [self getNavHeight]) style:UITableViewStyleGrouped];
    _contentView.delegate   = self;
    _contentView.dataSource = self;
    [_contentView registerClass:[UITableViewCell class] forCellReuseIdentifier:indentifier];
    [self.view addSubview:_contentView];
    [_contentView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.textLabel.text   = [_dataArray[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDic = _dataArray[indexPath.row];
    NSString * className  = [dataDic objectForKey:@"className"];
    Class  class = NSClassFromString(className);
    if (class) {
        BaseViewController *vc = class.new;
        vc.titleLab.text = dataDic[@"title"];
        [self.navigationController pushViewController:vc animated:YES];
        //用 extern NSString *const YWStringNotification;修饰的
        NSLog(@"该类中的一个常量是:%@",YWStringNotification);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
