//
//  CollectionViewCell.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/11/30.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "CollectionViewCell.h"
#import <YYKit.h>

@interface CollectionViewCell ()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) YYAnimatedImageView * goodsImage;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UILabel * label;

@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    [self addSubview:_bgView];
    
    if (!_goodsImage) {
        _goodsImage = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, self.width , self.width)];
        _goodsImage.backgroundColor = [UIColor redColor];
        _goodsImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self addSubview:_goodsImage];
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _goodsImage.bottom + 10, _goodsImage.width, 15)];
        _priceLabel.font = Font(14.0f);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.textColor = [UIColor redColor];
    }
    [self addSubview:_priceLabel];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _priceLabel.bottom + 10, _goodsImage.width, 15)];
        _titleLab.font = Font(14.0f);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = [UIColor lightGrayColor];
    }
    [self addSubview:_titleLab];
    
    _label = [UILabel new];
    _label.size = self.size;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"加载失败,点击重试";
    _label.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    _label.hidden = YES;
    _label.userInteractionEnabled = YES;
    [self.contentView addSubview:_label];
    
    __weak typeof(self) weakSelf = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf setImageURL:[NSURL URLWithString:_goodsModel.goods_image]];
    }];
    [_label addGestureRecognizer:tap];
    
}

- (void)setGoodsModel:(MainGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self setImageURL:[NSURL URLWithString:_goodsModel.goods_image]];
//    [_goodsImage setImageWithURL:[NSURL URLWithString:_goodsModel.goods_image] placeholder:PlaceHolder];
//    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:_goodsModel.goods_image] placeholderImage:PlaceHolder];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@元",_goodsModel.goods_price];
    _titleLab.text   = _goodsModel.goods_name;
}

- (void)setImageURL:(NSURL *)url {
    __weak typeof(self) weakSelf = self;
    [_goodsImage setImageWithURL:url
                     placeholder:PlaceHolder
                         options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation
                      completion:^(UIImage * image, NSURL * url, YYWebImageFromType from, YYWebImageStage stage, NSError * error) {
                          if (!image) {
                              weakSelf.label.hidden = NO;
                          }
    }];
}

@end
