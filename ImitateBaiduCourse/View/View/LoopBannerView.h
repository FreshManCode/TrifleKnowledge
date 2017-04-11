//
//  LoopBannerView.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoopBannerView;
@protocol LoopBannerViewDelegate <NSObject>
@optional
- (void)didClickLoopBannerViewItemIndex:(int)index;


@end


@interface LoopBannerView : UIView

@property (nonatomic,strong) NSArray *loopImage;
@property (nonatomic,assign) id <LoopBannerViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame delegate:(id)delegate  imageArray:(NSArray *)imageArray;



@end
