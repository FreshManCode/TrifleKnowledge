//
//  InsertOneImageTableViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/8.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "InsertOneImageTableViewCell.h"

@implementation InsertOneImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((kScreen_Width - 4 *2) / 3.0, 65);
        layout.minimumInteritemSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(8, 2, 0, 2);
        //滑动方向为竖直方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[InsertCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.scrollEnabled = NO;
        [self.collectionView registerClass:[InsertOneImageCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
        self.collectionView.backgroundColor = RGB(233, 233, 233);
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)setCollectionViewDataSourceAndDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate   = dataSourceDelegate;
    self.collectionView.indexPath  = indexPath;
    [self.collectionView reloadData];
}

@end
