//
//  LoopBannerView.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "LoopBannerView.h"
#import "LoopBannerViewCell.h"
#import <UIImageView+WebCache.h>
static NSString *identify = @"cellidentify";

@interface LoopBannerView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSTimer    *_timer;
    NSInteger  _totalImage;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UIPageControl    *pageControl;

@end


@implementation LoopBannerView

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate  imageArray:(NSArray *)imageArray{
    if (self = [super initWithFrame:frame]) {
        _delegate  = delegate;
        _loopImage = imageArray;
        [self configureContent];
        [_collectionView reloadData];
    }
    return self;
}

- (void)configureContent {
    _flowLayout= [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = self.frame.size;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (!_collectionView) {
        _collectionView= [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate    = self;
        _collectionView.dataSource  = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[LoopBannerViewCell class] forCellWithReuseIdentifier:identify];
    }
    [self addSubview:_collectionView];

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width - 100)/2, self.frame.size.height - 30, 100, 20)];
        _pageControl.numberOfPages = _loopImage.count;
     }
    [self addSubview:_pageControl];
    
    _totalImage = _loopImage.count * 10;
    if (_loopImage.count != 1) {
        [self setUpTimer];
    }
    
}

- (void)setUpTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(imageCycle:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)imageCycle:(NSTimer *)timer {
    int currentIndex = [self currentIndex];
    int targetIndex  = currentIndex +1 ;
    if (targetIndex >= _totalImage) {
        targetIndex  = _totalImage * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        return;
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (int)currentIndex {
    if (_collectionView.frame.size.width ==0) {
        return 0;
    }
    int index = 0;
    index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5)/_flowLayout.itemSize.width;
    return index;
}
- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}


#pragma mark UICollectionViewDataSourece
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalImage;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LoopBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    long index = indexPath.item % _loopImage.count;
    if (![_loopImage[index] hasPrefix:@"http"]) {
        cell.imageView.image = [UIImage imageNamed:_loopImage[index]];
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_loopImage[index]] placeholderImage:nil];
    return cell;
    
}

#pragma mark UICollectionViewDelegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickLoopBannerViewItemIndex:)]) {
        [_delegate didClickLoopBannerViewItemIndex:(int)indexPath.item % _loopImage.count];
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = [self currentIndex];
    _pageControl.currentPage = index % _loopImage.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


@end
