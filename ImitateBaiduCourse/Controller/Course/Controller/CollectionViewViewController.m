//
//  CollectionViewViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/30.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "CollectionViewViewController.h"
#import "CollectionViewCell.h"
#import "HeadView.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "NetworkManager.h"
#import "MainAdverseModel.h"
#import "EightButtonCollectionViewCell.h"
#import "TestTagView.h"
#import "MerchantImageCell.h"
#import <MJRefresh.h>
#import "CustomRefreshHeader.h"
#import "ActionSheetView.h"
#import "NSObject+AlertView.h"

@interface CollectionViewViewController ()
<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,SGFocusImageFrameDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIScrollView *adsScrollView;
@property (nonatomic,strong) SGFocusImageFrame * bannerView;
@property (nonatomic,strong) NSMutableArray * bannerArray;
@property (nonatomic,strong) NSArray * eightButtonArray;
@property (nonatomic,strong) NSMutableArray * popGoodsArray;
@property (nonatomic,strong) NSMutableArray * merchantsArray;

@end

@implementation CollectionViewViewController

static NSString * cellIdentifier        = @"CollectionViewCell.h";

static NSString * headViewIdentifier    = @"headViewIdentifier";

static NSString * headViewIdentifierTwo = @"headViewIdentifierTwo";

static NSString * footerViewIdentifier  = @"footerViewIdentifier";

static NSString * eightButtonEightButtonIdentifier = @"EightButtonCollectionViewCell";

static NSString * merchantsIdentifier   = @"merchantsIdentifier";


- (void)viewDidLoad {
    [super viewDidLoad];
    _eightButtonArray = [NSArray arrayWithObjects:@"btnIcon_0",@"btnIcon_1",@"btnIcon_2",@"btnIcon_3",@"btnIcon_4",@"btnIcon_5",@"btnIcon_5",@"btnIcon_5", nil];
    self.title = @"HeadView随着collectionView滚动";
    [self setUpSubViews];

}

- (UIScrollView *)adsScrollView {
    if (!_adsScrollView) {
        _adsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
        _adsScrollView.contentSize     = CGSizeMake(SCREENWIDTH * 4, 100);
        _adsScrollView.backgroundColor = [UIColor greenColor];
        _adsScrollView.delegate = self;
    }
    return _adsScrollView;
}

- (void)setUpSubViews {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.footerReferenceSize = CGSizeMake(SCREENWIDTH, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 ) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = RGB(238, 238, 238);
//    _collectionView.backgroundColor = [UIColor redColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_collectionView registerClass:[EightButtonCollectionViewCell class] forCellWithReuseIdentifier:eightButtonEightButtonIdentifier];
    [_collectionView registerClass:[MerchantImageCell class] forCellWithReuseIdentifier:merchantsIdentifier];
    [_collectionView registerClass:[HeadView
                                    class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifier];
    [_collectionView registerClass:[HeadView
                                    class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifierTwo];
    [_collectionView registerClass:[HeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewIdentifier];
    [self.view addSubview:_collectionView];
    __weak typeof(self) weakSelf = self;
    _collectionView.mj_header = [CustomRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestBannerView];
    }];
    
    CGRect bannerViewFrame = CGRectMake(0, 0, SCREENWIDTH, 150);
    NSDictionary *imageItemElement = @{@"image": @"main_banner_default_img",@"dataIndex":@"-1"};
    SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:imageItemElement
                                                                tag:-1];
    _bannerView = [[SGFocusImageFrame alloc]initWithFrame:bannerViewFrame delegate:self imageItems:@[item] isAuto:YES];
    [self requestBannerView];
}

- (void)requestBannerView {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *tempBanner = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *tempGoods  = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *tempMercha = [NSMutableArray arrayWithCapacity:0];
    [[NetworkManager shareManager]requestBannerViewResponseSuccess:^(NSDictionary *response) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_header endRefreshing ];
        });
        if (response[@"banner"]) {
            NSString *host = response[@"host"];
            for (NSDictionary *tempDic in response[@"banner"]) {
                MainAdverseModel *adverseModel = [[MainAdverseModel alloc]initWithDictionary:tempDic withHost:host];
                [tempBanner addObject:adverseModel];
            }
            weakSelf.bannerArray = [[NSMutableArray alloc]initWithArray:tempBanner];
        }
        [weakSelf reloadFoucsView:weakSelf.bannerArray];
        if (response[@"recommend_goods"]) {
            [response[@"recommend_goods"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                MainGoodsModel *goodModel = [[MainGoodsModel alloc]initWithDicionary:obj];
//                [tempGoods addObject:goodModel];
                //使用的key和json中的key不一致时
                MainGoodsModel *goodsModel = [MainGoodsModel mj_objectWithKeyValues:obj];
                [tempGoods addObject:goodsModel];
            }];
        }
        weakSelf.popGoodsArray = [[NSMutableArray alloc]initWithArray:tempGoods];
        if (response[@"recommend_merchants"]) {
            [response[@"recommend_merchants"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                MainMerchantsModel *merchantModel = [[MainMerchantsModel alloc]initWithDicionary:obj];
                MainMerchantsModel *merchantModel = [MainMerchantsModel mj_objectWithKeyValues:obj];
                [tempMercha addObject:merchantModel];
            }];
        }
         weakSelf.merchantsArray = [[NSMutableArray alloc]initWithArray:tempMercha];
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing ];
    }];
}

- (void)reloadFoucsView:(NSArray *)foucsArray {
    if (foucsArray.count <1) {
        return;
    }
    NSInteger length = foucsArray.count;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0;i<foucsArray.count;i++) {
        MainAdverseModel *mainModel = foucsArray[i];
        NSDictionary *paramsDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   mainModel.adActionUrl,@"url",
                                   mainModel.adImageUrl,@"image",
                                   [NSString stringWithFormat:@"%d",i],@"dataIndex",
                                   mainModel.adId,@"tagName", nil];
        [tempArray addObject:paramsDic];
    }
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length + 2];
    //添加最后一张图,用于循环
    if (length > 1) {
        NSDictionary *dict = tempArray[length - 1];
        SGFocusImageItem *item = [[SGFocusImageItem alloc]initWithDict:dict tag:-1];
        [itemArray addObject:item];
    }
    for (int i =0;i<length;i++ ) {
        NSDictionary *dict = tempArray[i];
        SGFocusImageItem *item = [[SGFocusImageItem alloc]initWithDict:dict tag:i];
        [itemArray addObject:item];
    }
    //添加第一张图
    if (length >1) {
        NSDictionary *dict = tempArray[0];
        SGFocusImageItem *item = [[SGFocusImageItem alloc]initWithDict:dict tag:length];
        [itemArray addObject:item];
    }
    [self.bannerView changeImageViewsContent:itemArray];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    } else if (section == 1) {
        return self.popGoodsArray.count;
    } else {
        return self.merchantsArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EightButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:eightButtonEightButtonIdentifier forIndexPath:indexPath];
        cell.imageName = self.eightButtonArray[indexPath.row];
         __weak typeof (self) weakSelf = self;
        cell.DidSelectedItem = ^ (NSInteger itemTag) {
            [weakSelf clickDifferentTag:indexPath.row];
        };
        
        return cell;
    } else if (indexPath.section == 1) {
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.goodsModel = self.popGoodsArray[indexPath.row];
        return cell;
    } else {
        MerchantImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:merchantsIdentifier forIndexPath:indexPath];
        cell.merchantsModel     = self.merchantsArray[indexPath.row];
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 2 || section == 0) {
        return UIEdgeInsetsZero;
    } else {
        return UIEdgeInsetsMake(8, 8, 0, 8);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifier forIndexPath:indexPath];
            reusableview = headerView;
            [headerView addSubview:_bannerView];
            
        } else if (indexPath.section == 1) {
            UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifierTwo forIndexPath:indexPath];
            reusableview = headView;
            TestTagView *bgView = [[TestTagView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55) leftIconName:nil title:@"流行趋势"];
            [headView addSubview:bgView];
        } else if (indexPath.section == 2) {
            UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifierTwo forIndexPath:indexPath];
            reusableview = headView;
            TestTagView *bgView = [[TestTagView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55) leftIconName:nil title:@"优质商家"];
            [headView addSubview:bgView];
        }
    }else {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerViewIdentifier forIndexPath:indexPath];
        headView.backgroundColor = RGB(238, 238, 238);
        reusableview = headView;
    }
    return reusableview;
}

//每个item之间的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 2 || section == 0) {
        return 0;
    } else {
        return 8;
    }
}
//每个item之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section ==1) {
        return 8;
    } else {
        return 0;  
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREENWIDTH, 150);
    } else if (section == 1) {
        return CGSizeMake(SCREENWIDTH, 40);
    } else {
        return CGSizeMake(SCREENWIDTH, 40);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(SCREENWIDTH / 4.0, SCREENWIDTH / 4.0 + 35);
    } else if (indexPath.section ==1) {
        return CGSizeMake((SCREENWIDTH - 4 * 8)/3.0, (SCREENWIDTH - 4 * 8)/3.0 + 55);
    } else {
        return CGSizeMake((SCREENWIDTH /3.0), 55);
    }
}

//对于封装弹窗的测试
- (void)clickDifferentTag:(NSInteger)tag {
    if (tag < 4) {
        ActionSheetView *actionSheet = [[ActionSheetView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150)];
        __weak typeof(actionSheet) weakAction = actionSheet;
        NSArray *titlesArray   = @[@"测试",@"侧事故",@"呵呵",@"取消"];
        actionSheet.titleArray = titlesArray;
        actionSheet.actionSheetViewBlock = ^ (NSInteger selectedTag) {
            NSLog(@"我选择的是%ld个标题是:%@",(long)selectedTag,titlesArray[selectedTag]);
            [weakAction dismissView];
        };
        [actionSheet showView];
    } else {
        [self showAlertTitle:@"Test" message:@"hello" okTitle:@"OK" cancelTitle:@"Cancel" okAction:^{
            NSLog(@"I have pressed OK button");
        } cancelAction:^{
            NSLog(@"I have pressed Cancal button");
        } completion:^{
            NSLog(@"This is completed event");
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
