//
//  InsertTableViewCell.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/7.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsertCollectionView.h"
#import "InsertCollectionViewCell.h"
static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";
@interface InsertTableViewCell : UITableViewCell
@property(nonatomic,strong) InsertCollectionView * collectionView;
- (void)setCollectionViewDataSourceAndDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
