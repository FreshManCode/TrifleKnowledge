
//
//  ContactsViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/24.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactsManager.h"
#import "YContactObject.h"

@interface ContactsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ContactsManager * contactManager;
@property (nonatomic,strong) NSArray <YContactObject *> *contactObjects;
@end

static NSString *const reuseIdentifier = @"RightCell";
@implementation ContactsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    [self setUpTableView];
    self.contactManager = [ContactsManager shareInstance];
    __weak typeof(self) weakSelf = self;
    //开始请求
    [self.contactManager requestContactsComplete:^(NSArray<YContactObject *> * contacts) {
        //赋值
        weakSelf.contactObjects = contacts;
        //刷新
        [weakSelf.tableView reloadData];
    }];
}

- (void)setUpTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getNavHeight], SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    YContactObject *contactObject = [self.contactObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = contactObject.nameObject.name;
    cell.detailTextLabel.text = contactObject.phoneObject.firstObject.phoneNumber;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
