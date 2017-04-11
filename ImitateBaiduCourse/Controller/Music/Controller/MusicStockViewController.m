//
//  MusicStockViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MusicStockViewController.h"
#import "MusicStockCollectionViewCell.h"
#import "NewMusicViewController.h"
@interface MusicStockViewController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray   *dataArray;

@end


@implementation MusicStockViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataArray];
    [self setUpSubViews];
    [self readMustcTypeData];
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}
- (void)setUpSubViews {
    self.titleLab.text  = @"音库";
    self.leftBtn.hidden = YES;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(SCREENWIDTH - 16, 180);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 8, 0, 5);
//    //列间距
//    flowLayout.minimumInteritemSpacing = 8;
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MusicStockCollectionViewCell class] forCellWithReuseIdentifier:@"MusicStockCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    [self.view addSubview:_collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicStockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MusicStockCollectionViewCell" forIndexPath:indexPath];
    MusicStockModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicStockModel *model = _dataArray[indexPath.row];
    if (indexPath.row == 0) {
        NewMusicViewController *newMusic = [[NewMusicViewController alloc]init];
        newMusic.titleLab.text =model.typeName;
        newMusic.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newMusic animated:YES];
    }
}

//读取数据
- (void)readMustcTypeData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"musicType" ofType:@"plist"];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in dataArr) {
        MusicStockModel *model = [MusicStockModel baseWithDictionary:dict];
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
