//
//  SGFocusImageFrame.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"
#import "SMPageControl.h"

@interface SGFocusImageFrame () {
    UIScrollView *_scrollView;
    SMPageControl *_pageControl;
}

- (void)setupViews;
- (void)switchFocusImageItems;
@end

static NSString *SG_FOCUS_ITEM_ASS_KEY = @"loopScrollview";

static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 5.0; //switch interval time

@implementation SGFocusImageFrame

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(SGFocusImageItem *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imageItems = [NSMutableArray array];
        SGFocusImageItem *eachItem;
        va_list argumentList;
        if (firstItem)
        {
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);
            while((eachItem = va_arg(argumentList, SGFocusImageItem *)))
            {
                [imageItems addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        objc_setAssociatedObject(self, (__bridge const void *)SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = YES;
        [self setupViews];
        
        [self setDelegate:delegate];
    }
    return self;
}
//2016.8.5 修改图片适应问题
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto contentMode:(UIViewContentMode )contentMode {
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = isAuto;
        [self setUpContentModeViewsWithContentMode:contentMode];
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSMutableArray *imageItems = [NSMutableArray arrayWithArray:items];
        objc_setAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _isAutoPlay = isAuto;
        [self setupViews];
        [self setDelegate:delegate];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items
{
    return [self initWithFrame:frame delegate:delegate imageItems:items isAuto:YES];
}

#pragma mark - private methods
//2016.8.5 修改图片适应问题
- (void)setUpContentModeViewsWithContentMode:(UIViewContentMode)mode {
    NSArray *imageItems = objc_getAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    _pageControl = [[SMPageControl alloc] init];
    _pageControl.y = self.frame.size.height - 13;
    if (_isAutoPlay) {
        _pageControl.size = CGSizeMake(100, 5);
        if (kDevice_Is_iPhone6) {
            _pageControl.x = 290;
        }else if (kDevice_Is_iPhone6Plus){
            _pageControl.x = 330;
        }else{
            _pageControl.x = 230;
        }
    }else {
        _pageControl.size = CGSizeMake(kScreen_Width, 5);
        _pageControl.centerX = kScreen_Width /2;
    }
    _pageControl.currentPageIndicatorTintColor = kColorNavBg;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.indicatorMargin = 4;
    [_pageControl rectForPageIndicator:5];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];
    
    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addImageViews:imageItems contentMode:mode];
}

- (void)setupViews
{
    NSArray *imageItems = objc_getAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY);
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.scrollsToTop = NO;
    _pageControl = [[SMPageControl alloc] init];
    _pageControl.y = self.frame.size.height - 13;
    
    if (_isAutoPlay) {
        _pageControl.size = CGSizeMake(100, 5);
        
        if (kDevice_Is_iPhone6) {
            
            _pageControl.x = 290;
            
        }else if (kDevice_Is_iPhone6Plus){
            
            _pageControl.x = 330;
            
        }else{
            _pageControl.x = 230;
        }
    }else {
        _pageControl.size = CGSizeMake(kScreen_Width, 5);
        _pageControl.centerX = kScreen_Width /2;
    }

    _pageControl.currentPageIndicatorTintColor = kColorNavBg;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.indicatorMargin = 4;
    [_pageControl rectForPageIndicator:5];
    

    [self addSubview:_scrollView];
    [self addSubview:_pageControl];

    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [_scrollView addGestureRecognizer:tapGestureRecognize];

    //objc_setAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addImageViews:imageItems];
}

#pragma mark-----添加带图片适应的视图
//2016.8.5 修改图片适应问题
-(void)addImageViews:(NSArray *)aImageItems contentMode:(UIViewContentMode)contentMode{
    //移除子视图
    for (UIView *lView in _scrollView.subviews) {
        [lView removeFromSuperview];
    }
    float space = 0;
    CGSize size = CGSizeMake(self.frame.size.width, 0);
    for (int i = 0; i < aImageItems.count; i++) {
        SGFocusImageItem *item = [aImageItems objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space-size.height)];
        //2016.8.5 修改图片拉伸问题
        imageView.contentMode = UIViewContentModeTop;
        NSURL *imageURL = [NSURL URLWithString:item.image];
        UIImage *defaultImage = [UIImage combineImage:[UIImage imageNamed:@"main_banner_default_img"] color:RGBCOLORV(0xdfe1e5) height:CGRectGetHeight(imageView.frame) width:CGRectGetWidth(imageView.frame)];
        
        [imageView sd_setImageWithURL:imageURL placeholderImage:defaultImage];
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * aImageItems.count, _scrollView.frame.size.height);
    _pageControl.numberOfPages = aImageItems.count>1?aImageItems.count -2:aImageItems.count;
    _pageControl.currentPage = 0;
    if ([aImageItems count]>1)
    {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO] ;
        if (_isAutoPlay)
        {
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        }
    }
}

#pragma mark 添加视图
-(void)addImageViews:(NSArray *)aImageItems{
    //移除子视图
    for (UIView *lView in _scrollView.subviews) {
        [lView removeFromSuperview];
    }
    
    float space = 0;
    CGSize size = CGSizeMake(self.frame.size.width, 0);
    for (int i = 0; i < aImageItems.count; i++) {
        SGFocusImageItem *item = [aImageItems objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width+space, space, _scrollView.frame.size.width-space*2, _scrollView.frame.size.height-2*space-size.height)];
        //2016.7.13 修改图片拉伸问题
        if (self.imageView.contentMode) {
            imageView.contentMode = self.imageView.contentMode;
        }
//        else {
//            imageView.contentMode = UIViewContentModeScaleAspectFill;
//        }
        //加载图片
//        imageView.backgroundColor = i%2?[UIColor redColor]:[UIColor blueColor];
        NSURL *imageURL = [NSURL URLWithString:item.image];
        UIImage *defaultImage = [UIImage combineImage:[UIImage imageNamed:@"main_banner_default_img"] color:RGBCOLORV(0xdfe1e5) height:CGRectGetHeight(imageView.frame) width:CGRectGetWidth(imageView.frame)];

        [imageView sd_setImageWithURL:imageURL placeholderImage:defaultImage];
        [_scrollView addSubview:imageView];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * aImageItems.count, _scrollView.frame.size.height);
    
    _pageControl.numberOfPages = aImageItems.count>1?aImageItems.count -2:aImageItems.count;
    _pageControl.currentPage = 0;
    
    if ([aImageItems count]>1)
    {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO] ;
        if (_isAutoPlay)
        {
            [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
        }
        
    }
}

#pragma mark 改变添加视图内容
-(void)changeImageViewsContent:(NSArray *)aArray{
    NSMutableArray *imageItems = [NSMutableArray arrayWithArray:aArray];
    objc_setAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addImageViews:imageItems];
}

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    NSArray *imageItems = objc_getAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY);
    targetX = (int)(targetX/self.frame.size.width) * self.frame.size.width;
    [self moveToTargetPosition:targetX];
    
    if ([imageItems count]>1 && _isAutoPlay)
    {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_FOCUS_PICTURE_INTERVAL];
    }
    
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __FUNCTION__);
    NSArray *imageItems = objc_getAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY);
    int page = (int)(_scrollView.contentOffset.x / _scrollView.frame.size.width);
    if (page > -1 && page < imageItems.count) {
        SGFocusImageItem *item = [imageItems objectAtIndex:page];
        if ([self.delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [self.delegate foucusImageFrame:self didSelectItem:item];
            
        }
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    //    NSLog(@"moveToTargetPosition : %f" , targetX);
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
    NSArray *imageItems = objc_getAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count]>=3)
    {
        if (targetX >= self.frame.size.width * ([imageItems count] -1)) {
            targetX = self.frame.size.width;
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = self.frame.size.width *([imageItems count]-2);
            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (_scrollView.contentOffset.x+self.frame.size.width/2.0) / self.frame.size.width;
    if ([imageItems count] > 1)
    {
        page --;
        if (page >= _pageControl.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = _pageControl.numberOfPages - 1;
        }
    }

    if (page!= _pageControl.currentPage)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(foucusImageFrame:currentItem:)])
        {
            [self.delegate foucusImageFrame:self currentItem:page];
        }
    }
    _pageControl.currentPage = page;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (int)(targetX/self.frame.size.width) * self.frame.size.width;
        [self moveToTargetPosition:targetX];
    }
}


- (void)scrollToIndex:(NSInteger)aIndex
{
    NSArray *imageItems = objc_getAssociatedObject(self, &SG_FOCUS_ITEM_ASS_KEY);
    if ([imageItems count]>1)
    {
        if (aIndex >= ([imageItems count] - 2))
        {
            aIndex = [imageItems count] - 3;
        }
        [self moveToTargetPosition:self.frame.size.width*(aIndex+1)];
    }else
    {
        [self moveToTargetPosition:0];
    }
    [self scrollViewDidScroll:_scrollView];
    
}


@end
