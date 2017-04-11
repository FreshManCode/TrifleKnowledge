//
//  TestViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/11.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "TestViewController.h"
#import "TestTableViewCell.h"
#import "TestClickModel.h"

@interface TestViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) CGFloat currentHeight;
@property (nonatomic,strong) NSIndexPath * selectedIndex;
@property (nonatomic,assign) BOOL  isOpen;

@end

@implementation TestViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可以展开或者关闭";
    [self setUpSubViews];
}

- (void)setUpSubViews {
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHeight], SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor lightGrayColor];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    [self.view addSubview:_tableView];
    
    for (int i=0; i<20; i++) {
        TestClickModel *model = [[TestClickModel alloc]init];
        model.title = [NSString stringWithFormat:@"标题大仙:%d",i];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.selectedIndex.row && self.selectedIndex) {
        if (self.isOpen) {
            return 200;
        } else {
            return 44;
        }
    } else {
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [TestTableViewCell cellWithTableView:tableView];
    __weak typeof(self) weakSelf = self;
    cell.OpenViewClick = ^ (UIButton *sender){
        [weakSelf changeTableViewHeightWithButton:sender];
    };
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)changeTableViewHeightWithButton:(UIButton *)button {
    TestTableViewCell *cell = (TestTableViewCell *)button.superview;
    if (cell) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        if (self.selectedIndex && indexPath.row == self.selectedIndex.row) {
            self.isOpen = !self.isOpen;
            button.selected = !button.selected;
        } else if (self.selectedIndex && self.selectedIndex.row != indexPath.row) {
            indexPaths = [NSArray arrayWithObjects:indexPath,self.selectedIndex, nil];
            self.isOpen = YES;
            button.selected = YES;
            [button setTitle:@"关闭" forState:UIControlStateSelected];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        }
        self.selectedIndex = indexPath;
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [[FileManager shareManager]writeToFileWithFileName:@"我家的"];
    [self getTwoNumbersNonnegativeIntegers];
    
}

//获取两个数之间的最大公约数
- (void)getTwoNumbersNonnegativeIntegers {
    int u = 150,v  =20;
    while (v!= 0) {
        int temp = u % v;
        u = v;
        v = temp;
    }
    NSLog(@"%d-----%d",u,(150 %20));
}

int getTwoNumbersNonnegaticeIntegers (int a , int b) {
    int u = a,v  =b;
    while (v!= 0) {
        int temp = u % v;
        u = v;
        v = temp;
    }
    return u;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
