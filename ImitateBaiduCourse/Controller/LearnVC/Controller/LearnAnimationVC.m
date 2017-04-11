//
//  LearnAnimationVC.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/2/7.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "LearnAnimationVC.h"

@interface LearnAnimationVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UITableView * contentView;
@property (nonatomic,strong) NSArray * sectionTitleArr;

@end

@implementation LearnAnimationVC

static NSString * indentifier = @"UITableViewCellIdentifier";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"动画学习";
    NSArray *dataArray = @[@[
                           @{@"clsName":@"YWBasicAnimController",@"title":@"CABasicAnimation基础动画"},
                           @{@"clsName":@"YWKeyframeAnimController",@"title":@"CAKeyframeAnimation基础动画"},
                           @{@"clsName":@"YWDrawLineController",@"title":@"画线动画、线条递增、递减动画"},
                           @{@"clsName":@"YWTransitionViewController",@"title":@"CATransition转场动画"},
                           @{@"clsName":@"YWSpringAnimViewController",@"title":@"CASpringAnimation弹簧动画"},
                           @{@"clsName":@"YWEffectiveOCViewContoller",@"title":@"Effectice - OC学习"}],
                          @[@{@"clsName":@"YWDrawLineController",@"title":@"画线动画"},
                           @{@"clsName":@"YWWaterWaveController",@"title":@"水波纹效果"},
                           @{@"clsName":@"YWFireAnimController",@"title":@"粒子动画-火苗效果"},
                           @{@"clsName":@"YWMenuViewController",@"title":@"菜单弹出动画"},
                           @{@"clsName":@"YWRegularViewController",@"title":@"正则表达式使用"},
                           @{@"clsName":@"YWRuntimeViewController",@"title":@"Runtime学习使用"},
                           @{@"clsName":@"LearnMutilTaskViewController",@"title":@"多线程与内存管理学习"},
                           @{@"clsName":@"YWBlocksKitViewController",@"title":@"BlocksKit学习"},
                           ]];
    _dataArray       = [NSMutableArray arrayWithArray:dataArray];
    _sectionTitleArr = [NSArray arrayWithObjects:@"动画基础示例",@"动画常见经典案例", nil];
    _contentView     = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHeight], SCREENWIDTH, SCREENHEIGHT - [self getNavHeight]) style:UITableViewStyleGrouped];
    _contentView.delegate   = self;
    _contentView.dataSource = self;
    [_contentView registerClass:[UITableViewCell class] forCellReuseIdentifier:indentifier];
    [self.view addSubview:_contentView];
    [_contentView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tempArray = _dataArray[section];
    return tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    NSArray *tempArray = _dataArray[indexPath.section];
    NSDictionary *dataDic = tempArray[indexPath.row];
    cell.textLabel.text   = dataDic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *tmepArray = _dataArray[indexPath.section];
    NSDictionary *dataDic = tmepArray[indexPath.row];
    Class class = NSClassFromString(dataDic[@"clsName"]);
    if (class) {
        BaseViewController *controller = class.new;
        controller.titleLab.text = dataDic[@"title"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitleArr[section];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
