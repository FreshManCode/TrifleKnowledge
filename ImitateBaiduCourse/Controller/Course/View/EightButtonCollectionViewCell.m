//
//  EightButtonCollectionViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/1.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "EightButtonCollectionViewCell.h"

@interface EightButtonCollectionViewCell ()
@property (nonatomic,strong) UIButton *topButton;
@property (nonatomic,strong) UILabel  *bottomLabel;
@property (nonatomic,strong) UIView * bgView;

@end

@implementation EightButtonCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    _topButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, _bgView.width - 20, self.width - 20)];
    _topButton.layer.cornerRadius = _topButton.width / 2.0;
    [_topButton addTarget:self action:@selector(differentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _topButton.clipsToBounds = YES;
    [_bgView addSubview:_topButton];
    
    _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _topButton.bottom + 10, _topButton.width, 15)];
    _bottomLabel.font = Font(12.0f);
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.textColor = [UIColor lightGrayColor];
    _bottomLabel.text = @"测试的啊";
    [_bgView addSubview:_bottomLabel];
}

- (void)differentButtonClick:(UIButton *)sender {
    if (self.DidSelectedItem) {
        self.DidSelectedItem(sender.tag);
    }
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [_topButton setBackgroundImage:[[PhotoManager shareManager]getBundleImageWithName:_imageName] forState:UIControlStateNormal];
}

@end
