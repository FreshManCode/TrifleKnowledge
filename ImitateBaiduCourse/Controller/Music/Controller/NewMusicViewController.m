 //
//  NewMusicViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "NewMusicViewController.h"
#import "NewMusicCollectionViewCell.h"
#import "NetworkManager.h"
#import <MJRefresh/MJRefresh.h>
#import "CustomRefreshHeader.h"
#import "NewMusicModel.h"
#import "BottomPlayView.h"
#import "PlayMusicViewController.h"
#import "NewMusicListViewController.h"

@interface NewMusicViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) BottomPlayView *bottomView;

@end

static NSString * musicIdentifier = @"NewMusicCollectionViewCell";
@implementation NewMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self setUpSubViews];
    [self requestData];
}
- (void)setUpSubViews {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREENWIDTH - 3*8 ) / 2.0, (SCREENWIDTH - 3*8) / 2.0 + 45);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 8, 0, 8);
    flowLayout.minimumInteritemSpacing = 8;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 50) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[NewMusicCollectionViewCell class] forCellWithReuseIdentifier:musicIdentifier];
    __weak typeof(self) weakSelf = self;
    _collectionView.mj_header = [CustomRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    [_collectionView.mj_header beginRefreshing];
    [self.view addSubview:_collectionView];
    _bottomView = [BottomPlayView shareBottomPlayView];
    _bottomView.TapPlayView = ^(NSMutableArray *dataArr, NSInteger curentIndex, NSString *pic_Url, AVPlayerItem *currentItem) {
        
    };
    [self.view addSubview:_bottomView];
    
}

- (void)requestData {
    __weak typeof (self) weakSelf = self;
    [NetworkManager getRequest:kNewCDController parameters:nil success:^(id responseObject) {
        [weakSelf endRefereshContent];
        for (NSDictionary * dict in responseObject[@"data"]) {
            NewMusicModel *model = [[NewMusicModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        [weakSelf endRefereshContent];
    }];
}

- (void)endRefereshContent {
    __weak typeof(self) weakSelf = self;
    if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewMusicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:musicIdentifier forIndexPath:indexPath];
    cell.musicModel = _dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NewMusicModel *model = _dataArray[indexPath.row];
    NewMusicListViewController *listVC = [[NewMusicListViewController alloc]init];
    listVC.msg_id = model.msg_id;
    listVC.navTitile = model.desc;
    [self.navigationController pushViewController:listVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
