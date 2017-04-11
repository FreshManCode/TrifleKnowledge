//
//  NewMusicListViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NewMusicListViewController.h"
#import "NewMusicListHeaderCell.h"
#import "NewMusicListBodyCell.h"
#import "NetworkManager.h"
#import "MusicModel.h"
#import "API.h"
#import "BottomPlayView.h"
@interface NewMusicListViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSInteger pIndex;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSDictionary *userDict;


@end

@implementation NewMusicListViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BottomPlayView *bpv = [BottomPlayView shareBottomPlayView];
    [self.view addSubview:bpv];
    [self.view  bringSubviewToFront:bpv];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = self.navTitile;
    pIndex = -1; //处理row = 0的情况
    self.dataSourceArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self setUpSubViews];
    [self requestMusicListData];
}

- (void)setUpSubViews {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 50)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];
}

#pragma mark --------数据类
- (void)requestMusicListData {
    __weak typeof(self) weakSelf = self;
    //来自排行
    if ([self.from isEqualToString:@"weekMusic"]) {
        [self requestDataFrom:[NSString stringWithFormat:kMusicListControllerWeekMusic, self.msg_id]];
    } else if ([self.from isEqualToString:@"singerMusic"]) {
        [self requestDataFrom:[NSString stringWithFormat:kMusicListControllerSingerMusic,self.msg_id]];
    } else if ([self.from isEqualToString:@"songType"]) {
        [self requestDataFrom:[NSString stringWithFormat:kMusicListControllerSongType, self.msg_id]];
    } else {
        //请求歌曲列表信息
        [NetworkManager getRequest:[NSString stringWithFormat:kMusicListControllerOther, self.msg_id] parameters:nil success:^(id responseObject) {
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"songs"]) {
                //存放用户信息
                self.userDict = [NSMutableDictionary dictionaryWithDictionary:dict[@"user"]];
                [weakSelf.userDict setValue:dict[@"pics"] forKey:@"pics"];
                for (NSDictionary *dict1 in dict[@"songlist"]) {
                    [tempArr addObject:dict1[@"_id"]];
                }
                MusicModel *model = [MusicModel new];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.dataSourceArr addObject:model];
            }
            [weakSelf.tableView reloadData];

        } failure:^(NSError *error) {
            
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ==0 ? 1 : _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath. section ==0) {
        NewMusicListHeaderCell *cell = [NewMusicListHeaderCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.userDict = self.userDict;
        return cell;
    } else {
        MusicModel *model = _dataSourceArr[indexPath.row];
        NewMusicListBodyCell *cell = [NewMusicListBodyCell cellWithTableView:tableView];
        cell.lblSongName.text = [NSString stringWithFormat:@"%d. %@", (int)indexPath.row + 1, model.song_name];
        cell.model = model;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 180 : 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section ==1 ? 50 : 0;
}



- (void)requestDataFrom:(NSString *)fromURL {
    __weak typeof(self) weakSelf = self;
    [NetworkManager getRequest:fromURL parameters:nil success:^(id responseObject) {
        for (NSDictionary *dict in responseObject[@"data"]) {
            MusicModel *model = [MusicModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.dataSourceArr addObject:model];
        }
        weakSelf.userDict = [NSMutableDictionary dictionaryWithObjects:@[@[self.pic_url], self.navTitile, [NSString stringWithFormat:@"共%ld首歌", (unsigned long)_dataSourceArr.count]] forKeys:@[@"pics", @"nick_name", @"label"]];
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



@end
