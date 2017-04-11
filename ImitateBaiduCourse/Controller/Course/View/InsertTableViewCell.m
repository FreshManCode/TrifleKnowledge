//
//  InsertTableViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/7.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "InsertTableViewCell.h"
#import "InsertCollectionViewCell.h"

@implementation InsertTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((kScreen_Width - 3 *8) / 2.0, (kScreen_Width - 3 *8) / 2.0 + (10 + 15) *2 +10);
        layout.minimumInteritemSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 0, 8);
        //滑动方向为竖直方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[InsertCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.scrollEnabled = NO;
        [self.collectionView registerClass:[InsertCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
        self.collectionView.backgroundColor = RGB(233, 233, 233);
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
}

- (void)setCollectionViewDataSourceAndDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate   = dataSourceDelegate;
    self.collectionView.indexPath  = indexPath;
//    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    [self.collectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
