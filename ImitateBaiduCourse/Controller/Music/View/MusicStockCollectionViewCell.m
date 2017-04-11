//
//  MusicStockCollectionViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/10.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "MusicStockCollectionViewCell.h"

@interface MusicStockCollectionViewCell ()

@property (nonatomic,strong) UIImageView *introImage;
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation MusicStockCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}
- (void)setUpSubViews {
    if (!_introImage) {
        _introImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.width - 10, 170)];
        _introImage.layer.cornerRadius = 4.0f;
        _introImage.clipsToBounds = YES;
    }
    [self addSubview:_introImage];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _introImage.height - 35, _introImage.width - 30, 20)];
        _titleLab.font = [UIFont boldSystemFontOfSize:20.f];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = [UIColor whiteColor];
    }
    [self.introImage addSubview:_titleLab];
    
}

- (void)setModel:(MusicStockModel *)model {
    _model = model;
    self.introImage.image = [[PhotoManager shareManager]getBundleImageWithName:model.typeImageName];
    self.titleLab.text    = model.typeName;
}


@end
