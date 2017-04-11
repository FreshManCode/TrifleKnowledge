//
//  PlayMusicView.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/13.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayMusicViewDelegate <NSObject>

- (void)sliderValueChanged:(UISlider *)slider ;
- (void)sliderDragDone:(UISlider *)slider;

@end



@interface PlayMusicView : UIView

@property (nonatomic,assign) id <PlayMusicViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
